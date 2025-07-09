package com.example.backend_Gestion_academica.controller;

import com.example.backend_Gestion_academica.dto.NotasDTO;
import com.example.backend_Gestion_academica.service.NotaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/nota")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class NotaController {

    private final NotaService notaService;

    public NotaController(NotaService notaService) {
        this.notaService = notaService;
    }

    //obtener todas las notas
    @GetMapping
    public ResponseEntity<List<NotasDTO>> obtenerTodas() {
        List<NotasDTO> notas = notaService.obtenerTodas();
        return ResponseEntity.ok(notas);
    }

    //obtener una nota por ID
    @GetMapping("/{id}")
    public ResponseEntity<NotasDTO> obtenerPorId(Long id) {
        NotasDTO nota = notaService.obtenerPorId(id);
        return ResponseEntity.ok(nota);
    }

    //obtener notas por alumno ID
    @GetMapping("/alumno/{alumnoId}")
    public ResponseEntity<List<NotasDTO>> obtenerNotasPorAlumno(@PathVariable Long alumnoId) {
        List<NotasDTO> notas = notaService.obtenerNotasPorAlumno(alumnoId);
        return ResponseEntity.ok(notas);
    }

    //metodo para crear una nueva nota
    @PostMapping
    public ResponseEntity<NotasDTO> crearNota(@RequestBody NotasDTO notasDTO) {
        NotasDTO nuevaNota = notaService.crearNota(notasDTO);
        return ResponseEntity.status(201).body(nuevaNota);
    }

    //metodo para actualizar una nota
    @PutMapping("/{id}")
    public ResponseEntity<NotasDTO> actualizarNota(@PathVariable Long id, @RequestBody NotasDTO notasDTO) {
        NotasDTO notaActualizada = notaService.actualizarNota(id, notasDTO);
        return ResponseEntity.ok(notaActualizada);
    }

    //metodo para eliminar una nota
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarNota(@PathVariable Long id) {
        notaService.eliminarNota(id);
        return ResponseEntity.noContent().build();
    }
}
