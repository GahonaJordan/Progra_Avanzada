package com.example.api_operaciones.basica.SERVICE;

import org.springframework.stereotype.Service;

@Service
public class TrianguloService {

    public String determinarTipoTriangulo(double lado1, double lado2, double lado3) {
        if (lado1 <= 0 || lado2 <= 0 || lado3 <= 0) {
            return "Los lados deben ser mayores que cero.";
        }
        // Verificar si los lados forman un triángulo válido
        if (!esTrianguloValido(lado1, lado2, lado3)) {
            return "No es un triángulo válido";
        }

        if (lado1 == lado2 && lado2 == lado3) {
            return "El triángulo es equilátero.";
        } else if (lado1 == lado2 || lado2 == lado3 || lado1 == lado3) {
            return "El triángulo es isósceles.";
        } else {
            return "El triángulo es escaleno.";
        }
    }
    private boolean esTrianguloValido(double lado1, double lado2, double lado3) {
        return (lado1 + lado2 > lado3) && (lado1 + lado3 > lado2) && (lado2 + lado3 > lado1);
    }
}
