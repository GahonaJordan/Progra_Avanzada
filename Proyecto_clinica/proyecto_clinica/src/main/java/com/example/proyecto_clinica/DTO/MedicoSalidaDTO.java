package com.example.proyecto_clinica.DTO;

import com.example.proyecto_clinica.MODEL.Rol;

public class MedicoSalidaDTO {

    private Long id;
    private String nombreCompleto;
    private String especialidad;
    private Rol rol; // Asumiendo que Rol es una clase que representa el rol del médico

    // Contructor por defecto

    public MedicoSalidaDTO() {
    }

    // Constructor personalizado

    public MedicoSalidaDTO(Long id, String nombreCompleto, String especialidad, Rol rol) {
        this.id = id;
        this.nombreCompleto = nombreCompleto;
        this.especialidad = especialidad;
        this.rol = rol;
    }

    // Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
}
