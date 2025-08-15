package com.example.api_operaciones.basica.CONTROLLER;

import com.example.api_operaciones.basica.DTO.TrianguloRequest;
import com.example.api_operaciones.basica.DTO.TrianguloResponse;
import com.example.api_operaciones.basica.SERVICE.TrianguloService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/triangulos")
public class TrianguloController {

    //inyectar el servicio de triangulo
    @Autowired
    private TrianguloService trianguloService;

    @PostMapping("/identificar")
    public TrianguloResponse identificarTriangulo(@RequestBody TrianguloRequest request){
        // Llamar al servicio para identificar el tipo de triángulo
        String tipoTriangulo = trianguloService.determinarTipoTriangulo(request.getLado1(), request.getLado2(), request.getLado3());
        // Crear la respuesta con el resultado
        return new TrianguloResponse(tipoTriangulo);
    }
}
