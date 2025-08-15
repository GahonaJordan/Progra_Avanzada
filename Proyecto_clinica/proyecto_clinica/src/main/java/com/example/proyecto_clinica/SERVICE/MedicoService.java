package com.example.proyecto_clinica.SERVICE;

import com.example.proyecto_clinica.DTO.MedicoEntradaDTO;
import com.example.proyecto_clinica.DTO.MedicoSalidaDTO;
import com.example.proyecto_clinica.MODEL.Medico;
import com.example.proyecto_clinica.MODEL.Rol;
import com.example.proyecto_clinica.MODEL.Usuario;
import com.example.proyecto_clinica.REPOSITORY.MedicoRepository;
import com.example.proyecto_clinica.REPOSITORY.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MedicoService {

    @Autowired
    private MedicoRepository medicoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Listar todos los médicos
    public List<MedicoSalidaDTO> listarMedicos(){
        return medicoRepository.findAll()
                .stream()
                .map(m -> {
                    String nombreCompleto = m.getNombre() + " " + m.getApellido();
                    return new MedicoSalidaDTO(
                            m.getId(),
                            nombreCompleto,
                            m.getEspecialidad(),
                            m.getUsuario() != null ? m.getUsuario().getRol() : null
                    );
                        })
                .toList();
    }

    // Buscar médico por ID
    public Optional<MedicoSalidaDTO> buscarMedicoPorId(Long id){
        return medicoRepository.findById(id)
                .map(m -> {
                        String nombreCompleto = m.getNombre() + " " + m.getApellido();
                        return new MedicoSalidaDTO(
                            m.getId(),
                            nombreCompleto,
                            m.getEspecialidad(),
                            m.getUsuario() != null ? m.getUsuario().getRol() : null
                        );
                });
    }

    // Crear un nuevo médico
    public MedicoSalidaDTO crearMedico(MedicoEntradaDTO dto){
        Medico nuevoMedico = null;
        try {
            nuevoMedico = new Medico(
                    null, // ID se generará automáticamente
                    dto.getNombre(),
                    dto.getApellido(),
                    dto.getEspecialidad()
            );
            // Crear el usuaior y asignar el rol medico
            Usuario usuario;
            if (dto.getUsuarioId() != null) {
                usuario = usuarioRepository.findById(dto.getUsuarioId())
                        .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
            } else {
                usuario = new Usuario();
                usuario.setRol(Rol.MEDICO);
            }
            nuevoMedico.setUsuario(usuario);


            Medico medicoGuardado = medicoRepository.save(nuevoMedico);
            String nombreCompleto = medicoGuardado.getNombre() + " " + medicoGuardado.getApellido();
            return new MedicoSalidaDTO(
                    medicoGuardado.getId(),
                    nombreCompleto,
                    medicoGuardado.getEspecialidad(),
                    medicoGuardado.getUsuario() != null ? medicoGuardado.getUsuario().getRol() : null
            );
        } catch (Exception e) {
            throw new RuntimeException("Error al crear el médico: " + e.getMessage());
        }
    }

    // Actualizar un médico existente
    public Optional<MedicoSalidaDTO> actualizarMedico(Long id, MedicoEntradaDTO entrada){
        return medicoRepository.findById(id).map(medico -> {
            try {
                medico.setNombre(entrada.getNombre());
                medico.setApellido(entrada.getApellido());
                medico.setEspecialidad(entrada.getEspecialidad());
                // Guardar el médico actualizado
                Medico medicoActualizado = medicoRepository.save(medico);
                String nombreCompleto = medicoActualizado.getNombre() + " " + medicoActualizado.getApellido();
                return new MedicoSalidaDTO(
                        medicoActualizado.getId(),
                        nombreCompleto,
                        medicoActualizado.getEspecialidad(),
                        medicoActualizado.getUsuario() != null ? medicoActualizado.getUsuario().getRol() : null
                );
            } catch (Exception e) {
                throw new RuntimeException("Error al actualizar el médico: " + e.getMessage());
            }
        });
    }

    // Eliminar un médico por ID
    public boolean eliminarMedico(Long id) {
        if (medicoRepository.existsById(id)) {
            medicoRepository.deleteById(id);
            return true;
        } else {
            throw new RuntimeException("Médico no encontrado con ID: " + id);
        }
    }

}
