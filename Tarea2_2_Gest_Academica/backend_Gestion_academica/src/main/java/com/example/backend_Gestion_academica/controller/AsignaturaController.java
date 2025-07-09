package com.example.backend_Gestion_academica.controller;

import com.example.backend_Gestion_academica.dto.AsignaturaDTO;
import com.example.backend_Gestion_academica.service.AsignaturaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/asignaturas")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class AsignaturaController {

    private final AsignaturaService asignaturaService;

    public AsignaturaController(AsignaturaService asignaturaService) {
        this.asignaturaService = asignaturaService;
    }

    //obtener todas las asignaturas
    @GetMapping
    public ResponseEntity<List<AsignaturaDTO>> obtenerTodas() {
        List<AsignaturaDTO> asignaturas = asignaturaService.obtenerTodas();
        return ResponseEntity.ok(asignaturas);
    }

    //obtener una asignatura por ID
    @GetMapping("/{id}")
    public ResponseEntity<AsignaturaDTO> obtenerPorId(Long id) {
        AsignaturaDTO asignatura = asignaturaService.obtenerPorId(id);
        return ResponseEntity.ok(asignatura);
    }

    //metodo para crear una nueva asignatura
    @PostMapping
    public ResponseEntity<AsignaturaDTO> crearAsignatura(@RequestBody AsignaturaDTO asignaturaDTO) {
        AsignaturaDTO nuevaAsignatura = asignaturaService.crearAsignatura(asignaturaDTO);
        return ResponseEntity.status(201).body(nuevaAsignatura);
    }

    //metodo para actualizar una asignatura
    @PutMapping("/{id}")
    public ResponseEntity<AsignaturaDTO> actualizarAsignatura(@PathVariable Long id, @RequestBody AsignaturaDTO asignaturaDTO) {
        AsignaturaDTO asignaturaActualizada = asignaturaService.actualizarAsignatura(id, asignaturaDTO);
        return ResponseEntity.ok(asignaturaActualizada);
    }

    //metodo para eliminar una asignatura
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarAsignatura(@PathVariable Long id) {
        asignaturaService.eliminarAsignatura(id);
        return ResponseEntity.noContent().build();
    }
}