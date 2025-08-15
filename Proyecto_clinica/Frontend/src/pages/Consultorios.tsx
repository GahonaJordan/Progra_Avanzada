import React, { useEffect, useRef, useState } from "react";
import { Toast } from "primereact/toast";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { Dialog } from "primereact/dialog";
import { Button } from "primereact/button";
import { InputText } from "primereact/inputtext";
import { ConsultorioRequest, ConsultorioResponse } from "../types/types";
import { consultorioService } from "../services/consultoriosService";
import { InputNumber } from "primereact/inputnumber";

export const Consultorios: React.FC = () => {
    const [consultorios, setConsultorios] = useState<ConsultorioResponse[]>([]);
    const [visible, setVisible] = useState(false);
    const [isEditMode, setIsEditMode] = useState(false);
    const [formData, setFormData] = useState<ConsultorioRequest>({ numeroConsultorio: "", piso: 0, });
    const [selectedConsultorio, setSelectedConsultorio] = useState<ConsultorioResponse | null>(null);
    const toast = useRef<Toast>(null);

    const loadConsultorios = async () => {
        try {
            const response = await consultorioService.findAll();
            setConsultorios(response);
        } catch (error) {
            console.error("Error loading consultorios:", error);
        }
    };

    useEffect(() => {
            loadConsultorios();
    }, []);

    const openNew = () => {
        setIsEditMode(false);
        setFormData({ numeroConsultorio: "", piso: 0 });
        setVisible(true);
    };

    const openEdit = (consultorio: ConsultorioResponse) => {
        setIsEditMode(true);
        setSelectedConsultorio(consultorio);
        setFormData({
            numeroConsultorio: consultorio.numeroConsultorio,
            piso: consultorio.piso
        });
        setVisible(true);
    };

    const hideDialog = () => {
        setVisible(false);
        setSelectedConsultorio(null);
    };

    const saveConsultorio = async () => {
        try {
            if (isEditMode && selectedConsultorio) {
                const response = await consultorioService.update(selectedConsultorio.id, formData);
                setConsultorios(consultorios.map(c => (c.id === response.id ? response : c)));
                toast.current?.show({ severity: "success", summary: "Consultorio actualizado" });
            } else {
                const response = await consultorioService.create(formData);
                setConsultorios([...consultorios, response]);
                toast.current?.show({ severity: "success", summary: "Consultorio creado" });
            }
            loadConsultorios();
            hideDialog();
        } catch (error) {
            console.error("Error saving consultorio:", error);
            toast.current?.show({ severity: "error", summary: "Error al guardar" });
        }
    };

    const deleteConsultorio = async (consultorio: ConsultorioResponse) => {
        try {
            await consultorioService.delete(consultorio.id);
            setConsultorios(consultorios.filter(c => c.id !== consultorio.id));
            toast.current?.show({ severity: "warn", summary: "Consultorio eliminado" });
        } catch (error) {
            console.error("Error deleting consultorio:", error);
            toast.current?.show({ severity: "error", summary: "Error al eliminar" });
        }
    };

    const dialogFooter = (
        <div className="p-d-flex p-jc-end">
            <Button label="Cancelar" icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
            <Button label="Guardar" icon="pi pi-check" className="p-button-success" onClick={saveConsultorio} />
        </div>
    );

    return (
        <div className="p-m-4">
            <h1>Consultorios</h1>
            <Toast ref={toast} />
            <Button label="Nuevo Consultorio" icon="pi pi-plus" className="p-button-success mb-3" onClick={openNew} />

            <DataTable value={consultorios} paginator rows={5} responsiveLayout="scroll">
                <Column field="numeroConsultorio" header="Número de Consultorio" sortable />
                <Column field="piso" header="Piso" sortable />
                <Column 
                    header="Acciones" 
                    body={(rowData) => (
                        <div>
                            <Button icon="pi pi-pencil" className="p-button-text" onClick={() => openEdit(rowData)} />
                            <Button icon="pi pi-trash" className="p-button-text" onClick={() => deleteConsultorio(rowData)} />
                        </div>
                    )} 
                />
            </DataTable>

            <Dialog 
                visible={visible} 
                style={{ width: '450px' }} 
                onHide={hideDialog}
                footer={dialogFooter}
                header={isEditMode ? "Editar Consultorio" : "Nuevo Consultorio"}
            >
                <div className="p-fluid">
                    <div className="p-field">
                        <label htmlFor="numeroConsultorio">Número de Consultorio</label>
                        <InputText id="numeroConsultorio" value={formData.numeroConsultorio} onChange={(e) => setFormData({ ...formData, numeroConsultorio: e.target.value })} />
                    </div>
                    <div className="p-field">
                        <label htmlFor="piso">Piso</label>
                        <InputNumber id="piso" value={formData.piso} onValueChange={(e) => setFormData({ ...formData, piso: e.value ?? 0 })} />
                    </div>
                </div>
            </Dialog>
        </div>
    )

}