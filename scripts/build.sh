#!/bin/bash

set -e  # Exit on error

source ../.env || { echo "Copia .env.example a .env"; exit 1; }

VERSION=${1:-latest}
echo "Building Docker image: simple-react-app:${VERSION}"

# Build React
npm run build

# Build Docker
docker build --build-arg VERSION=$VERSION -t simple-react-app:${VERSION} .

echo "Imagen lista: simple-react-app:${VERSION}"