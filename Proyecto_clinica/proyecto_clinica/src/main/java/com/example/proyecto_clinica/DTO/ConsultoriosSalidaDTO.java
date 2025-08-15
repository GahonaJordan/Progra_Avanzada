package com.example.proyecto_clinica.DTO;

public class ConsultoriosSalidaDTO {

    private Long id;
    private String numeroConsultorio;
    private int piso;

    // Constructor por defecto

    public ConsultoriosSalidaDTO() {
    }

    // Constructor personalizado

    public ConsultoriosSalidaDTO(Long id, String numeroConsultorio, int piso) {
        this.id = id;
        this.numeroConsultorio = numeroConsultorio;
        this.piso = piso;
    }

    // Getters y Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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
