#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/home/litzi/Blue-Green"
STATE_FILE="$APP_DIR/active_color"
NGINX_SYMLINK="/etc/nginx/active_backend.conf"

echo "=== Deploy Blue-Green con puertos ==="

# 1. Color actual
if [[ -f $STATE_FILE ]]; then
    ACTIVE=$(cat "$STATE_FILE")
else
    ACTIVE="blue"
    echo "blue" > "$STATE_FILE"
fi

if [[ "$ACTIVE" == "blue" ]]; then
    NEW="green"
else
    NEW="blue"
fi

echo "Actual: $ACTIVE"
echo "Nuevo:  $NEW"

# 2. Levantar servicios
cd "$APP_DIR"
docker compose pull
docker compose up -d

# 3. Health check
if [[ "$NEW" == "blue" ]]; then
    PORT=8081
else
    PORT=8082
fi

echo "Health check puerto $PORT..."
sleep 3

if curl -fsS "http://localhost:$PORT/healthz" >/dev/null; then
    echo "OK"
else
    echo "ERROR: Health check falló"
    exit 1
fi

# 4. Cambiar symlink de Nginx
if [[ "$NEW" == "blue" ]]; then
    sudo ln -sf /etc/nginx/blue_backend.conf $NGINX_SYMLINK
else
    sudo ln -sf /etc/nginx/green_backend.conf $NGINX_SYMLINK
fi

sudo nginx -s reload

# 5. Guardar estado
echo "$NEW" > "$STATE_FILE"

echo "🎉 Nuevo color activo: $NEW"
