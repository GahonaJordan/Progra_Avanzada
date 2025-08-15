package com.example.proyecto_clinica.CONFIG;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults()) // <---- Habilita CORS desde CorsConfig
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/citas").permitAll()
                        .requestMatchers("/api/consultorios").permitAll()
                        .requestMatchers("/api/medicos/consultorios/{id}").permitAll()
                        .requestMatchers("/api/medicos/{id}").permitAll()
                        .requestMatchers("/api/pacientes/{id}").permitAll()
                        .requestMatchers("/api/medicos").permitAll()
                        .requestMatchers("/api/pacientes").permitAll()
                        .requestMatchers("/api/usuarios/register").permitAll()
                        .requestMatchers("/api/usuarios/admin/register").permitAll()
                        .anyRequest().authenticated())
                .httpBasic(httpBasic -> {});


        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManager.class);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
