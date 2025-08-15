package com.example.proyecto_clinica.SERVICE;

import com.example.proyecto_clinica.DTO.ConsultoriosEntradaDTO;
import com.example.proyecto_clinica.DTO.ConsultoriosSalidaDTO;
import com.example.proyecto_clinica.MODEL.Consultorios;
import com.example.proyecto_clinica.REPOSITORY.ConsultoriosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ConsultorioService {

    @Autowired
    private ConsultoriosRepository consultoriosRepository;

    // Listar todos los consultorios
    public List<ConsultoriosSalidaDTO> listarConsultorios() {
        return consultoriosRepository.findAll()
                .stream()
                .map(c -> {
                    return new ConsultoriosSalidaDTO(
                            c.getId(),
                            c.getNumero(),
                            c.getPiso()
                    );
                })
                .toList();
    }

    // Obtener un consultorio por ID
    public Optional<ConsultoriosSalidaDTO> obtenerConsultorioPorId(Long id) {
        return consultoriosRepository.findById(id)
                .map(c -> {
                    return new ConsultoriosSalidaDTO(
                            c.getId(),
                            c.getNumero(),
                            c.getPiso()
                    );
                });
    }

    // Crear un nuevo consultorio
    public ConsultoriosSalidaDTO crearConsultorio(ConsultoriosEntradaDTO dto){
        Consultorios nuevoConsultorio = null;
        try {
            nuevoConsultorio = new Consultorios(
                    null,
                    dto.getNumeroConsultorio(),
                    dto.getPiso()
            );

            Consultorios consultorioGuardado = consultoriosRepository.save(nuevoConsultorio);

            return new ConsultoriosSalidaDTO(
                    consultorioGuardado.getId(),
                    consultorioGuardado.getNumero(),
                    consultorioGuardado.getPiso()
            );
        } catch (Exception e) {
            throw new RuntimeException("Error al crear el consultorio: " + e.getMessage());
        }
    }

    // Actualizar un consultorio existente
    public Optional<ConsultoriosSalidaDTO> actualizarConsultorio(Long id, ConsultoriosEntradaDTO entrada){
        return consultoriosRepository.findById(id).map(consult -> {
            try {
                consult.setNumero(entrada.getNumeroConsultorio());
                consult.setPiso(entrada.getPiso());
                // Guardar cambios
                Consultorios consultorioActualizado = consultoriosRepository.save(consult);
                return new ConsultoriosSalidaDTO(
                        consultorioActualizado.getId(),
                        consultorioActualizado.getNumero(),
                        consultorioActualizado.getPiso()
                );
            } catch (Exception e) {
                throw new RuntimeException("Error al actualizar el consultorio: " + e.getMessage());
            }
        });
    }

    // Eliminar un consultorio por ID
    public boolean eliminarConsultorio(Long id) {
        if (consultoriosRepository.existsById(id)) {
            consultoriosRepository.deleteById(id);
            return true;
        } else {
            throw new RuntimeException("Consultorio no encontrado con ID: " + id);
        }
    }
}
