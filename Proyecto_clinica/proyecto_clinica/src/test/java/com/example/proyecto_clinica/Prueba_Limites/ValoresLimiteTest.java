package com.example.proyecto_clinica.Prueba_Limites;

import static org.junit.jupiter.api.Assertions.*;

import com.example.proyecto_clinica.MODEL.Citas;
import com.example.proyecto_clinica.MODEL.Medico;
import com.example.proyecto_clinica.MODEL.Paciente;
import com.example.proyecto_clinica.REPOSITORY.CitasRepository;
import com.example.proyecto_clinica.REPOSITORY.MedicoRepository;
import com.example.proyecto_clinica.REPOSITORY.PacienteRepository;

import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.Date;
import java.sql.Time;

@SpringBootTest
@Transactional
public class ValoresLimiteTest {

    @Autowired
    private PacienteRepository pacienteRepository;

    @Autowired
    private MedicoRepository medicoRepository;

    @Autowired
    private CitasRepository citasRepository;

    @Test
    void crearPacienteConFechaNacimientoLimiteInferior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente Limite Inferior");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1900-01-01")); // límite inferior

        paciente = pacienteRepository.save(paciente);

        assertNotNull(paciente.getId());
    }

    @Test
    void crearPacienteConFechaNacimientoLimiteSuperior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente Limite Superior");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(new Date(System.currentTimeMillis())); // hoy

        paciente = pacienteRepository.save(paciente);

        assertNotNull(paciente.getId());
    }

    @Test
    void crearPacienteConFechaNacimientoFueraLimiteInferior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente Fuera Limite Inferior");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1800-12-31")); // fuera límite

        assertThrows(Exception.class, () -> pacienteRepository.save(paciente));
    }

    @Test
    void crearPacienteConFechaNacimientoFueraLimiteSuperior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente Fuera Limite Superior");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("2050-01-01")); // fuera límite

        assertThrows(Exception.class, () -> pacienteRepository.save(paciente));
    }

    @Test
    void crearCitaConHoraLimiteInferior() {
        // Crear médico y paciente para la cita
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1990-01-01"));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Medico");
        medico.setApellido("Test");
        medico.setEspecialidad("General");
        medico = medicoRepository.save(medico);

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        cita.setHora(Time.valueOf("00:00:00")); // límite inferior
        cita.setPaciente(paciente);
        cita.setMedico(medico);

        cita = citasRepository.save(cita);

        assertNotNull(cita.getId());
    }

    @Test
    void crearCitaConHoraLimiteSuperior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1990-01-01"));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Medico");
        medico.setApellido("Test");
        medico.setEspecialidad("General");
        medico = medicoRepository.save(medico);

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        cita.setHora(Time.valueOf("23:59:59")); // límite superior
        cita.setPaciente(paciente);
        cita.setMedico(medico);

        cita = citasRepository.save(cita);

        assertNotNull(cita.getId());
    }

    @Test
    void crearCitaConHoraFueraLimiteInferior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1990-01-01"));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Medico");
        medico.setApellido("Test");
        medico.setEspecialidad("General");
        medico = medicoRepository.save(medico);

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        // No se puede crear Time con valor negativo, por eso lo probamos con un String inválido:
        assertThrows(IllegalArgumentException.class, () -> Time.valueOf(" -01:00:00"));
    }

    @Test
    void crearCitaConHoraFueraLimiteSuperior() {
        Paciente paciente = new Paciente();
        paciente.setNombre("Paciente");
        paciente.setApellido("Test");
        paciente.setFechaNacimiento(Date.valueOf("1990-01-01"));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Medico");
        medico.setApellido("Test");
        medico.setEspecialidad("General");
        medico = medicoRepository.save(medico);

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));

        // Time.valueOf("24:00:00") lanza IllegalArgumentException
        assertThrows(IllegalArgumentException.class, () -> Time.valueOf("24:00:00"));
    }
}
