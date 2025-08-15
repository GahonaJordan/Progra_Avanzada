package com.example.proyecto_clinica.SERVICE;

import com.example.proyecto_clinica.DTO.PacienteEntradaDTO;
import com.example.proyecto_clinica.DTO.PacienteSalidaDTO;
import com.example.proyecto_clinica.MODEL.Paciente;
import com.example.proyecto_clinica.MODEL.Rol;
import com.example.proyecto_clinica.MODEL.Usuario;
import com.example.proyecto_clinica.REPOSITORY.PacienteRepository;
import com.example.proyecto_clinica.REPOSITORY.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

@Service
public class PacienteService {

    @Autowired
    private PacienteRepository repository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    // Listar todos los pacientes
    public List<PacienteSalidaDTO> listarPacientes() {
        return repository.findAll()
                .stream()
                .map(p -> {
                    String fecha = sdf.format(p.getFechaNacimiento());
                    String nombreCompleto = p.getNombre() + " " + p.getApellido();
                    return new PacienteSalidaDTO(
                            p.getId(),
                            nombreCompleto,
                            fecha,
                            p.getEmail(),
                            p.getUsuario() != null ? p.getUsuario().getRol() : null // Asignar rol si es necesario
                    );
                })
                .toList();
    }

    // Buscar un paciente por ID
    public Optional<PacienteSalidaDTO> buscarPacientePorId(Long id) {
        return repository.findById(id)
                .map(p -> {
                    String fecha = sdf.format(p.getFechaNacimiento());
                    String nombreCompleto = p.getNombre() + " " + p.getApellido();
                    return new PacienteSalidaDTO(
                            p.getId(),
                            nombreCompleto,
                            fecha,
                            p.getEmail(),
                            p.getUsuario() != null ? p.getUsuario().getRol() : null);
                });
    }

    // Crear un nuevo paciente
    public PacienteSalidaDTO crearPaciente(PacienteEntradaDTO dto) {
        Paciente nuevoPaciente = null;
        try {
            nuevoPaciente = new Paciente(
                    dto.getNombre(),
                    dto.getApellido(),
                    sdf.parse(dto.getFechaNacimiento()),
                    dto.getEmail()
            );
            // Crear el usuario y asignar el rol PACIENTE
            Usuario usuario;
            if (dto.getUsuarioId() != null) {
                usuario = usuarioRepository.findById(dto.getUsuarioId())
                        .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
            } else {
                usuario = new Usuario();
                usuario.setRol(Rol.PACIENTE);
            }
            nuevoPaciente.setUsuario(usuario);

            Paciente pacienteGuardado = repository.save(nuevoPaciente);
            String fecha = sdf.format(pacienteGuardado.getFechaNacimiento());
            String nombreCompleto = pacienteGuardado.getNombre() + " " + pacienteGuardado.getApellido();
            return new PacienteSalidaDTO(
                    pacienteGuardado.getId(),
                    nombreCompleto,
                    fecha,
                    pacienteGuardado.getEmail(),
                    pacienteGuardado.getUsuario() != null ? pacienteGuardado.getUsuario().getRol() : null
            );
        } catch (ParseException e) {
            throw new RuntimeException("Formato de fecha inválido");
        }
    }

    // Actualizar un paciente existente
    public Optional<PacienteSalidaDTO> actualizarPaciente(Long id, PacienteEntradaDTO entrada) {
        return repository.findById(id).map(paciente -> {
            try {
                paciente.setNombre(entrada.getNombre());
                paciente.setApellido(entrada.getApellido());
                paciente.setFechaNacimiento(sdf.parse(entrada.getFechaNacimiento()));
                paciente.setEmail(entrada.getEmail());
                // Guardar el paciente actualizado
                Paciente actualizado = repository.save(paciente);
                String fecha = sdf.format(actualizado.getFechaNacimiento());
                String nombreCompleto = actualizado.getNombre() + " " + actualizado.getApellido();
                return new PacienteSalidaDTO(
                        actualizado.getId(),
                        nombreCompleto,
                        fecha,
                        actualizado.getEmail(),
                        actualizado.getUsuario() != null ? actualizado.getUsuario().getRol() : null
                );
            } catch (ParseException e) {
                throw new RuntimeException("Formato de fecha inválido");
            }
        });
    }

    // Eliminar un paciente por ID
    public boolean eliminarPaciente(Long id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
            return true;
        }
        return false;
    }




}
