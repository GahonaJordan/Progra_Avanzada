import React from "react";
import { Menubar } from 'primereact/menubar';
import { useNavigate } from "react-router-dom";

export const Navbar: React.FC = () => {

    const navigare = useNavigate();
    const rol = localStorage.getItem('rol');
    const isLogged = !!rol;

    const handleLogout = () => {
        localStorage.removeItem('rol');
        localStorage.removeItem('userName');
        navigare('/login');
    };

    let items: any[] = [];
    if (!isLogged) {
        items = [
            { label: 'Inicio', icon: 'pi pi-fw pi-home', command: () => navigare('/') },
            { label: 'Iniciar sesión', icon: 'pi pi-sign-in', command: () => navigare('/login') }
        ];
    } else if (rol === 'PACIENTE') {
        items = [
            { label: 'Inicio', icon: 'pi pi-fw pi-home', command: () => navigare('/') },
            { label: 'Médicos', icon: 'pi pi-user-md', command: () => navigare('/medicos') },
            { label: 'Citas', icon: 'pi pi-calendar', command: () => navigare('/citas') },
            { separator: true },
            { label: 'Cerrar sesión', icon: 'pi pi-sign-out', command: handleLogout, className: 'p-menuitem-logout' }
        ];
    } else if (rol === 'MEDICO' || rol === 'ADMIN') {
        items = [
            { label: 'Inicio', icon: 'pi pi-fw pi-home', command: () => navigare('/') },
            { label: 'Pacientes', icon: 'pi pi-users', command: () => navigare('/pacientes') },
            { label: 'Médicos', icon: 'pi pi-user-md', command: () => navigare('/medicos') },
            { label: 'Consultorios', icon: 'pi pi-building', command: () => navigare('/consultorios') },
            { label: 'Citas', icon: 'pi pi-calendar', command: () => navigare('/citas') },
            { label: 'Dashboard', icon: 'pi pi-info', command: () => navigare('/dashboard') },
            { separator: true },
            { label: 'Cerrar sesión', icon: 'pi pi-sign-out', command: handleLogout, className: 'p-menuitem-logout' }
        ];
    }

    return <Menubar model={items} />;
}