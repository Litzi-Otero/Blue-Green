import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css'; // (No lo usamos, pero CRA lo espera)
import App from './App';
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// Si quieres reportar performance en desarrollo
reportWebVitals();