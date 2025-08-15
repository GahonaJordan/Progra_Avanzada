package com.example.proyecto_clinica.REPOSITORY;

import com.example.proyecto_clinica.MODEL.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByUserName(String userName);
}
