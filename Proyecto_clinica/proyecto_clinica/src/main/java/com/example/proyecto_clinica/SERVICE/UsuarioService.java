package com.example.proyecto_clinica.SERVICE;

import com.example.proyecto_clinica.DTO.UsuarioDTO;
import com.example.proyecto_clinica.MODEL.Rol;
import com.example.proyecto_clinica.MODEL.Usuario;
import com.example.proyecto_clinica.REPOSITORY.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
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

        // Asignar el rol como autoridad
        String authority = "ROLE_" + usuario.getRol().name();
        return new org.springframework.security.core.userdetails.User(
                usuario.getUserName(),
                usuario.getPassword(),
                List.of(new org.springframework.security.core.authority.SimpleGrantedAuthority(authority))
        );
    }

    //Registrar un usuario
    public Usuario registrarUsuario(UsuarioDTO dto, String rolActualUsuario) {
        if (usuarioRepository.findByUserName(dto.getUserName()).isPresent()) {
            throw new RuntimeException("El nombre de usuario ya existe");
        }

        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setUserName(dto.getUserName());
        nuevoUsuario.setPassword(passwordEncoder.encode(dto.getPassword()));

        if ("ADMIN".equals(rolActualUsuario)) {
            // El admin puede asignar cualquier rol del DTO
            nuevoUsuario.setRol(dto.getRol());
        } else {
            // Registro público → siempre paciente
            nuevoUsuario.setRol(Rol.PACIENTE);
        }

        return usuarioRepository.save(nuevoUsuario);
    }

    public Usuario obtenerPorUserName(String userName) {
        return usuarioRepository.findByUserName(userName)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }

}
