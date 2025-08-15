package com.example.proyecto_clinica.DTO;

import com.example.proyecto_clinica.MODEL.Rol;

public class PacienteEntradaDTO {

    private String nombre;
    private String apellido;
    private String fechaNacimiento;
    private String email;
    private Long usuarioId; // Agrega este campo

    // Constructor por defecto

    public PacienteEntradaDTO() {
    }

    // Constructor personalizado

    public PacienteEntradaDTO(String nombre, String apellido, String fechaNacimiento, String email, Long usuarioId) {

        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.email = email;
        this.usuarioId = usuarioId; // Inicializa este campo
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

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }
}
