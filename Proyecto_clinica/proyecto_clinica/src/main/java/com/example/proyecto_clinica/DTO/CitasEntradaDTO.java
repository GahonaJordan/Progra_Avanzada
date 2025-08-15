package com.example.proyecto_clinica.DTO;

public class CitasEntradaDTO {

    private String fecha;
    private String hora;
    private Long pacienteId;
    private Long medicoId;
    private Long consultorioId;

    // Constructor por defecto

    public CitasEntradaDTO() {
    }

    // Constructor personalizado

    public CitasEntradaDTO(String fecha, String hora, Long pacienteId, Long medicoId, Long consultorioId) {
        this.fecha = fecha;
        this.hora = hora;
        this.pacienteId = pacienteId;
        this.medicoId = medicoId;
        this.consultorioId = consultorioId;
    }

    // Getters y Setters

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Long getPacienteId() {
        return pacienteId;
    }

    public void setPacienteId(Long pacienteId) {
        this.pacienteId = pacienteId;
    }

    public Long getMedicoId() {
        return medicoId;
    }

    public void setMedicoId(Long medicoId) {
        this.medicoId = medicoId;
    }

    public Long getConsultorioId() {
        return consultorioId;
    }

    public void setConsultorioId(Long consultorioId) {
        this.consultorioId = consultorioId;
    }
}
