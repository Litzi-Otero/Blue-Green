import React, { useState, useEffect } from "react";
import "./App.css";

function App() {
  const [env, setEnv] = useState("DESCONOCIDO");

  useEffect(() => {
    fetch("/version.txt")
      .then((res) => res.text())
      .then((txt) => {
        if (txt.includes("v1")) setEnv("BLUE");
        else if (txt.includes("v2")) setEnv("GREEN");
        else setEnv("UNKNOWN");
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Bienvenido a mi App - Litzi Otero</h1>
        <p>Entorno activo: 
          <strong style={{ color: env === "BLUE" ? "dodgerblue" : "limegreen" }}>
            {env}
          </strong>
        </p>
      </header>
    </div>
  );
}

export default App;
