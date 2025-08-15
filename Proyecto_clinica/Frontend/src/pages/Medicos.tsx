import React, { useEffect, useRef, useState } from "react";
import { Toast } from "primereact/toast";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { Dialog } from "primereact/dialog";
import { Button } from "primereact/button";
import { InputText } from "primereact/inputtext";
import { MedicoRequest, MedicoResponse } from "../types/types";
import { medicosService } from "../services/medicosService";
import { useNavigate } from "react-router-dom";

export const Medicos: React.FC = () => {
    const [medicos, setMedicos] = useState<MedicoResponse[]>([]);
    const [visible, setVisible] = useState(false);
    const [isEditMode, setIsEditMode] = useState(false);
    const [formData, setFormData] = useState<MedicoRequest>({ nombre: "", apellido: "", especialidad: "",  });
    const [selectedMedico, setSelectedMedico] = useState<MedicoResponse | null>(null);
    const toast = useRef<Toast>(null);

    const loadMedicos = async () => {
        try {
            const response = await medicosService.findAll();
            setMedicos(response);
        } catch (error) {
            console.error("Error loading medicos:", error);
        }
    };

    useEffect(() => {
        loadMedicos();
    }, []);

    const openNew = () => {
        setIsEditMode(false);
        setFormData({ nombre: "", apellido: "", especialidad: "" });
        setVisible(true);
    };

    const openEdit = (medico: MedicoResponse) => {
        setIsEditMode(true);
        setSelectedMedico(medico);

        const [nombre, ...resto] = medico.nombreCompleto.split(' ');
        const apellido = resto.join(' ');

        setFormData({
            nombre: nombre || '',
            apellido: apellido || '',
            especialidad: medico.especialidad
        });

        setVisible(true);
    };

    const hideDialog = () => {
        setVisible(false);
        setSelectedMedico(null);
    };

    const saveMedico = async () => {
        try {
            if (isEditMode && selectedMedico) {
                const response = await medicosService.update(selectedMedico.id, formData);
                setMedicos(medicos.map(m => (m.id === selectedMedico.id ? response : m)));
                toast.current?.show({ severity: "success", summary: "Success", detail: "Medico updated successfully" });
            } else {
                const response = await medicosService.create(formData);
                setMedicos([...medicos, response]);
                toast.current?.show({ severity: "success", summary: "Success", detail: "Medico created successfully" });
            }
            loadMedicos();
            hideDialog();
        } catch (error) {
            console.error("Error saving medico:", error);
            toast.current?.show({ severity: "error", summary: "Error", detail: "Error saving medico" });
        }
    };

    const deleteMedico = async (medico: MedicoResponse) => {
        try {
            await medicosService.delete(medico.id);
            setMedicos(medicos.filter(m => m.id !== medico.id));
            toast.current?.show({ severity: "warn", summary: "Success", detail: "Medico deleted successfully" });
        } catch (error) {
            console.error("Error deleting medico:", error);
            toast.current?.show({ severity: "error", summary: "Error", detail: "Error deleting medico" });
        }
    };

    const dialogFooter = (
        <div className="p-d-flex p-jc-end">
            <Button label="Cancelar" icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
            <Button label="Guardar" icon="pi pi-check" className="p-button-success" onClick={saveMedico} />
        </div>
    );

    const rol = localStorage.getItem('rol');
    const navigate = useNavigate();

    return (
        <div className="p-m-4">
            <h1>Gestión de Médicos</h1>
            <Toast ref={toast} />
            {rol === 'ADMIN' && (
                <Button label="Nuevo Médico" icon="pi pi-user-plus" className="p-mb-3" onClick={() => navigate('/registrar-medico')} />
            )}

            <DataTable value={medicos} paginator rows={5} responsiveLayout="scroll">
                <Column field="id" header="ID" />
                <Column field="nombreCompleto" header="Nombre Completo" />
                <Column field="especialidad" header="Especialidad" />
                <Column
                    header="Acciones"
                    body={(rowData) => (
                        rol === 'ADMIN' ? (
                            <div className="p-d-flex p-jc-around">
                                <Button icon="pi pi-pencil" className="p-button-rounded p-button-warning p-mr-2" onClick={() => openEdit(rowData)} />
                                <Button icon="pi pi-trash" className="p-button-rounded p-button-danger" onClick={() => deleteMedico(rowData)} />
                            </div>
                        ) : null
                    )}
                />
            </DataTable>

            <Dialog
                header={isEditMode ? "Editar Médico" : "Nuevo Médico"}
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
                        <label htmlFor="especialidad">Especialidad</label>
                        <InputText id="especialidad" value={formData.especialidad} onChange={(e) => setFormData({ ...formData, especialidad: e.target.value })} />
                    </div>
                </div>
            </Dialog>
        </div>
    );
};
