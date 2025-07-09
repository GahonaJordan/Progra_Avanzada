package com.example.backend_Gestion_academica.dto;

public class NotasDTO {

    private Long id;
    private double valor;
    // ID del estudiante
    private Long alumnoId;
    // ID de la asignatura
    private Long asignaturaId;

    // Constructor personalizado

    public NotasDTO() {
    }

    public NotasDTO(Long id, double valor, Long alumnoId, Long asignaturaId) {
        this.id = id;
        this.valor = valor;
        this.alumnoId = alumnoId;
        this.asignaturaId = asignaturaId;
    }

    // Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public Long getAlumnoId() {
        return alumnoId;
    }

    public void setAlumnoId(Long alumnoId) {
        this.alumnoId = alumnoId;
    }

    public Long getAsignaturaId() {
        return asignaturaId;
    }

    public void setAsignaturaId(Long asignaturaId) {
        this.asignaturaId = asignaturaId;
    }
}
