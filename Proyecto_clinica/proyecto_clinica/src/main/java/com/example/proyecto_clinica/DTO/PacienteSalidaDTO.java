package com.example.proyecto_clinica.DTO;

import com.example.proyecto_clinica.MODEL.Rol;

public class PacienteSalidaDTO {

    private Long id;
    private String nombreCompleto;
    private String fechaNacimiento;
    private String email;
    private Rol rol;

    // Constructor por defecto

    public PacienteSalidaDTO() {
    }

    // Constructor personalizado

    public PacienteSalidaDTO(Long id, String nombreCompleto, String fechaNacimiento, String email, Rol rol) {
        this.id = id;
        this.nombreCompleto = nombreCompleto;
        this.fechaNacimiento = fechaNacimiento;
        this.email = email;
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

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
}
