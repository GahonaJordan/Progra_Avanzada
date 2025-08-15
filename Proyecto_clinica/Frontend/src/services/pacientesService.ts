import { PacienteRequest, PacienteResponse } from "../types/types";
import { fetchAPI } from "./api";

export const pacienteService = {
    findAll: async (): Promise<PacienteResponse[]> => {
        return await fetchAPI('/pacientes');
    },

    findById: async (id: number): Promise<PacienteResponse> => {
        return await fetchAPI(`/pacientes/${id}`);
    },

    create: async (data: PacienteRequest): Promise<PacienteResponse> => {
        return await fetchAPI('/pacientes', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });
    },

    update: async (id: number, changes: PacienteRequest): Promise<PacienteResponse> => {
        return await fetchAPI(`/pacientes/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(changes),
        });
    },

    delete: async (id: number): Promise<void> => {
    const response = await fetchAPI(`/pacientes/${id}`, {
        method: 'DELETE',
    });
    // No proceses el cuerpo, solo verifica el status
    if (response && response.status && response.status !== 204 && response.status !== 200) {
        throw new Error('No se pudo eliminar el paciente');
    }
}
}
