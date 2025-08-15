package com.example.proyecto_clinica.CONTROLLER;

import com.example.proyecto_clinica.DTO.ConsultoriosEntradaDTO;
import com.example.proyecto_clinica.DTO.ConsultoriosSalidaDTO;
import com.example.proyecto_clinica.SERVICE.ConsultorioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/consultorios")
public class ConsultorioController {

    @Autowired
    private ConsultorioService consultorioService;

    // Listar todos los consultorios
    @GetMapping
    public List<ConsultoriosSalidaDTO> listarConsultorios() {
        return consultorioService.listarConsultorios();
    }

    // Buscar consultorio por ID
    @GetMapping("/{id}")
    public ResponseEntity<ConsultoriosSalidaDTO> obtenerConsultorioPorId(@PathVariable Long id) {
        return consultorioService.obtenerConsultorioPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Guardar un nuevo consultorio
    @PostMapping
    public ResponseEntity<ConsultoriosSalidaDTO> crearConsultorio(@RequestBody ConsultoriosEntradaDTO dto) {
        ConsultoriosSalidaDTO nuevoConsultorio = consultorioService.crearConsultorio(dto);
        return ResponseEntity.ok(nuevoConsultorio);
    }

    // Actualizar un consultorio existente
    @PutMapping("/{id}")
    public ResponseEntity<ConsultoriosSalidaDTO> actualizarConsultorio(@PathVariable Long id, @RequestBody ConsultoriosEntradaDTO dto) {
        return consultorioService.actualizarConsultorio(id, dto)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Eliminar un consultorio por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarConsultorio(@PathVariable Long id) {
        if(consultorioService.eliminarConsultorio(id)) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
