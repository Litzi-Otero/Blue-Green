#!/bin/bash

set -e

source ../.env

NEW_VERSION=${1:-$GREEN_VERSION}
echo "Deploying to green: simple-react-app:${NEW_VERSION}"

# Build si no existe
docker pull simple-react-app:${NEW_VERSION} || ../scripts/build.sh $NEW_VERSION

# Stop green si running
docker-compose stop green

# Run green con nueva imagen
docker-compose up -d green

echo "Green deployed: $NEW_VERSION"