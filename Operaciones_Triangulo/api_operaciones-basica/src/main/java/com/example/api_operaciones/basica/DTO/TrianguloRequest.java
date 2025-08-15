package com.example.api_operaciones.basica.DTO;

public class TrianguloRequest {

    private double lado1;
    private double lado2;
    private double lado3;

    // Constructores

    public TrianguloRequest() {
    }

    public TrianguloRequest(double lado1, double lado2, double lado3) {
        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 = lado3;
    }

    // Getters y Setters

    public double getLado1() {
        return lado1;
    }

    public void setLado1(double lado1) {
        this.lado1 = lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public void setLado2(double lado2) {
        this.lado2 = lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public void setLado3(double lado3) {
        this.lado3 = lado3;
    }

    // toString para imprimir el objeto
    @Override
    public String toString() {
        return "TrianguloRequest{" +
                "lado1=" + lado1 +
                ", lado2=" + lado2 +
                ", lado3=" + lado3 +
                '}';
    }
}
