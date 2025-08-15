package com.example.api_operaciones.basica.CONTROLLER;

import com.example.api_operaciones.basica.DTO.UsuarioDTO;
import com.example.api_operaciones.basica.Model.Usuario;
import com.example.api_operaciones.basica.SERVICE.UsuarioService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/registro")
    public ResponseEntity<?> registrarUsuario(@RequestBody UsuarioDTO dto){
        try {
            Usuario usuario = usuarioService.registrarUsuario(dto);
            return ResponseEntity.ok("Usuario registrado correctamente: " + usuario.getUserName());
        } catch (RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(HttpServletRequest request) {
        String username = request.getUserPrincipal().getName();
        return ResponseEntity.ok("Login exitoso de: " + username);
    }

}
