package com.example.proyecto_clinica.CONTROLLER;

import com.example.proyecto_clinica.DTO.PacienteEntradaDTO;
import com.example.proyecto_clinica.DTO.PacienteSalidaDTO;
import com.example.proyecto_clinica.MODEL.Paciente;
import com.example.proyecto_clinica.SERVICE.PacienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pacientes")
public class PacienteController {

    @Autowired
    private PacienteService pacienteService;

    // Listar pacientes
    @GetMapping
    public List<PacienteSalidaDTO> listarPacientes() {
        return pacienteService.listarPacientes();
    }

    // Buscar paciente por ID
    @GetMapping("/{id}")
    public ResponseEntity<PacienteSalidaDTO> obtenerPacientePorId(@PathVariable Long id){
        return pacienteService.buscarPacientePorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Guardar paciente
    @PostMapping
    public ResponseEntity<PacienteSalidaDTO> guardarPaciente(@RequestBody PacienteEntradaDTO paciente) {
        PacienteSalidaDTO nuevoPaciente = pacienteService.crearPaciente(paciente);
        return ResponseEntity.ok(nuevoPaciente);
    }

    // Actualizar paciente
    @PutMapping("/{id}")
    public ResponseEntity<PacienteSalidaDTO> actualizarPaciente(@PathVariable Long id, @RequestBody PacienteEntradaDTO paciente) {
        return pacienteService.actualizarPaciente(id, paciente)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Eliminar paciente
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPaciente(@PathVariable Long id) {
        if (pacienteService.eliminarPaciente(id)) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
