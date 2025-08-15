package com.example.proyecto_clinica.Prueba_integracion;

import static org.junit.jupiter.api.Assertions.*; // Agrega esto arriba
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

import java.sql.Time;
import java.sql.Date; // Usa java.sql.Date para valueOf
import java.util.List;


@SpringBootTest
@Transactional // para que no modifique datos reales
public class CitaIntegrationTest {

    @Autowired
    private PacienteRepository pacienteRepository;
    @Autowired
    private MedicoRepository medicoRepository;
    @Autowired
    private ConsultoriosRepository consultorioRepository;
    @Autowired
    private CitasRepository citasRepository;

    @Test
    void crearCitaValida() {
        // Crear entidades relacionadas
        Paciente paciente = new Paciente();
        paciente.setNombre("Juan");
        paciente.setApellido("Pérez");
        paciente.setFechaNacimiento(new Date(System.currentTimeMillis()));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Dra. María");
        medico.setApellido("López");
        medico.setEspecialidad("Cardiología");
        medico = medicoRepository.save(medico);

        Consultorios consultorio = new Consultorios();
        consultorio.setNumero("101");
        consultorio = consultorioRepository.save(consultorio);

        // Crear cita
        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15")); // Usa java.sql.Date
        cita.setHora(Time.valueOf("10:00:00"));
        cita.setPaciente(paciente);
        cita.setMedico(medico);
        cita.setConsultorio(consultorio);

        Citas citaGuardada = citasRepository.save(cita);

        assertNotNull(citaGuardada.getId(), "La cita debe tener ID asignado");
        assertEquals(paciente.getId(), citaGuardada.getPaciente().getId());
    }

    @Test
    void crearCitaSinPacienteDebeFallar() {
        // Para Medico
        Medico medico = new Medico();
        medico.setNombre("Dra. María López");
        medico.setEspecialidad("Cardiología");
        medico = medicoRepository.save(medico);

// Para Consultorios
        Consultorios consultorio = new Consultorios();
        consultorio.setNumero("101");
        consultorio = consultorioRepository.save(consultorio);

        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        cita.setHora(Time.valueOf("10:00:00"));
        cita.setMedico(medico);
        cita.setConsultorio(consultorio);

        assertThrows(Exception.class, () -> citasRepository.save(cita),
                "Debe fallar si no hay paciente asociado");
    }

    @Test
    void buscarCitasPorPaciente() {
        // Crear entidades relacionadas
        Paciente paciente = new Paciente();
        paciente.setNombre("Juan");
        paciente.setApellido("Pérez");
        paciente.setFechaNacimiento(new Date(System.currentTimeMillis()));
        paciente = pacienteRepository.save(paciente);

        Medico medico = new Medico();
        medico.setNombre("Dra. María");
        medico.setApellido("López");
        medico.setEspecialidad("Cardiología");
        medico = medicoRepository.save(medico);

        Consultorios consultorio = new Consultorios();
        consultorio.setNumero("101");
        consultorio = consultorioRepository.save(consultorio);

        // Crear cita
        Citas cita = new Citas();
        cita.setFecha(Date.valueOf("2025-08-15"));
        cita.setHora(Time.valueOf("10:00:00"));
        cita.setPaciente(paciente);
        cita.setMedico(medico);
        cita.setConsultorio(consultorio);
        citasRepository.save(cita);

        List<Citas> citasPaciente = citasRepository.findAllById(List.of(paciente.getId()));

        assertFalse(citasPaciente.isEmpty(), "El paciente debe tener al menos una cita");
    }
}
