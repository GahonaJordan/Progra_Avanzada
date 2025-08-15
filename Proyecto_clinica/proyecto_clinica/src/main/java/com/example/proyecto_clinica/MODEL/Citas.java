package com.example.proyecto_clinica.MODEL;

import jakarta.persistence.*;

import java.sql.Time;
import java.util.Date;

@Entity
public class Citas {

    //Id de la entidad Citas
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // Atributos de la entidad Citas
    private Date fecha;
    private Time hora;
    // Relaciones con otras entidades
    //uno a muchos con Paciente
    @ManyToOne
    @JoinColumn(name = "paciente_id", nullable = false)
    private Paciente paciente;
    //uno a muchos con Medico
    @ManyToOne
    @JoinColumn(name = "medico_id", nullable = false)
    private Medico medico;
    //uno a muchos con Consultorio
    @ManyToOne
    @JoinColumn(name = "consultorio_id", nullable = false)
    private Consultorios consultorio;

    // Constructor por defecto para el JPA

    public Citas() {
    }

    // Constructor con parámetros para el JPA

    public Citas(Long id, Date fecha, Time hora, Paciente paciente, Medico medico, Consultorios consultorio) {
        this.id = id;
        this.fecha = fecha;
        this.hora = hora;
        this.paciente = paciente;
        this.medico = medico;
        this.consultorio = consultorio;
    }

    // Getters y Setters


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Consultorios getConsultorio() {
        return consultorio;
    }

    public void setConsultorio(Consultorios consultorio) {
        this.consultorio = consultorio;
    }
}
