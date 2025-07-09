package com.example.backend_Gestion_academica.repository;

import com.example.backend_Gestion_academica.model.Nota;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotaRepository extends JpaRepository<Nota, Long> {
    List<Nota> findByAlumnoId(Long alumnoId);
}
