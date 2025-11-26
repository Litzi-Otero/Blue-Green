#!/bin/bash
sed -i "s/proxy_pass http:\/\/green_backend;/proxy_pass http:\/\/blue_backend;/" nginx.conf
docker compose restart nginx
echo "Rollback completo → Blue activo"
