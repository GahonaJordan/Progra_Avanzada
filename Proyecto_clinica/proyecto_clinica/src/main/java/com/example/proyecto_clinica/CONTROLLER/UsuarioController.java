package com.example.proyecto_clinica.CONTROLLER;

import com.example.proyecto_clinica.DTO.UsuarioDTO;
import com.example.proyecto_clinica.MODEL.Rol;
import com.example.proyecto_clinica.MODEL.Usuario;
import com.example.proyecto_clinica.SERVICE.UsuarioService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/register")
    public ResponseEntity<Usuario> register(@RequestBody UsuarioDTO dto) {
        return ResponseEntity.ok(usuarioService.registrarUsuario(dto, "ANONIMO"));
    }

    @PostMapping("/admin/register")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Usuario> registerByAdmin(@RequestBody UsuarioDTO dto) {
        return ResponseEntity.ok(usuarioService.registrarUsuario(dto, "ADMIN"));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(HttpServletRequest request) {
        String username = request.getUserPrincipal().getName();
        Usuario usuario = usuarioService.obtenerPorUserName(username);
        return ResponseEntity.ok(Map.of(
                "userName", username,
                "rol", usuario.getRol().name()
        ));
    }

}
