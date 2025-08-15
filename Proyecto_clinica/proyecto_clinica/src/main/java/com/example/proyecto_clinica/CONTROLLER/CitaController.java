package com.example.proyecto_clinica.CONTROLLER;

import com.example.proyecto_clinica.DTO.CitasEntradaDTO;
import com.example.proyecto_clinica.DTO.CitasSalidaDTO;
import com.example.proyecto_clinica.SERVICE.CitaService;
import com.example.proyecto_clinica.SERVICE.ConsultorioService;
import com.example.proyecto_clinica.SERVICE.MedicoService;
import com.example.proyecto_clinica.SERVICE.PacienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/citas")
public class CitaController {

    @Autowired
    private CitaService citaService;

    @Autowired
    private PacienteService pacienteService;

    @Autowired
    private MedicoService medicoService;

    @Autowired
    private ConsultorioService consultorioService;

    // Listar todas las citas
    @GetMapping
    public List<CitasSalidaDTO> listarCitas() {
        return citaService.listarCitas();
    }

    // Buscar cita por ID
    @GetMapping("/{id}")
    public ResponseEntity<CitasSalidaDTO> obtenerCitaPorId(@PathVariable Long id){
        return citaService.buscarCitaPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Guardar una nueva cita
    @PostMapping
    public ResponseEntity<CitasSalidaDTO> crearCita(@RequestBody CitasEntradaDTO citas) {
        CitasSalidaDTO nuevaCita = citaService.crearCita(citas);
        return ResponseEntity.ok(nuevaCita);
    }

    // Actualizar una cita existente
    @PutMapping("/{id}")
    public ResponseEntity<CitasSalidaDTO> actualizarCita(@PathVariable Long id, @RequestBody CitasEntradaDTO citas){
        return citaService.actualizarCita(id, citas)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Eliminar una cita
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarCita(@PathVariable Long id) {
        if (citaService.eliminarCita(id)) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
