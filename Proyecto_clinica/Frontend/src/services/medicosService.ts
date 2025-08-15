import { MedicoRequest, MedicoResponse } from "../types/types";
import { fetchAPI } from "./api"

export const medicosService = {
    findAll: async (): Promise<MedicoResponse[]> => {
        return await fetchAPI("/medicos");
    },

    findById: async (id: number): Promise<MedicoResponse> => {
        return await fetchAPI(`/medicos/${id}`);
    },

    create: async (data: MedicoRequest): Promise<MedicoResponse> => {
        return await fetchAPI("/medicos", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
        });
    },

    update: async (id: number, changes: MedicoRequest): Promise<MedicoResponse> => {
        return await fetchAPI(`/medicos/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(changes),
        });
    },

    delete: async (id: number): Promise<void> => {
        return await fetchAPI(`/medicos/${id}`, {
            method: "DELETE",
        });
    },
}