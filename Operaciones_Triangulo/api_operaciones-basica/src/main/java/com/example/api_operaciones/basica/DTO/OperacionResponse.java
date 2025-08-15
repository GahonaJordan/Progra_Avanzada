package com.example.api_operaciones.basica.DTO;

public class OperacionResponse {

    private double resultado;

    // Constructores

    public OperacionResponse() {
    }

    public OperacionResponse(double resultado) {
        this.resultado = resultado;
    }

    // Getters and Setters

    public double getResultado() {
        return resultado;
    }

    public void setResultado(double resultado) {
        this.resultado = resultado;
    }


    //toString para imprimir el objeto

    @Override
    public String toString() {
        return "OperacionResponse{" +
                "resultado=" + resultado +
                '}';
    }
}
