import React, { useState } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);

  const ENV = process.env.REACT_APP_ENV || "UNKNOWN";

  return (
    <div className="App">
      <header className="App-header">
        <h1>Bienvenido - Litzi Otero</h1>

        <p>
          Ambiente activo:{" "}
          <span
            style={{
              fontWeight: "bold",
              color:
                ENV === "BLUE" ? "#3498db" :
                ENV === "GREEN" ? "#2ecc71" :
                "#e74c3c"
            }}
          >
            {ENV}
          </span>
        </p>

        <button onClick={() => setCount(count + 1)}>
          Haz clic para incrementar
        </button>

        <p>Contador: {count}</p>
      </header>
    </div>
  );
}

export default App;
