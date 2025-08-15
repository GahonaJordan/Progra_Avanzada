package com.example.api_operaciones.basica.SERVICE;

import com.example.api_operaciones.basica.DTO.UsuarioDTO;
import com.example.api_operaciones.basica.Model.Usuario;
import com.example.api_operaciones.basica.Repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    //Ver los usuarios registrados
    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByUserName(userName)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        return new org.springframework.security.core.userdetails.User(
                usuario.getUserName(),
                usuario.getPassword(),
                List.of() // Sin roles
        );
    }

    //Registrar un usuario
    public Usuario registrarUsuario(UsuarioDTO dto){
        if (usuarioRepository.findByUserName(dto.getUserName()).isPresent()) {
            throw new RuntimeException("El nombre de usuario ya existe");
        }

        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(dto.getNombre());
        nuevoUsuario.setApellido(dto.getApellido());
        nuevoUsuario.setEmail(dto.getEmail());
        nuevoUsuario.setUserName(dto.getUserName());
        nuevoUsuario.setPassword(passwordEncoder.encode(dto.getPassword()));

        return usuarioRepository.save(nuevoUsuario);
    }
}
