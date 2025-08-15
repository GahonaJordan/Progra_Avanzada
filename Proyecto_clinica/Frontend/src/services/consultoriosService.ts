import { ConsultorioRequest, ConsultorioResponse } from "../types/types";
import { fetchAPI } from "./api";

export const consultorioService = {
    findAll: async (): Promise<ConsultorioResponse[]> => {
        return await fetchAPI('/consultorios');
    },

    findById: async (id: number): Promise<ConsultorioResponse> => {
        return await fetchAPI(`/consultorios/${id}`);
    },

    create: async (data: ConsultorioRequest): Promise<ConsultorioResponse> => {
        return await fetchAPI('/consultorios', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        });
    },

    update: async (id: number, changes: ConsultorioRequest): Promise<ConsultorioResponse> => {
            return await fetchAPI(`/consultorios/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(changes),
            });
    },

    delete: async (id: number): Promise<void> => {
        return await fetchAPI(`/consultorios/${id}`, {
            method: 'DELETE',
        });
    }
};