package com.example.proyecto_clinica.MODEL;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Consultorios {

    //Id de la entidad Consultorios
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // Atributos de la entidad Consultorios
    private String numero;
    private int piso;

    // Constructor por defecto para el JPA

    public Consultorios() {
    }

    // Constructor con parámetros para el JPA

    public Consultorios(Long id, String numero, int piso) {
        this.id = id;
        this.numero = numero;
        this.piso = piso;
    }


    // Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public int getPiso() {
        return piso;
    }

    public void setPiso(int piso) {
        this.piso = piso;
    }
}
