import React, { useRef, useState } from "react";
import { InputText } from "primereact/inputtext";
import { Calendar } from "primereact/calendar";
import { Button } from "primereact/button";
import { Toast } from "primereact/toast";
import { usuariosService } from "../services/usuariosService";
import { pacienteService } from "../services/pacientesService";
import { PacienteRequest, Usuario } from "../types/types";
import { useNavigate } from "react-router-dom";

export const RegistrarPaciente: React.FC = () => {
    const [formUsuario, setFormUsuario] = useState<Usuario>({ id: 0, userName: "", password: "" });
    const [formPaciente, setFormPaciente] = useState<PacienteRequest>({ nombre: "", apellido: "", fechaNacimiento: "", email: "" });
    const [loading, setLoading] = useState(false);
    const toast = useRef<Toast>(null);
    const navigate = useNavigate();

    const handleChangeUsuario = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFormUsuario({ ...formUsuario, [e.target.name]: e.target.value });
    };

    const handleChangePaciente = (e: React.ChangeEvent<HTMLInputElement>) => {
        setFormPaciente({ ...formPaciente, [e.target.name]: e.target.value });
    };

    const handleFecha = (e: any) => {
        if (e.value) {
            const day = String(e.value.getDate()).padStart(2, '0');
            const month = String(e.value.getMonth() + 1).padStart(2, '0');
            const year = e.value.getFullYear();
            setFormPaciente({ ...formPaciente, fechaNacimiento: `${day}/${month}/${year}` });
        } else {
            setFormPaciente({ ...formPaciente, fechaNacimiento: "" });
        }
    };

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            // 1. Registrar usuario
            const usuarioCreado = await usuariosService.register(formUsuario);
            // 2. Registrar paciente con el id del usuario
            const pacienteData = { ...formPaciente, usuarioId: usuarioCreado.id };
            await pacienteService.create(pacienteData);
            toast.current?.show({ severity: "success", summary: "Registro exitoso", detail: "Paciente registrado correctamente" });
            navigate("/login");
        } catch (error) {
            toast.current?.show({ severity: "error", summary: "Error", detail: "No se pudo registrar el paciente" });
        }
        setLoading(false);
    };

    return (
        <div className="p-m-4" style={{ maxWidth: 500, margin: "0 auto" }}>
            <Toast ref={toast} />
            <h2 className="text-center mb-4">Registro de Paciente</h2>
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
                <h4>Datos de Paciente</h4>
                <div className="p-field mb-3">
                    <label htmlFor="nombre">Nombre</label>
                    <InputText id="nombre" name="nombre" value={formPaciente.nombre} onChange={handleChangePaciente} required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="apellido">Apellido</label>
                    <InputText id="apellido" name="apellido" value={formPaciente.apellido} onChange={handleChangePaciente} required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="fechaNacimiento">Fecha de Nacimiento</label>
                    <Calendar id="fechaNacimiento" value={formPaciente.fechaNacimiento ? new Date(formPaciente.fechaNacimiento.split('/').reverse().join('-')) : null} onChange={handleFecha} dateFormat="dd/mm/yy" showIcon required />
                </div>
                <div className="p-field mb-3">
                    <label htmlFor="email">Email</label>
                    <InputText id="email" name="email" value={formPaciente.email} onChange={handleChangePaciente} required />
                </div>
                <Button label={loading ? "Registrando..." : "Registrar"} icon="pi pi-user-plus" type="submit" className="p-button-success" disabled={loading} />
            </form>
        </div>
    );
};