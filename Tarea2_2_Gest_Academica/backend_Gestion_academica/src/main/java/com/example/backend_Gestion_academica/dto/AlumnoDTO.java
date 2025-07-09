package com.example.backend_Gestion_academica.dto;

import java.util.List;

public class AlumnoDTO {

    private Long id;
    private String nombreCompleto;
    private String email;
    private String telefono;
    private String direccion;
    private String fechaNacimiento;
    private String genero;
    private String estadoCivil;
    private String nacionalidad;
    //Lista de IDs de asignaturas asociadas al alumno
    private List<Long> asignaturaIds;
    // Lista de IDs de notas asociadas al alumno
    private List<Long> notaIds;

    // Constructores personalizados

    public AlumnoDTO() {
    }

    public AlumnoDTO(Long id, String nombre, String apellido, String email, String telefono, String direccion, String fechaNacimiento, String genero, String estadoCivil, String nacionalidad, List<Long> asignaturaIds, List<Long> notaIds) {
        this.id = id;
        this.nombreCompleto = nombre + " " + apellido;
        this.email = email;
        this.telefono = telefono;
        this.direccion = direccion;
        this.fechaNacimiento = fechaNacimiento;
        this.genero = genero;
        this.estadoCivil = estadoCivil;
        this.nacionalidad = nacionalidad;
        this.asignaturaIds = asignaturaIds;
        this.notaIds = notaIds;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public List<Long> getAsignaturaIds() {
        return asignaturaIds;
    }

    public void setAsignaturaIds(List<Long> asignaturaIds) {
        this.asignaturaIds = asignaturaIds;
    }

    public List<Long> getNotaIds() {
        return notaIds;
    }

    public void setNotaIds(List<Long> notaIds) {
        this.notaIds = notaIds;
    }
}
