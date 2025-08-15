import React, { useState, useRef } from "react";
import { InputText } from "primereact/inputtext";
import { Button } from "primereact/button";
import { Toast } from "primereact/toast";
import { medicosService } from "../services/medicosService";
import { usuariosService } from "../services/usuariosService";
import { Usuario } from "../types/types";
import { MedicoRequest } from "../types/types";
import { useNavigate } from "react-router-dom";

export const RegistrarMedico: React.FC = () => {
    const [formUsuario, setFormUsuario] = useState<Usuario>({ id: 0, userName: "", password: "" });
    const [formMedico, setFormMedico] = useState<MedicoRequest>({ nombre: "", apellido: "", especialidad: "" });
    const [loading, setLoading] = useState(false);
    const toast = useRef<Toast>(null);
    const navigate = useNavigate();

    const handleChangeUsuario = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFormUsuario({ ...formUsuario, [e.target.name]: e.target.value });
    };
    const handleChangeMedico = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFormMedico({ ...formMedico, [e.target.name]: e.target.value });
    };

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            // 1. Registrar usuario con rol MÉDICO
            const usuarioDTO = { ...formUsuario, rol: "MEDICO" };
            const usuarioCreado = await usuariosService.register(usuarioDTO);
            // 2. Registrar médico con el id del usuario
            const medicoData = { ...formMedico, usuarioId: usuarioCreado.id };
            await medicosService.create(medicoData);
            toast.current?.show({ severity: "success", summary: "Registro exitoso", detail: "Médico registrado correctamente" });
            navigate("/medicos");
        } catch (error) {
            toast.current?.show({ severity: "error", summary: "Error", detail: "No se pudo registrar el médico" });
        }
        setLoading(false);
    };

    return (
        <div className="p-m-4" style={{ maxWidth: 500, margin: "0 auto" }}>
            <Toast ref={toast} />
            <h2 className="text-center mb-4">Registro de Médico</h2>
            <form onSubmit={handleRegister} className="p-fluid">
                <h4>Datos de Usuario</h4>
                <div className="p-field mb-3">
                    <label htmlFor="userName">Usuario</label>
                    <InputText id="userName" name="userName" value={formUsuario.userName} onChange={handleChangeUsuario} required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="password">Contraseña</label>
                    <InputText id="password" name="password" type="password" value={formUsuario.password} onChange={handleChangeUsuario} required />
                </div>
                <h4>Datos de Médico</h4>
                <div className="p-field mb-3">
                    <label htmlFor="nombre">Nombre</label>
                    <InputText id="nombre" name="nombre" value={formMedico.nombre} onChange={handleChangeMedico} required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="apellido">Apellido</label>
                    <InputText id="apellido" name="apellido" value={formMedico.apellido} onChange={handleChangeMedico} required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="especialidad">Especialidad</label>
                    <InputText id="especialidad" name="especialidad" value={formMedico.especialidad} onChange={handleChangeMedico} required />
                </div>
                <Button label={loading ? "Registrando..." : "Registrar"} icon="pi pi-user-plus" type="submit" className="p-button-success" disabled={loading} />
            </form>
        </div>
    );
};
