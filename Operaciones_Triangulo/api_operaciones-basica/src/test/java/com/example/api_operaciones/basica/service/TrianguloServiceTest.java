package com.example.api_operaciones.basica.service;
import com.example.api_operaciones.basica.SERVICE.TrianguloService;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class TrianguloServiceTest {

    //instanciar TrianguloService
    private final TrianguloService trianguloService = new TrianguloService();

    //triangulo equilatero
    @Test
    void testTrianguloEquilatero(){
        try {
            String resultado = trianguloService.determinarTipoTriangulo(5, 5, 5);
            assertEquals("El triángulo es equilátero.", resultado, "El triángulo es equilátero.");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //triangulo isosceles
    @Test
    void testTrianguloIsosceles() {
        try {
            String resultado = trianguloService.determinarTipoTriangulo(5, 5, 3);
            assertEquals("El triángulo es isósceles.", resultado, "El triángulo es isósceles.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //triangulo escaleno
    @Test
    void testTrianguloEscaleno() {
        try {
            String resultado = trianguloService.determinarTipoTriangulo(5, 4, 3);
            assertEquals("El triángulo es escaleno.", resultado, "El triángulo es escaleno.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //no es un triangulo valido
    @Test
    void testNoEsTrianguloValido() {
        try {
            String resultado = trianguloService.determinarTipoTriangulo(1, 2, 3);
            assertEquals("No es un triángulo válido", resultado, "No es un triángulo válido");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
