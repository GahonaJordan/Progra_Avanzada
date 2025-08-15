// src/test/java/com/example/api_operaciones/basica/service/UsuarioServiceTest.java
package com.example.api_operaciones.basica.service;

import com.example.api_operaciones.basica.DTO.UsuarioDTO;
import com.example.api_operaciones.basica.Model.Usuario;
import com.example.api_operaciones.basica.Repository.UsuarioRepository;
import com.example.api_operaciones.basica.SERVICE.UsuarioService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Optional;
import java.lang.reflect.Field;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class UsuarioServiceTest {

    private UsuarioRepository usuarioRepository;
    private PasswordEncoder passwordEncoder;
    private UsuarioService usuarioService;

    @BeforeEach
    void setUp() throws Exception {
        usuarioRepository = mock(UsuarioRepository.class);
        passwordEncoder = mock(PasswordEncoder.class);
        usuarioService = new UsuarioService();

        // Inyectar los mocks usando reflexión
        Field repoField = UsuarioService.class.getDeclaredField("usuarioRepository");
        repoField.setAccessible(true);
        repoField.set(usuarioService, usuarioRepository);

        Field encoderField = UsuarioService.class.getDeclaredField("passwordEncoder");
        encoderField.setAccessible(true);
        encoderField.set(usuarioService, passwordEncoder);
    }

    @Test
    void testRegistrarUsuario() {
        UsuarioDTO dto = new UsuarioDTO();
        dto.setNombre("Jordan");
        dto.setApellido("Gahona");
        dto.setEmail("jordan@mail.com");
        dto.setUserName("jordan");
        dto.setPassword("1234");

        when(usuarioRepository.findByUserName("jordan")).thenReturn(Optional.empty());
        when(passwordEncoder.encode("1234")).thenReturn("hashed1234");
        when(usuarioRepository.save(any(Usuario.class))).thenAnswer(i -> i.getArguments()[0]);

        Usuario usuario = usuarioService.registrarUsuario(dto);

        assertEquals("Jordan", usuario.getNombre());
        assertEquals("hashed1234", usuario.getPassword());
        verify(usuarioRepository).save(any(Usuario.class));
    }

    @Test
    void testRegistrarUsuarioExistente() {
        UsuarioDTO dto = new UsuarioDTO();
        dto.setUserName("jordan");
        when(usuarioRepository.findByUserName("jordan")).thenReturn(Optional.of(new Usuario()));

        assertThrows(RuntimeException.class, () -> usuarioService.registrarUsuario(dto));
    }

    @Test
    void testLoadUserByUsername_UsuarioExiste() {
        Usuario usuario = new Usuario();
        usuario.setUserName("jordan");
        usuario.setPassword("123");
        when(usuarioRepository.findByUserName("jordan")).thenReturn(Optional.of(usuario));

        UserDetails userDetails = usuarioService.loadUserByUsername("jordan");

        assertEquals("jordan", userDetails.getUsername());
        assertEquals("123", userDetails.getPassword());
    }

    @Test
    void testLoadUserByUsername_UsuarioNoExiste() {
        when(usuarioRepository.findByUserName("noexiste")).thenReturn(Optional.empty());

        assertThrows(UsernameNotFoundException.class, () -> usuarioService.loadUserByUsername("noexiste"));
    }
}