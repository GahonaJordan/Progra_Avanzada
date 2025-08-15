import React from "react";
import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import { Navbar } from "./components/Navbar";
import { Inicio } from "./pages/Inicio";
import { Dashboard } from "./pages/dashboard";
import { Pacientes } from "./pages/Pacientes";
import { Medicos } from "./pages/Medicos";
import { Consultorios } from "./pages/Consultorios";
import { Citas } from "./pages/Citas";
import { Login } from "./pages/Login";
import { RegistrarPaciente } from "./pages/RegistrarPaciente";
import { RegistrarMedico } from "./pages/RegistrarMedico";

const App: React.FC = () => {
  return (
    <Router>
      <Navbar />
      <div className="p-m-4">
        <Routes>
          <Route path="/" element={<Inicio />} />
          <Route path="/pacientes" element={<Pacientes />} />
          <Route path="/medicos" element={<Medicos />} />
          <Route path="/consultorios" element={<Consultorios />} />
          <Route path="/citas" element={<Citas />} />
          <Route path="/login" element={<Login />} />
          <Route path="/registrar-paciente" element={<RegistrarPaciente />} />
          <Route path="/registrar-medico" element={<RegistrarMedico />} />
          <Route path="/dashboard" element={<Dashboard />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;