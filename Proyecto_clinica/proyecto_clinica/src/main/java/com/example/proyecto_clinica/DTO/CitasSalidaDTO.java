package com.example.proyecto_clinica.DTO;

public class CitasSalidaDTO {

    private Long id;
    private String fecha;
    private String hora;
    private PacienteSalidaDTO paciente;
    private MedicoSalidaDTO medico;
    private ConsultoriosSalidaDTO consultorio;

    // Constructor por defecto

    public CitasSalidaDTO() {
    }

    // Constructor personalizado

    public CitasSalidaDTO(Long id, String fecha, String hora, PacienteSalidaDTO paciente, MedicoSalidaDTO medico, ConsultoriosSalidaDTO consultorio) {
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

    public PacienteSalidaDTO getPaciente() {
        return paciente;
    }

    public void setPaciente(PacienteSalidaDTO paciente) {
        this.paciente = paciente;
    }

    public MedicoSalidaDTO getMedico() {
        return medico;
    }

    public void setMedico(MedicoSalidaDTO medico) {
        this.medico = medico;
    }

    public ConsultoriosSalidaDTO getConsultorio() {
        return consultorio;
    }

    public void setConsultorio(ConsultoriosSalidaDTO consultorio) {
        this.consultorio = consultorio;
    }
}
