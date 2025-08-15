
//--------------------------------------------------------------------------

// Paciente
export interface PacienteResponse {
    id: number;
    nombreCompleto: string;
    fechaNacimiento: string; // ISO string desde el backend
    email: string;
}

export interface PacienteRequest {
    nombre: string;
    apellido: string;
    fechaNacimiento: string; // o Date si lo manejas localmente
    email: string;
}


// Médico
export interface MedicoResponse {
    id: number;
    nombreCompleto: string;
    especialidad: string;
}

export interface MedicoRequest {
    nombre: string;
    apellido: string;
    especialidad: string;
}

// Consultorio
export interface ConsultorioResponse  {
    id: number;
    numeroConsultorio: string;
    piso: number;
}

export interface ConsultorioRequest {
    numeroConsultorio: string;
    piso: number;
}

// Cita
export interface CitaResponse {
    id: number;
    fecha: string;   // formato ISO (ej: "2025-08-14")
    hora: string;    // ej: "10:00"
    paciente: PacienteResponse;
    medico: MedicoResponse;
    consultorio: ConsultorioResponse;
}

export interface CitaRequest {
    fecha: string;
    hora: string;
    pacienteId: number;    // Solo el ID del paciente
    medicoId: number;      // Solo el ID del médico
    consultorioId: number; // Solo el ID del consultorio
}

export interface Usuario{
    id: number;
    userName: string;
    password: string;
}




