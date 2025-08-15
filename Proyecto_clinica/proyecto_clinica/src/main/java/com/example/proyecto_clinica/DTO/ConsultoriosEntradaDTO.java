package com.example.proyecto_clinica.DTO;

public class ConsultoriosEntradaDTO {

    private String numeroConsultorio;
    private int piso;

    // Constructor por defecto

    public ConsultoriosEntradaDTO() {
    }

    // Constructor personalizado

    public ConsultoriosEntradaDTO(String numeroConsultorio, int piso) {
        this.numeroConsultorio = numeroConsultorio;
        this.piso = piso;
    }

    // Getters y Setters

    public String getNumeroConsultorio() {
        return numeroConsultorio;
    }

    public void setNumeroConsultorio(String numeroConsultorio) {
        this.numeroConsultorio = numeroConsultorio;
    }

    public int getPiso() {
        return piso;
    }

    public void setPiso(int piso) {
        this.piso = piso;
    }
}
