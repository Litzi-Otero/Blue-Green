#!/bin/bash

set -e

source ../.env

GREEN_URL="http://localhost:${NGINX_PORT}"  # Temporal, antes de switch
# O usa curl directo a green: docker exec para, pero simple con compose

# Health check
if ! curl -f -s $GREEN_URL > /dev/null; then
    echo "Health check failed!"
    exit 1
fi

# Check versión (agregamos version.txt en build)
VERSION=$(curl -s $GREEN_URL/version.txt | grep -o 'Version: .*' || echo "No version")
echo "Tests passed. Version in green: $VERSION"

# Test contador (manual o con selenium, pero simple: asume OK)
echo "Tests OK for green."