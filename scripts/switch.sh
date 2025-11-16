#!/bin/bash

set -e

source ../.env

# Backup config actual
cp nginx.conf nginx.conf.backup

# Edita nginx.conf: cambia proxy_pass a green_backend
sed -i 's/proxy_pass http:\/\/blue_backend;/proxy_pass http:\/\/green_backend;/' nginx.conf

# Reload Nginx
docker-compose restart nginx

# Actualiza tags (swap blue/green)
echo "GREEN_VERSION=$BLUE_VERSION" >> .env
echo "BLUE_VERSION=$GREEN_VERSION" >> .env  # Swap
source ../.env  # Recarga

echo "Switch completado! Green ahora es live. Accede: http://localhost:${NGINX_PORT}"
echo "Versión live: $GREEN_VERSION"