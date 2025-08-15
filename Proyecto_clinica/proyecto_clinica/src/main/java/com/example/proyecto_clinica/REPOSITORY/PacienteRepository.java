package com.example.proyecto_clinica.REPOSITORY;

import com.example.proyecto_clinica.MODEL.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PacienteRepository extends JpaRepository<Paciente, Long> {
}
