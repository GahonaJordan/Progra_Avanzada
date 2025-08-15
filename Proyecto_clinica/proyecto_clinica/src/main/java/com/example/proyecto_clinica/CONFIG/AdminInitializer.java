package com.example.proyecto_clinica.CONFIG;

import com.example.proyecto_clinica.MODEL.Rol;
import com.example.proyecto_clinica.MODEL.Usuario;
import com.example.proyecto_clinica.REPOSITORY.UsuarioRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class AdminInitializer {

    @Bean
    public CommandLineRunner initAdmin(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            if (usuarioRepository.findByUserName("admin").isEmpty()) {
                Usuario admin = new Usuario();
                admin.setUserName("admin");
                admin.setPassword(passwordEncoder.encode("admin123"));
                admin.setRol(Rol.ADMIN);
                usuarioRepository.save(admin);
                System.out.println("✅ Usuario ADMIN creado: admin / admin123");
            }
        };
    }
}