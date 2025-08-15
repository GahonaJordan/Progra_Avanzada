package com.example.proyecto_clinica.CONTROLLER;

import com.example.proyecto_clinica.DTO.MedicoEntradaDTO;
import com.example.proyecto_clinica.DTO.MedicoSalidaDTO;
import com.example.proyecto_clinica.SERVICE.MedicoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/medicos")
public class MedicoController {

    @Autowired
    private MedicoService medicoService;

    // Listar médicos
    @GetMapping
    public List<MedicoSalidaDTO> listarMedicos() {
        return medicoService.listarMedicos();
    }

    // Buscar médico por ID
    @GetMapping("/{id}")
    public ResponseEntity <MedicoSalidaDTO> obtenerMedicoPorId(@PathVariable Long id) {
        return medicoService.buscarMedicoPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Guardar médico
    @PostMapping
    public ResponseEntity<MedicoSalidaDTO> guardarMedico(@RequestBody MedicoEntradaDTO medico) {
        MedicoSalidaDTO nuevoMedico = medicoService.crearMedico(medico);
        return ResponseEntity.ok(nuevoMedico);
    }

    // Actualizar médico
    @PutMapping("/{id}")
    public ResponseEntity<MedicoSalidaDTO> actualizarMedico(@PathVariable Long id, @RequestBody MedicoEntradaDTO medico) {
        return medicoService.actualizarMedico(id, medico)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Eliminar médico
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarMedico(@PathVariable Long id) {
        if (medicoService.eliminarMedico(id)) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
