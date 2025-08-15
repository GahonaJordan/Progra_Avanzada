package com.example.proyecto_clinica.SERVICE;

import com.example.proyecto_clinica.DTO.*;
import com.example.proyecto_clinica.MODEL.Citas;
import com.example.proyecto_clinica.MODEL.Consultorios;
import com.example.proyecto_clinica.MODEL.Medico;
import com.example.proyecto_clinica.MODEL.Paciente;
import com.example.proyecto_clinica.REPOSITORY.CitasRepository;
import com.example.proyecto_clinica.REPOSITORY.ConsultoriosRepository;
import com.example.proyecto_clinica.REPOSITORY.MedicoRepository;
import com.example.proyecto_clinica.REPOSITORY.PacienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

@Service
public class CitaService {

    @Autowired
    private CitasRepository citaRepository;

    @Autowired
    private PacienteRepository pacienteRepository;

    @Autowired
    private MedicoRepository medicoRepository;

    @Autowired
    private ConsultoriosRepository consultorioRepository;

    private SimpleDateFormat sdffecha = new SimpleDateFormat("dd/MM/yyyy");
    private SimpleDateFormat sdfhora = new SimpleDateFormat("HH:mm");

    // Listar todas las citas
    public List<CitasSalidaDTO> listarCitas(){
        return citaRepository.findAll()
                .stream()
                .map(citas -> {
                    String fecha = sdffecha.format(citas.getFecha());
                    String hora = sdfhora.format(citas.getHora());
                    Paciente paciente = citas.getPaciente();
                    Medico medico = citas.getMedico();
                    Consultorios consultorio = citas.getConsultorio();

                    PacienteSalidaDTO pacienteDTO = new PacienteSalidaDTO(
                            paciente.getId(),
                            paciente.getNombre() + " " + paciente.getApellido(),
                            sdffecha.format(paciente.getFechaNacimiento()),
                            paciente.getEmail(),
                            paciente.getUsuario() != null ? paciente.getUsuario().getRol() : null
                    );

                    MedicoSalidaDTO medicoDTO = new MedicoSalidaDTO(
                            medico.getId(),
                            medico.getNombre() + " " + medico.getApellido(),
                            medico.getEspecialidad(),
                            medico.getUsuario() != null ? medico.getUsuario().getRol() : null
                    );

                    ConsultoriosSalidaDTO consultorioDTO = new ConsultoriosSalidaDTO(
                            consultorio.getId(),
                            consultorio.getNumero(),
                            consultorio.getPiso()
                    );

                    return new CitasSalidaDTO(
                            citas.getId(),
                            fecha,
                            hora,
                            pacienteDTO,
                            medicoDTO,
                            consultorioDTO
                    );
                })
                .toList();
    }

    // Buscar una cita por ID
    public Optional<CitasSalidaDTO> buscarCitaPorId(Long id){
        return citaRepository.findById(id)
                .map( citas -> {
                    String fecha = sdffecha.format(citas.getFecha());
                    String hora = sdfhora.format(citas.getHora());
                    Paciente paciente = citas.getPaciente();
                    Medico medico = citas.getMedico();
                    Consultorios consultorio = citas.getConsultorio();

                    PacienteSalidaDTO pacienteDTO = new PacienteSalidaDTO(
                            paciente.getId(),
                            paciente.getNombre() + " " + paciente.getApellido(),
                            sdffecha.format(paciente.getFechaNacimiento()),
                            paciente.getEmail(),
                            paciente.getUsuario() != null ? paciente.getUsuario().getRol() : null
                    );

                    MedicoSalidaDTO medicoDTO = new MedicoSalidaDTO(
                            medico.getId(),
                            medico.getNombre() + " " + medico.getApellido(),
                            medico.getEspecialidad(),
                            medico.getUsuario() != null ? medico.getUsuario().getRol() : null
                    );

                    ConsultoriosSalidaDTO consultorioDTO = new ConsultoriosSalidaDTO(
                            consultorio.getId(),
                            consultorio.getNumero(),
                            consultorio.getPiso()
                    );

                    return new CitasSalidaDTO(
                            citas.getId(),
                            fecha,
                            hora,
                            pacienteDTO,
                            medicoDTO,
                            consultorioDTO
                    );
                });
    }

