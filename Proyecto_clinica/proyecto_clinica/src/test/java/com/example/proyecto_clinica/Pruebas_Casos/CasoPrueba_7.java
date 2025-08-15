package com.example.proyecto_clinica.Pruebas_Casos;

import static org.junit.jupiter.api.Assertions.*;

import com.example.proyecto_clinica.MODEL.Citas;
import com.example.proyecto_clinica.MODEL.Consultorios;
import com.example.proyecto_clinica.MODEL.Medico;
import com.example.proyecto_clinica.MODEL.Paciente;
import com.example.proyecto_clinica.REPOSITORY.CitasRepository;
import com.example.proyecto_clinica.REPOSITORY.ConsultoriosRepository;
import com.example.proyecto_clinica.REPOSITORY.MedicoRepository;
import com.example.proyecto_clinica.REPOSITORY.PacienteRepository;
import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.Date;
import java.sql.Time;
import java.util.Optional;

@SpringBootTest
@Transactional
public class CasoPrueba_7 {

    @Autowired
    private PacienteRepository pacienteRepository;
    @Autowired
    private MedicoRepository medicoRepository;
    @Autowired
    private ConsultoriosRepository consultorioRepository;
    @Autowired
    private CitasRepository citasRepository;

    private Paciente crearPaciente() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Juan");
        paciente.setApellido("Pérez");
        paciente.setFechaNacimiento(new Date(System.currentTimeMillis()));
        return pacienteRepository.save(paciente);
    }

    private Medico crearMedico() {
        Medico medico = new Medico();
        medico.setNombre("Dra. María");
        medico.setApellido("López");
        medico.setEspecialidad("Cardiología");
        return medicoRepository.save(medico);
    }

    private Consultorios crearConsultorio() {
        Consultorios consultorio = new Consultorios();
        consultorio.setNumero("101");
        return consultorioRepository.save(consultorio);
    }

    @Test
    void testCrearModificarEliminarCita() {
        // 1. CREAR CITA
        Paciente paciente = crearPaciente();
        Medico medico = crearMedico();
        Consultorios consultorio = crearConsultorio();

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        cita.setHora(Time.valueOf("10:00:00"));
        cita.setPaciente(paciente);
        cita.setMedico(medico);
        cita.setConsultorio(consultorio);

        Citas citaGuardada = citasRepository.save(cita);
        assertNotNull(citaGuardada.getId(), "La cita debe haberse creado con un ID");

        // 2. MODIFICAR CITA
        citaGuardada.setHora(Time.valueOf("11:00:00"));
        Citas citaModificada = citasRepository.save(citaGuardada);
        assertEquals(Time.valueOf("11:00:00"), citaModificada.getHora(), "La hora de la cita debe haberse modificado");

        // 3. ELIMINAR CITA
        citasRepository.delete(citaModificada);
        Optional<Citas> citaEliminada = citasRepository.findById(citaModificada.getId());
        assertTrue(citaEliminada.isEmpty(), "La cita debe haber sido eliminada");
    }
}
