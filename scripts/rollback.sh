#!/bin/bash

set -e

source ../.env

# Restaura config backup
cp nginx.conf.backup nginx.conf

# Reload
docker-compose restart nginx

echo "Rollback completado! Blue ahora es live."