    // Crear una nueva cita
    public CitasSalidaDTO crearCita(CitasEntradaDTO dto){
        Citas nuevaCita = null;
        try {
            Paciente paciente = pacienteRepository.findById(dto.getPacienteId())
                    .orElseThrow(() -> new RuntimeException("Paciente no encontrado"));
            Medico medico = medicoRepository.findById(dto.getMedicoId())
                    .orElseThrow(() -> new RuntimeException("Médico no encontrado"));
            Consultorios consultorio = consultorioRepository.findById(dto.getConsultorioId())
                    .orElseThrow(() -> new RuntimeException("Consultorio no encontrado"));

            nuevaCita = new Citas(
                    null,
                    sdffecha.parse(dto.getFecha()),
                    Time.valueOf(dto.getHora() + ":00"),
                    paciente,
                    medico,
                    consultorio
            );
           // Guardar la nueva cita en la base de datos
            citaRepository.save(nuevaCita);
            String fecha = sdffecha.format(nuevaCita.getFecha());
            String hora = sdfhora.format(nuevaCita.getHora());

            PacienteSalidaDTO pacienteDTO = new PacienteSalidaDTO(
                    paciente.getId(),
                    paciente.getNombre() + " " + paciente.getApellido(),
                    sdffecha.format(paciente.getFechaNacimiento()),
                    paciente.getEmail(),
                    paciente.getUsuario() != null ? paciente.getUsuario().getRol() : null
            );

            MedicoSalidaDTO medicoDTO = new MedicoSalidaDTO(
                    medico.getId(),
                    medico.getNombre() + " " + medico.getApellido(),
                    medico.getEspecialidad(),
                    medico.getUsuario() != null ? medico.getUsuario().getRol() : null
            );

            ConsultoriosSalidaDTO consultorioDTO = new ConsultoriosSalidaDTO(
                    consultorio.getId(),
                    consultorio.getNumero(),
                    consultorio.getPiso()
            );

            return new CitasSalidaDTO(
                    nuevaCita.getId(),
                    fecha,
                    hora,
                    pacienteDTO,
                    medicoDTO,
                    consultorioDTO
            );
        } catch (Exception e) {
            throw new RuntimeException("Error al crear la cita: " + e.getMessage());
        }
    }

    // Actualizar una cita existente
    public Optional<CitasSalidaDTO> actualizarCita(Long id, CitasEntradaDTO dto) {
        return citaRepository.findById(id)
                .map(cita -> {
                    try {
                        Paciente paciente = pacienteRepository.findById(dto.getPacienteId())
                                .orElseThrow(() -> new RuntimeException("Paciente no encontrado"));
                        Medico medico = medicoRepository.findById(dto.getMedicoId())
                                .orElseThrow(() -> new RuntimeException("Médico no encontrado"));
                        Consultorios consultorio = consultorioRepository.findById(dto.getConsultorioId())
                                .orElseThrow(() -> new RuntimeException("Consultorio no encontrado"));

                        cita.setFecha(sdffecha.parse(dto.getFecha()));
                        cita.setHora(Time.valueOf(dto.getHora() + ":00"));
                        cita.setPaciente(paciente);
                        cita.setMedico(medico);
                        cita.setConsultorio(consultorio);
                        // Guardar los cambios en la base de datos
                        Citas citaActualizada = citaRepository.save(cita);
                        String fecha = sdffecha.format(cita.getFecha());
                        String hora = sdfhora.format(cita.getHora());

                        PacienteSalidaDTO pacienteDTO = new PacienteSalidaDTO(
                                paciente.getId(),
                                paciente.getNombre() + " " + paciente.getApellido(),
                                sdffecha.format(paciente.getFechaNacimiento()),
                                paciente.getEmail(),
                                paciente.getUsuario() != null ? paciente.getUsuario().getRol() : null
                        );

                        MedicoSalidaDTO medicoDTO = new MedicoSalidaDTO(
                                medico.getId(),
                                medico.getNombre() + " " + medico.getApellido(),
                                medico.getEspecialidad(),
                                medico.getUsuario() != null ? medico.getUsuario().getRol() : null
                        );

                        ConsultoriosSalidaDTO consultorioDTO = new ConsultoriosSalidaDTO(
                                consultorio.getId(),
                                consultorio.getNumero(),
                                consultorio.getPiso()
                        );

                        return new CitasSalidaDTO(
                                cita.getId(),
                                fecha,
                                hora,
                                pacienteDTO,
                                medicoDTO,
                                consultorioDTO
                        );
                    } catch (Exception e) {
                        throw new RuntimeException("Error al actualizar la cita: " + e.getMessage());
                    }
                });
    }

    // Eliminar una cita por ID
    public boolean eliminarCita(Long id) {
        if (citaRepository.existsById(id)) {
            citaRepository.deleteById(id);
            return true;
        } else {
            throw new RuntimeException("Cita no encontrada con ID: " + id);
        }
    }
}
