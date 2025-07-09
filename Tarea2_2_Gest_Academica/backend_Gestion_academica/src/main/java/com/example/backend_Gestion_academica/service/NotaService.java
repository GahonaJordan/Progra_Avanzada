package com.example.backend_Gestion_academica.service;

import com.example.backend_Gestion_academica.dto.NotasDTO;
import com.example.backend_Gestion_academica.model.Alumno;
import com.example.backend_Gestion_academica.model.Asignatura;
import com.example.backend_Gestion_academica.model.Nota;
import com.example.backend_Gestion_academica.repository.AlumnoRepository;
import com.example.backend_Gestion_academica.repository.AsignaturaRepository;
import com.example.backend_Gestion_academica.repository.NotaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class NotaService {

    //inyeccion de dependencias
    private final NotaRepository notaRepository;
    private final AsignaturaRepository asignaturaRepository;
    private final AlumnoRepository alumnoRepository;
    // Constructor para inyectar el repositorio de notas

    public NotaService(NotaRepository notaRepository, AlumnoRepository alumnoRepository,AsignaturaRepository asignaturaRepository) {
        this.notaRepository = notaRepository;
        this.asignaturaRepository = asignaturaRepository;
        this.alumnoRepository = alumnoRepository;
    }

    // Método para obtener todas las notas
    public List<NotasDTO> obtenerTodas() {
        return notaRepository.findAll().stream()
                // Convertir cada Nota a NotasDTO
                .map(nota -> new NotasDTO(
                        nota.getId(),
                        nota.getValor(),
                        nota.getAlumno().getId(),
                        nota.getAsignatura().getId()

                ))
                .toList();
    }

    // Método para obtener una nota por ID
    public NotasDTO obtenerPorId(Long id) {
        Nota nota = notaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Nota no encontrada con ID: " + id));
        return new NotasDTO(
                nota.getId(),
                nota.getValor(),
                nota.getAsignatura().getId(),
                nota.getAlumno().getId()
        );
    }

    // Método para obtener notas por alumno ID
    // NotaService.java
    public List<NotasDTO> obtenerNotasPorAlumno(Long alumnoId) {
        return notaRepository.findByAlumnoId(alumnoId)
                .stream()
                .map(nota -> new NotasDTO(
                        nota.getId(),
                        nota.getValor(),
                        nota.getAlumno().getId(),
                        nota.getAsignatura().getId()

                ))
                .collect(Collectors.toList());
    }

    // Método para crear una nueva nota
    public NotasDTO crearNota(NotasDTO notasDTO) {
        Nota nuevaNota = new Nota();
        nuevaNota.setValor(notasDTO.getValor());
        // Buscar y asignar la asignatura
        Asignatura asignatura = asignaturaRepository.findById(notasDTO.getAsignaturaId())
                .orElseThrow(() -> new RuntimeException("Asignatura no encontrada"));
        nuevaNota.setAsignatura(asignatura);
        // Buscar y asignar el alumno
        Alumno alumno = alumnoRepository.findById(notasDTO.getAlumnoId())
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado"));
        nuevaNota.setAlumno(alumno);

        notaRepository.save(nuevaNota);
        return obtenerPorId(nuevaNota.getId());
    }

    // Método para actualizar una nota
    public NotasDTO actualizarNota(Long id, NotasDTO notasDTO) {
        Nota notaExistente = notaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Nota no encontrada con ID: " + id));

        notaExistente.setValor(notasDTO.getValor());

        // Actualizar asignatura
        Asignatura asignatura = asignaturaRepository.findById(notasDTO.getAsignaturaId())
                .orElseThrow(() -> new RuntimeException("Asignatura no encontrada"));
        notaExistente.setAsignatura(asignatura);

        // Actualizar alumno
        Alumno alumno = alumnoRepository.findById(notasDTO.getAlumnoId())
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado"));
        notaExistente.setAlumno(alumno);

        notaRepository.save(notaExistente);
        return obtenerPorId(notaExistente.getId());
    }

    // Método para eliminar una nota
    public void eliminarNota(Long id) {
        Nota nota = notaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Nota no encontrada con ID: " + id));
        notaRepository.delete(nota);
    }
}
