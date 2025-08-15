import React, { useEffect, useRef, useState } from "react";
import { Toast } from "primereact/toast";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { Dialog } from "primereact/dialog";
import { Button } from "primereact/button";
import { InputText } from "primereact/inputtext";
import { Calendar } from "primereact/calendar";
import { pacienteService } from "../services/pacientesService";
import { PacienteRequest, PacienteResponse } from "../types/types";

export const Pacientes: React.FC = () => {
    const [pacientes, setPacientes] = useState<PacienteResponse[]>([]);
    const [visible, setVisible] = useState(false);
    const [isEditMode, setIsEditMode] = useState(false);
    const [formData, setFormData] = useState<PacienteRequest>({ nombre: "", apellido: "", fechaNacimiento: "", email: "" });
    const [selectedPaciente, setSelectedPaciente] = useState<PacienteResponse | null>(null);
    const toast = useRef<Toast>(null);

    const loadPacientes = async () => {
        try {
            const response = await pacienteService.findAll();
            setPacientes(response);
        } catch (error) {
            console.error("Error loading pacientes:", error);
        }
    };

    useEffect(() => {
        loadPacientes();
    }, []);

    const openNew = () => {
        setIsEditMode(false);
        setFormData({ nombre: "", apellido: "", fechaNacimiento: "", email: "" });
        setVisible(true);
    };

    const openEdit = (paciente: PacienteResponse) => {
    setIsEditMode(true);
    setSelectedPaciente(paciente);

    const [nombre, ...resto] = paciente.nombreCompleto.split(' ');
    const apellido = resto.join(' ');

    setFormData({
        nombre: nombre || '',
        apellido: apellido || '',
        fechaNacimiento: paciente.fechaNacimiento,
        email: paciente.email
    });

    setVisible(true);
};


    const hideDialog = () => {
        setVisible(false);
        setSelectedPaciente(null);
    };

    const savePaciente = async () => {
        try {
            if (isEditMode && selectedPaciente) {
                const response = await pacienteService.update(selectedPaciente.id, formData);
                setPacientes(pacientes.map(p => (p.id === response.id ? response : p)));
                toast.current?.show({ severity: "success", summary: "Paciente actualizado" });
            } else {
                const response = await pacienteService.create(formData);
                setPacientes([...pacientes, response]);
                toast.current?.show({ severity: "success", summary: "Paciente creado" });
            }
            loadPacientes();
            hideDialog();
        } catch (error) {
            console.error("Error saving paciente:", error);
            toast.current?.show({ severity: "error", summary: "Error al guardar" });
        }
    };

    const deletePaciente = async (paciente: PacienteResponse) => {
        try {
            await pacienteService.delete(paciente.id);
            setPacientes(pacientes.filter(p => p.id !== paciente.id));
            toast.current?.show({ severity: "warn", summary: "Paciente eliminado" });
            loadPacientes();
            hideDialog();
        } catch (error) {
            console.error("Error deleting paciente:", error);
            toast.current?.show({ severity: "error", summary: "Error al eliminar" });
        }
    };

    const dialogFooter = (
        <div className="p-d-flex p-jc-end">
            <Button label="Cancelar" icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
            <Button label="Guardar" icon="pi pi-check" className="p-button-success" onClick={savePaciente} />
        </div>
    );

    const rol = localStorage.getItem('rol');

    return (
        <div className="p-m-4">
            <h1>Gestión de Pacientes</h1>
            <Toast ref={toast} />
           {/* <Button label="Nuevo Paciente" icon="pi pi-plus" onClick={openNew} className="p-mb-3" /> */}

            <DataTable value={pacientes} paginator rows={5} responsiveLayout="scroll">
                <Column field="id" header="ID" />
                <Column field="nombreCompleto" header="Nombre Completo" />
                <Column field="fechaNacimiento" header="Fecha de Nacimiento" />
                <Column field="email" header="Email" />
                <Column
                    header="Acciones"
                    body={(rowData) => (
                        <div className="p-d-flex p-jc-around">
                            {(rol === 'ADMIN' || rol === 'MEDICO') && (
                                <Button icon="pi pi-pencil" className="p-button-rounded p-button-warning p-mr-2" onClick={() => openEdit(rowData)} />
                            )}
                            {rol === 'ADMIN' && (
                                <Button icon="pi pi-trash" className="p-button-rounded p-button-danger" onClick={() => deletePaciente(rowData)} />
                            )}
                        </div>
                    )}
                />
            </DataTable>

            <Dialog
                header={isEditMode ? "Editar Paciente" : "Nuevo Paciente"}
                visible={visible}
                onHide={hideDialog}
                footer={dialogFooter}
                style={{ width: "30vw" }}
            >
                <div className="p-fluid">
                    <div className="p-field">
                        <label htmlFor="nombre">Nombre</label>
                        <InputText id="nombre" value={formData.nombre} onChange={(e) => setFormData({ ...formData, nombre: e.target.value })} />
                    </div>
                    <div className="p-field">
                        <label htmlFor="apellido">Apellido</label>
                        <InputText id="apellido" value={formData.apellido} onChange={(e) => setFormData({ ...formData, apellido: e.target.value })} />
                    </div>
                    <div className="p-field">
                        <label htmlFor="fechaNacimiento">Fecha de Nacimiento</label>
                        <Calendar
                            id="fechaNacimiento"
                            value={formData.fechaNacimiento ? new Date(formData.fechaNacimiento.split('/').reverse().join('-')) : null}
                            onChange={(e) => {
                                if (e.value) {
                                    const day = String(e.value.getDate()).padStart(2, '0');
                                    const month = String(e.value.getMonth() + 1).padStart(2, '0');
                                    const year = e.value.getFullYear();
                                    setFormData({ ...formData, fechaNacimiento: `${day}/${month}/${year}` });
                                } else {
                                    setFormData({ ...formData, fechaNacimiento: "" });
                                }
                            }}
                            dateFormat="dd/mm/yy"
                            showIcon
                        />
                    </div>
                    <div className="p-field">
                        <label htmlFor="email">Email</label>
                        <InputText id="email" value={formData.email} onChange={(e) => setFormData({ ...formData, email: e.target.value })} />
                    </div>
                </div>
            </Dialog>
        </div>
    );
};
