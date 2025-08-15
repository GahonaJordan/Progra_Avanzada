import { CitaRequest, CitaResponse } from "../types/types";
import { fetchAPI } from "./api";

export const citaService = {
    findAll: async (): Promise<CitaResponse[]> => {
        return await fetchAPI('/citas');
    },

    findById: async (id: number): Promise<CitaResponse> => {
        return await fetchAPI(`/citas/${id}`);
    },

    create: async (data: CitaRequest): Promise<CitaResponse> => {
        return await fetchAPI('/citas', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });
    },

    update: async (id: number, changes: CitaRequest): Promise<CitaResponse> => {
        return await fetchAPI(`/citas/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(changes),
        });
    },

    delete: async (id: number): Promise<void> => {
    const response = await fetchAPI(`/citas/${id}`, {
        method: 'DELETE',
    });
    // No proceses el cuerpo, solo verifica el status
    if (response && response.status && response.status !== 204 && response.status !== 200) {
        throw new Error('No se pudo eliminar la cita');
    }
}
}