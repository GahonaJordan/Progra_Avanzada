package com.example.backend_Gestion_academica.repository;

import com.example.backend_Gestion_academica.model.Alumno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlumnoRepository extends JpaRepository<Alumno, Long> {
}
