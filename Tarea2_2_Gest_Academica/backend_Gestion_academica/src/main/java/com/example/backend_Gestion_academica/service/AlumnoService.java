package com.example.backend_Gestion_academica.service;

import com.example.backend_Gestion_academica.dto.AlumnoDTO;
import com.example.backend_Gestion_academica.model.Alumno;
import com.example.backend_Gestion_academica.model.Nota;
import com.example.backend_Gestion_academica.repository.AlumnoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AlumnoService {

    //inyeccion de dependencias
    private final AlumnoRepository alumnoRepository;
    // Constructor para inyectar el repositorio
    public AlumnoService(AlumnoRepository alumnoRepository) {
        this.alumnoRepository = alumnoRepository;
    }

    //obtener todos los alumnos
    public List<AlumnoDTO> obtenerTodos(){
        return alumnoRepository.findAll().stream()
                // Convertir cada Alumno a AlumnoDTO
                .map(alumno -> new AlumnoDTO(
                        alumno.getId(),
                        alumno.getNombre(),
                        alumno.getApellido(),
                        alumno.getEmail(),
                        alumno.getTelefono(),
                        alumno.getDireccion(),
                        alumno.getFechaNacimiento(),
                        alumno.getGenero(),
                        alumno.getEstadoCivil(),
                        alumno.getNacionalidad(),
                        // Obtener los IDs de las asignaturas asociadas al alumno
                        alumno.getNotas() != null ?
                                alumno.getNotas().stream()
                                        .map(n -> n.getAsignatura().getId())
                                        .collect(Collectors.toList())
                                : List.of(),
                        // Obtener los IDs de las notas asociadas al alumno
                        alumno.getNotas() != null ?
                                alumno.getNotas().stream()
                                        .map(Nota::getId)
                                        .collect(Collectors.toList())
                                : List.of()

                ))
                .collect(Collectors.toList());
    }

    //obtener un alumno por ID
    public AlumnoDTO obtenerPorId(Long id) {
        Alumno alumno = alumnoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado con ID: " + id));
        List<Long> asignaturaIds = alumno.getNotas() != null ?
                alumno.getNotas().stream()
                        .map(n -> n.getAsignatura().getId())
                        .collect(Collectors.toList())
                : List.of(),
                notaIds = alumno.getNotas() != null ?
                        alumno.getNotas().stream()
                                .map(Nota::getId)
                                .collect(Collectors.toList())
                        : List.of();
        return new AlumnoDTO(
                alumno.getId(),
                alumno.getNombre(),
                alumno.getApellido(),
                alumno.getEmail(),
                alumno.getTelefono(),
                alumno.getDireccion(),
                alumno.getFechaNacimiento(),
                alumno.getGenero(),
                alumno.getEstadoCivil(),
                alumno.getNacionalidad(),
                asignaturaIds,
                notaIds
        );
    }

    //metodo para crear un nuevo alumno
    public AlumnoDTO crearAlumno(AlumnoDTO alumnoDTO) {
        Alumno nuevoAlumno = new Alumno();
        nuevoAlumno.setNombre(alumnoDTO.getNombreCompleto().split(" ")[0]);
        nuevoAlumno.setApellido(alumnoDTO.getNombreCompleto().split(" ")[1]);
        nuevoAlumno.setEmail(alumnoDTO.getEmail());
        nuevoAlumno.setTelefono(alumnoDTO.getTelefono());
        nuevoAlumno.setDireccion(alumnoDTO.getDireccion());
        nuevoAlumno.setFechaNacimiento(alumnoDTO.getFechaNacimiento());
        nuevoAlumno.setGenero(alumnoDTO.getGenero());
        nuevoAlumno.setEstadoCivil(alumnoDTO.getEstadoCivil());
        nuevoAlumno.setNacionalidad(alumnoDTO.getNacionalidad());

        alumnoRepository.save(nuevoAlumno);
        // Llamar a obtenerPorId para que retorne el alumno con las asignaturas y notas asociadas
        return obtenerPorId(nuevoAlumno.getId());
    }

    //metodo para actualizar o modificar un alumno
    public AlumnoDTO actualizarAlumno(Long id, AlumnoDTO alumnoDTO) {
        Alumno alumnoExistente = alumnoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado con ID: " + id));

        alumnoExistente.setNombre(alumnoDTO.getNombreCompleto().split(" ")[0]);
        alumnoExistente.setApellido(alumnoDTO.getNombreCompleto().split(" ")[1]);
        alumnoExistente.setEmail(alumnoDTO.getEmail());
        alumnoExistente.setTelefono(alumnoDTO.getTelefono());
        alumnoExistente.setDireccion(alumnoDTO.getDireccion());
        alumnoExistente.setFechaNacimiento(alumnoDTO.getFechaNacimiento());
        alumnoExistente.setGenero(alumnoDTO.getGenero());
        alumnoExistente.setEstadoCivil(alumnoDTO.getEstadoCivil());
        alumnoExistente.setNacionalidad(alumnoDTO.getNacionalidad());

        alumnoRepository.save(alumnoExistente);
        // Llamar a obtenerPorId para que retorne el alumno con las asignaturas y notas asociadas
        return obtenerPorId(alumnoExistente.getId());
    }

    //metodo para eliminar un alumno
    public void eliminarAlumno(Long id) {
        Alumno alumno = alumnoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado con ID: " + id));
        alumnoRepository.delete(alumno);
    }

}
