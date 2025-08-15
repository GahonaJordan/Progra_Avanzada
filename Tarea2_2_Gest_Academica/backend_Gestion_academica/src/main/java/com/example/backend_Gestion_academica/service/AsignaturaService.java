package com.example.backend_Gestion_academica.service;

import com.example.backend_Gestion_academica.dto.AsignaturaDTO;
import com.example.backend_Gestion_academica.model.Asignatura;
import com.example.backend_Gestion_academica.repository.AsignaturaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AsignaturaService {
    //loco
    //el jordan
    // bbbb

    //inyeccion de dependencias
    private final AsignaturaRepository asignaturaRepository;
    // Constructor para inyectar el repositorio
    public AsignaturaService(AsignaturaRepository asignaturaRepository) {
        this.asignaturaRepository = asignaturaRepository;
    }

    //obtener todas las asignaturas
    public List<AsignaturaDTO> obtenerTodas() {
        return asignaturaRepository.findAll().stream()
                // Convertir cada Asignatura a AsignaturaDTO
                .map(asignatura -> new AsignaturaDTO(
                        asignatura.getId(),
                        asignatura.getNombre(),
                        asignatura.getDescripcion(),
                        asignatura.getCreditos(),
                        asignatura.getSemestre(),
                        asignatura.getProfesor()
                ))
                .collect(Collectors.toList());
    }

    //obtener una asignatura por ID
    public AsignaturaDTO obtenerPorId(Long id) {
        Asignatura asignatura = asignaturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Asignatura no encontrada con ID: " + id));
        return new AsignaturaDTO(
                asignatura.getId(),
                asignatura.getNombre(),
                asignatura.getDescripcion(),
                asignatura.getCreditos(),
                asignatura.getSemestre(),
                asignatura.getProfesor()
        );
    }

    //metodo para crear una nueva asignatura
    public AsignaturaDTO crearAsignatura(AsignaturaDTO asignaturaDTO) {
        Asignatura nuevaAsignatura = new Asignatura();
        nuevaAsignatura.setNombre(asignaturaDTO.getNombre());
        nuevaAsignatura.setDescripcion(asignaturaDTO.getDescripcion());
        nuevaAsignatura.setCreditos(asignaturaDTO.getCreditos());
        nuevaAsignatura.setSemestre(asignaturaDTO.getSemestre());
        nuevaAsignatura.setProfesor(asignaturaDTO.getProfesor());

        asignaturaRepository.save(nuevaAsignatura);
        //Llamar a obtenerPorId para devolver el DTO de la nueva asignatura
        return obtenerPorId(nuevaAsignatura.getId());
    }

    //metodo para actualizar una asignatura
    public AsignaturaDTO actualizarAsignatura(Long id, AsignaturaDTO asignaturaDTO) {
        Asignatura asignaturaExistente = asignaturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Asignatura no encontrada con ID: " + id));

        // Actualizar los campos de la asignatura existente
        asignaturaExistente.setNombre(asignaturaDTO.getNombre());
        asignaturaExistente.setDescripcion(asignaturaDTO.getDescripcion());
        asignaturaExistente.setCreditos(asignaturaDTO.getCreditos());
        asignaturaExistente.setSemestre(asignaturaDTO.getSemestre());
        asignaturaExistente.setProfesor(asignaturaDTO.getProfesor());

        asignaturaRepository.save(asignaturaExistente);
        //Llamar a obtenerPorId para devolver el DTO actualizado
        return obtenerPorId(asignaturaExistente.getId());
    }

    //metodo para eliminar una asignatura
    public void eliminarAsignatura(Long id) {
        Asignatura asignatura = asignaturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Asignatura no encontrada con ID: " + id));
        asignaturaRepository.delete(asignatura);
    }
}
