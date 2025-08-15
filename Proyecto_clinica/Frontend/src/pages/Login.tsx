import React, { useState, useRef } from "react";
import { InputText } from "primereact/inputtext";
import { Password } from "primereact/password";
import { Button } from "primereact/button";
import { Toast } from "primereact/toast";
import { useNavigate } from "react-router-dom";
import { usuariosService } from "../services/usuariosService";

export const Login: React.FC = () => {
    const [formData, setFormData] = useState({ userName: "", password: "" });
    const [loading, setLoading] = useState(false);
    const toast = useRef<Toast>(null);
    const navigate = useNavigate();

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const response = await usuariosService.login(formData);
            localStorage.setItem("userName", response.userName ?? "");
            localStorage.setItem("rol", response.rol ?? "");

            toast.current?.show({ severity: "success", summary: "Login exitoso", detail: `Bienvenido (${response.rol})` });

            if (response.rol === "ADMIN") navigate("/admin");
            else if (response.rol === "MEDICO") navigate("/medico");
            else navigate("/paciente");
        } catch (error) {
            toast.current?.show({ severity: "error", summary: "Error de login", detail: "Usuario o contraseña incorrectos" });
        }
        setLoading(false);
    };

    return (
        <div className="p-m-4" style={{ maxWidth: 400, margin: "0 auto" }}>
            <Toast ref={toast} />
            <h2 className="text-center mb-4">Iniciar Sesión</h2>
            <form onSubmit={handleSubmit} className="p-fluid">
                <div className="p-field mb-3">
                    <label htmlFor="userName">Usuario</label>
                    <InputText id="userName" name="userName" value={formData.userName} onChange={handleChange} autoFocus required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="password">Contraseña</label>
                    <Password id="password" name="password" value={formData.password} onChange={handleChange} feedback={false} toggleMask required />
                </div>
                <Button label={loading ? "Ingresando..." : "Ingresar"} icon="pi pi-sign-in" type="submit" className="p-button-success" disabled={loading} />
            </form>
            <div className="text-center mt-4">
                <p className="mt-2">¿No tienes cuenta? <span style={{ color: '#1976d2', cursor: 'pointer' }} onClick={() => navigate('/registrar-paciente')}>Regístrate aquí</span></p>
            </div>
        </div>
    );
};