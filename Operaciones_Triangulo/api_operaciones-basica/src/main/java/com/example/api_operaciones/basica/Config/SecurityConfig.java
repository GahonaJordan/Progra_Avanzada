package com.example.api_operaciones.basica.Config;

import com.example.api_operaciones.basica.SERVICE.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import static org.springframework.security.config.Customizer.withDefaults;


@Configuration
public class SecurityConfig {


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .cors(withDefaults()) // <---- Habilita CORS desde CorsConfig
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/usuarios/registro").permitAll()
                        .requestMatchers("/api/triangulos/identificar").permitAll()
                        .requestMatchers("/api/operaciones/sumar").permitAll()
                        .requestMatchers("/api/operaciones/restar").permitAll()
                        .requestMatchers("/api/operaciones/multiplicar").permitAll()
                        .requestMatchers("/api/operaciones/dividir").permitAll()
                        .requestMatchers("/api/operaciones/dividir/**").permitAll()
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
