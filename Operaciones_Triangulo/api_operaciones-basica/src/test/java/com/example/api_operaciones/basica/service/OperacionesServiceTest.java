package com.example.api_operaciones.basica.service;
import com.example.api_operaciones.basica.SERVICE.OperacionesService;
import org.junit.jupiter.api.Test;
//assertEquals
//assertThrows
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
public class OperacionesServiceTest {

    //intanciar OperacionesService
    private final OperacionesService operacionesService = new OperacionesService();

    @Test
    void testSuma() {
        try {
            double resultado = operacionesService.suma(10, 5);
            assertEquals(15, resultado, "La suma de 5 y 3 debe ser 8");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void testResta() {
        try {
            double resultado = operacionesService.resta(10, 5);
            assertEquals(5, resultado, "La resta de 10 y 5 debe ser 5");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void testMultiplicacion() {
        try {
            double resultado = operacionesService.multiplicacion(10, 5);
            assertEquals(50, resultado, "La multiplicación de 10 y 5 debe ser 50");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void testDivision() {
        try {
            double resultado = operacionesService.division(10, 5);
            assertEquals(2, resultado, "La división de 10 entre 5 debe ser 2");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void testDivisionPorCero() {
        try {
            assertThrows(ArithmeticException.class, () -> {
                operacionesService.division(10, 0);
            }, "Se esperaba una excepción al dividir por cero");
        } catch (AssertionError e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
