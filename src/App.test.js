import { render, screen } from '@testing-library/react';
import App from './App';

test('renders app title', () => {
  render(<App />);
  const titleElement = screen.getByText(/Bienvenido a mi App - Litzi Otero/i);
  expect(titleElement).toBeInTheDocument();
});

test('renders version and counter button', () => {
  render(<App />);
  const versionElement = screen.getByText(/Versión:/i);
  const buttonElement = screen.getByText(/Haz clic para incrementar/i);
  expect(versionElement).toBeInTheDocument();
  expect(buttonElement).toBeInTheDocument();
});