package com.example.api_operaciones.basica.CONTROLLER;

import com.example.api_operaciones.basica.DTO.OperacionRequest;
import com.example.api_operaciones.basica.DTO.OperacionResponse;
import com.example.api_operaciones.basica.SERVICE.OperacionesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/operaciones")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
public class OperacionesController {

    //inyectar el servicio de operaciones
    @Autowired
    private OperacionesService operacionesService;

    @PostMapping("/sumar")
    public OperacionResponse suma(@RequestBody OperacionRequest request) {
        double resultado = operacionesService.suma(request.getNumero1(), request.getNumero2());
        return new OperacionResponse(resultado);
    }

    @PostMapping("/restar")
    public OperacionResponse resta(@RequestBody OperacionRequest request) {
        double resultado = operacionesService.resta(request.getNumero1(), request.getNumero2());
        return new OperacionResponse(resultado);
    }

    @PostMapping("/multiplicar")
    public OperacionResponse multiplicacion(@RequestBody OperacionRequest request) {
        double resultado = operacionesService.multiplicacion(request.getNumero1(), request.getNumero2());
        return new OperacionResponse(resultado);
    }

    @PostMapping("/dividir")
    public OperacionResponse division(@RequestBody OperacionRequest request) {
        double resultado = operacionesService.division(request.getNumero1(), request.getNumero2());
        return new OperacionResponse(resultado);
    }
}
