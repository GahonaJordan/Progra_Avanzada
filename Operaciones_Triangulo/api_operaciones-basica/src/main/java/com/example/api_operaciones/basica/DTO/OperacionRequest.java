package com.example.api_operaciones.basica.DTO;

public class OperacionRequest {

    private double numero1;
    private double numero2;

    //constructores

    public OperacionRequest() {
    }

    public OperacionRequest(double numero1, double numero2) {
        this.numero1 = numero1;
        this.numero2 = numero2;
    }

    // Getters and Setters


    public double getNumero1() {
        return numero1;
    }

    public void setNumero1(double numero1) {
        this.numero1 = numero1;
    }

    public double getNumero2() {
        return numero2;
    }

    public void setNumero2(double numero2) {
        this.numero2 = numero2;
    }

    //toString para imprimir el objeto

    @Override
    public String toString() {
        return "OperacionRequest{" +
                "numero1=" + numero1 +
                ", numero2=" + numero2 +
                '}';
    }
}
