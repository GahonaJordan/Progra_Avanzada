import React, { useEffect, useRef, useState } from "react";
import { Toast } from "primereact/toast";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { Dialog } from "primereact/dialog";
import { Button } from "primereact/button";
import { InputText } from "primereact/inputtext";
import { CitaRequest, 
    CitaResponse, 
    PacienteResponse, 
    MedicoResponse, 
    ConsultorioResponse  } from "../types/types";
import { pacienteService } from "../services/pacientesService";
import { medicosService } from "../services/medicosService";
import { consultorioService } from "../services/consultoriosService";
import { citaService } from "../services/citasService";
import { Dropdown } from "primereact/dropdown";

export const Citas: React.FC = () => {
    const rol = localStorage.getItem('rol');
    const pacienteId = localStorage.getItem('pacienteId'); // Debes guardar el id del paciente en localStorage al iniciar sesión
    const [filterName, setFilterName] = useState("");
    const [citas, setCitas] = useState<CitaResponse[]>([]);
    const [pacientes, setPacientes] = useState<PacienteResponse[]>([]);
    const [medicos, setMedicos] = useState<MedicoResponse[]>([]);
    const [consultorios, setConsultorios] = useState<ConsultorioResponse[]>([]);
    const [visible, setVisible] = useState(false);
    const [isEditMode, setIsEditMode] = useState(false);
     const [formData, setFormData] = useState<CitaRequest>({
        fecha: "",
        hora: "",
        pacienteId: 0,
        medicoId: 0,
        consultorioId: 0
    });
    const [selectedCita, setSelectedCita] = useState<CitaResponse | null>(null);
    const toast = useRef<Toast>(null);

    const loadCitas = async () => {
        try {
            const response = await citaService.findAll();
            // Si es paciente, filtra solo sus citas
            if (rol === 'PACIENTE' && pacienteId) {
                setCitas(response.filter((cita: any) => String(cita.paciente.id) === pacienteId));
            } else {
                setCitas(response);
            }
        } catch (error) {
            console.error("Error loading citas:", error);
        }
    };
    const loadPacientes = async () => {
        try {
            const response = await pacienteService.findAll();
            setPacientes(response);
        } catch (error) {
            console.error("Error loading pacientes:", error);
        }
    };
    const loadMedicos = async () => {
        try {
            const response = await medicosService.findAll();
            setMedicos(response);
        } catch (error) {
            console.error("Error loading medicos:", error);
        }
    };
    const loadConsultorios = async () => {
        try {
            const response = await consultorioService.findAll();
            setConsultorios(response);
        } catch (error) {
            console.error("Error loading consultorios:", error);
        }
    };

    useEffect(() => {
        loadPacientes();
        loadMedicos();
        loadConsultorios();
        loadCitas();
    }, []);

    const openNew = () => {
        setIsEditMode(false);
        setFormData({
            fecha: "",
            hora: "",
            pacienteId: 0,
            medicoId: 0,
            consultorioId: 0
        });
        setVisible(true);
    };

    const openEdit = (cita: CitaResponse) => {
        setIsEditMode(true);
        setSelectedCita(cita);
        setFormData({
            fecha: cita.fecha,
            hora: cita.hora,
            pacienteId: cita.paciente.id, // Debe ser el ID para el formulario
            medicoId: cita.medico.id,     // Debe ser el ID para el formulario
            consultorioId: cita.consultorio.id // Debe ser el ID para el formulario
        });
        setVisible(true);
    };

    const hideDialog = () => {
        setVisible(false);
        setSelectedCita(null);
    };

    const saveCita = async () => {
        try {
            if (isEditMode && selectedCita) {
                // Update existing cita
                await citaService.update(selectedCita.id, formData);
                toast.current?.show({ severity: "success", summary: "Cita actualizada", life: 3000 });
            } else {
                // Create new cita
                await citaService.create(formData);
                toast.current?.show({ severity: "success", summary: "Cita creada", life: 3000 });
            }
            loadCitas();
            hideDialog();
        } catch (error) {
            console.error("Error saving cita:", error);
            toast.current?.show({ severity: "error", summary: "Error al guardar cita", life: 3000 });
        }
    };

    const deleteCita = async (cita: CitaResponse) => {
    try {
        await citaService.delete(cita.id);
        setCitas(citas.filter(c => c.id !== cita.id));
        toast.current?.show({ severity: "warn", summary: "Cita eliminada" });
        loadCitas();
            hideDialog();
    } catch (error) {
            console.error("Error deleting cita:", error);
            toast.current?.show({ severity: "error", summary: "Error al eliminar cita", life: 3000 });
        }
    };

    const dialogFooter = (
        <div className="p-d-flex p-jc-end">
            <Button label="Cancelar" icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
            <Button label="Guardar" icon="pi pi-check" className="p-button-success" onClick={saveCita} />
        </div>
    );

    // Render functions for DataTable columns
    const renderPaciente = (rowData: CitaResponse) => rowData.paciente?.nombreCompleto || "";
    const renderMedico = (rowData: CitaResponse) => rowData.medico?.nombreCompleto || "";
    const renderConsultorio = (rowData: CitaResponse) => rowData.consultorio?.numeroConsultorio || "";

    return (
        <div className="p-m-4">
            <h1>Gestión de Citas</h1>
            <Toast ref={toast} />
            <Button label="Nueva Cita" icon="pi pi-plus" className="p-mb-3" onClick={openNew} />

            {(rol === 'MEDICO' || rol === 'ADMIN') && (
                <div className="p-field mb-3" style={{ maxWidth: 300 }}>
                    <label htmlFor="filterName">Filtrar por paciente</label>
                    <InputText id="filterName" value={filterName} onChange={e => setFilterName(e.target.value)} placeholder="Nombre del paciente" />
                </div>
            )}

            <DataTable value={
                (rol === 'MEDICO' || rol === 'ADMIN') && filterName
                    ? citas.filter(cita => cita.paciente.nombreCompleto.toLowerCase().includes(filterName.toLowerCase()))
                    : citas
            } paginator rows={5} responsiveLayout="scroll">
                <Column field="fecha" header="Fecha" sortable />
                <Column field="hora" header="Hora" sortable />
                <Column field="paciente" header="Paciente" body={renderPaciente} sortable />
                <Column field="medico" header="Médico" body={renderMedico} sortable />
                <Column field="consultorio" header="Consultorio" body={renderConsultorio} sortable />
                <Column
                    header="Acciones"
                    body={(rowData) => (
                        <div className="p-d-flex p-jc-around">
                            <Button icon="pi pi-pencil" className="p-button-text" onClick={() => openEdit(rowData)} />
                            <Button icon="pi pi-trash" className="p-button-text" onClick={() => deleteCita(rowData)} />
                        </div>
                    )}
                />
            </DataTable>

            <Dialog visible={visible} style={{ width: "450px" }} header="Detalles de la Cita" modal footer={dialogFooter} onHide={hideDialog}>
                <div className="p-field">
                    <label htmlFor="fecha">Fecha</label>
                    <InputText id="fecha" value={formData.fecha} onChange={(e) => setFormData({ ...formData, fecha: e.target.value })} />
                </div>
                <div className="p-field">
                    <label htmlFor="hora">Hora</label>
                    <InputText id="hora" value={formData.hora} onChange={(e) => setFormData({ ...formData, hora: e.target.value })} />
                </div>
                <div className="p-field">
                    <label htmlFor="pacienteId">Paciente</label>
                    <Dropdown
                        id="pacienteId"
                        value={formData.pacienteId}
                        options={pacientes}
                        optionLabel="nombreCompleto"
                        optionValue="id"
                        placeholder="Seleccione un paciente"
                        onChange={(e) => setFormData({ ...formData, pacienteId: e.value })}
                    />
                </div>
                <div className="p-field">
                    <label htmlFor="medicoId">Médico</label>
                    <Dropdown
                        id="medicoId"
                        value={formData.medicoId}
                        options={medicos}
                        optionLabel="nombreCompleto"
                        optionValue="id"
                        placeholder="Seleccione un médico"
                        onChange={(e) => setFormData({ ...formData, medicoId: e.value })}
                    />
                </div>
                <div className="p-field">
                    <label htmlFor="consultorioId">Consultorio</label>
                    <Dropdown
                        id="consultorioId"
                        value={formData.consultorioId}
                        options={consultorios}
                        optionLabel="numeroConsultorio"
                        optionValue="id"
                        placeholder="Seleccione un consultorio"
                        onChange={(e) => setFormData({ ...formData, consultorioId: e.value })}
                    />
                </div>
            </Dialog>
        </div>
    );
}