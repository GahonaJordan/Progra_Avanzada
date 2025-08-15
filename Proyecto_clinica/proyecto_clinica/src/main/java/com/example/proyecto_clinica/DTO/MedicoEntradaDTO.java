package com.example.proyecto_clinica.DTO;

import com.example.proyecto_clinica.MODEL.Rol;

public class MedicoEntradaDTO {

    private String nombre;
    private String apellido;
    private String especialidad;
    private Long usuarioId;

    // Contructor por defecto

    public MedicoEntradaDTO() {
    }

    // Constructor personalizado

    public MedicoEntradaDTO(String nombre, String apellido, String especialidad, Long usuarioId) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.especialidad = especialidad;
        this.usuarioId = usuarioId;
    }

    // Getters y Setters

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }
    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }
}
