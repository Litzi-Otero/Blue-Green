import React, { useState } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    setCount(count + 1);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Bienvenido a mi App - Litzi Otero</h1>
        <p>Versión: <span className="version">2.0.2 - Blue-Green Ready</span></p>
        <button className="counter-btn" onClick={handleClick}>
          Haz clic para incrementar
        </button>
        <p>Contador: <span className="counter">{count}</span></p>
      </header>
    </div>
  );
}

export default App;