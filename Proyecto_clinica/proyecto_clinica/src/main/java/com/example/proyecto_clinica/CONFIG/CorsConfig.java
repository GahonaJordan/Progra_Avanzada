package com.example.proyecto_clinica.CONFIG;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    // 📌 Lista de orígenes permitidos (puedes definirlos en application.properties)
    @Value("${app.frontend.urls:http://localhost:3000,https://midominio.com,http://localhost:5173}")
    private String[] frontendUrls;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 🔹 Aplica CORS a todos los endpoints
                .allowedOrigins(frontendUrls) // 🔹 Permite varios orígenes definidos en el array
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 🔹 Métodos HTTP permitidos
                .allowedHeaders("*") // 🔹 Cualquier header permitido
                .allowCredentials(true); // 🔹 Permite cookies/autenticación si es necesario
    }
}


