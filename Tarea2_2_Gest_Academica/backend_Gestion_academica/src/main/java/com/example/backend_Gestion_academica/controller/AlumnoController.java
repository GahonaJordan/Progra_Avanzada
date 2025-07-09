package com.example.backend_Gestion_academica.controller;

import com.example.backend_Gestion_academica.dto.AlumnoDTO;
import com.example.backend_Gestion_academica.repository.AlumnoRepository;
import com.example.backend_Gestion_academica.service.AlumnoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alumnos")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class AlumnoController {

    private final AlumnoService alumnoService;

    public AlumnoController(AlumnoService alumnoService) {
        this.alumnoService = alumnoService;
    }

    //obtener todos los alumnos
    @GetMapping
    public ResponseEntity<List<AlumnoDTO>> obtenerTodos() {
        List<AlumnoDTO> alumnos = alumnoService.obtenerTodos();
        return ResponseEntity.ok(alumnos);
    }

    //obtener un alumno por ID
    @GetMapping("/{id}")
    public ResponseEntity<AlumnoDTO> obtenerPorId(Long id) {
        AlumnoDTO alumno = alumnoService.obtenerPorId(id);
        return ResponseEntity.ok(alumno);
    }

    //metodo para crear un nuevo alumno
    @PostMapping
    public ResponseEntity<AlumnoDTO> crearAlumno(@RequestBody AlumnoDTO alumnoDTO){
        AlumnoDTO nuevoAlumno = alumnoService.crearAlumno(alumnoDTO);
        return ResponseEntity.status(201).body(nuevoAlumno);
    }

    //metodo para actualizar un alumno
    @PutMapping("/{id}")
    public ResponseEntity<AlumnoDTO> actualizarAlumno(@PathVariable Long id, @RequestBody AlumnoDTO alumnoDTO) {
        AlumnoDTO alumnoActualizado = alumnoService.actualizarAlumno(id, alumnoDTO);
        return ResponseEntity.ok(alumnoActualizado);
    }

    //metodo para eliminar un alumno
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarAlumno(@PathVariable Long id) {
        alumnoService.eliminarAlumno(id);
        return ResponseEntity.noContent().build();
    }
}
