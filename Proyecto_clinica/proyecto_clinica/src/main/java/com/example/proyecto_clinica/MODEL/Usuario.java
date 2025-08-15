package com.example.proyecto_clinica.MODEL;

import jakarta.persistence.*;

@Entity
public class Usuario {

    //Usuario simple
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    //Atributos
    @Column(unique = true, nullable = false)
    private String userName;
    private String password;

    @OneToOne(mappedBy = "usuario")
    private Paciente paciente;

    @OneToOne(mappedBy = "usuario")
    private Medico medico;


    @Enumerated(EnumType.STRING)
    private Rol rol; // PACIENTE, MEDICO, ADMIN

    //Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
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
}


