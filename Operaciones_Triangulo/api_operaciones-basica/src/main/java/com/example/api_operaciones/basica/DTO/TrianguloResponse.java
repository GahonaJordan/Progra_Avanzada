package com.example.api_operaciones.basica.DTO;

public class TrianguloResponse {

    private String resultado;

    // Constructor

    public TrianguloResponse() {
    }

    public TrianguloResponse(String resultado) {
        this.resultado = resultado;
    }

    // Getters y Setters

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

    // toString para imprimir el objeto
    @Override
    public String toString() {
        return "TrianguloResponse{" +
                "resultado=" + resultado +
                '}';
    }
}
