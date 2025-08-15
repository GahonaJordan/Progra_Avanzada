import { Usuario } from "../types/types";
import { fetchAPI } from "./api";


type LoginCredentials = { userName: string; password: string };
// Ajusta el tipo de LoginResponse si el backend solo devuelve texto
type LoginResponse = { userName: string; rol: string };

export const usuariosService = {
    login: async (credentials: LoginCredentials): Promise<LoginResponse> => {
        const authHeader = "Basic " + btoa(`${credentials.userName}:${credentials.password}`);
        // Usa POST, no envíes body, solo el header Authorization
        return await fetchAPI('/usuarios/login', {
            method: 'POST',
            headers: {
                'Authorization': authHeader
            }
        });
    },

    register: async (user: Usuario): Promise<Usuario> => {
        return await fetchAPI('/usuarios/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(user)
        });
    }
}