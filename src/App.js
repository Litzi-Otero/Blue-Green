import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);
  const [env, setEnv] = useState("...");

  useEffect(() => {
    fetch("/version.txt")
      .then(res => res.text())
      .then(text => {
        if (text.includes("v1")) setEnv("BLUE");
        else if (text.includes("v2")) setEnv("GREEN");
        else setEnv("UNKNOWN");
      })
      .catch(() => setEnv("ERROR"));
  }, []);

  const handleClick = () => {
    setCount(count + 1);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Bienvenido - Litzi Otero G</h1>

        <p>
          Ambiente activo:{" "}
          <span style={{ 
            fontWeight: "bold", 
            color: env === "BLUE" ? "#3498db" : env === "GREEN" ? "#2ecc71" : "#e74c3c"
          }}>
            {env}
          </span>
        </p>

        <button className="counter-btn" onClick={handleClick}>
          Haz clic para incrementar
        </button>

        <p>Contador: <span className="counter">{count}</span></p>
      </header>
    </div>
  );
}

export default App;
