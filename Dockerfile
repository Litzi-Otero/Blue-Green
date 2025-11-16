# Argumento para la versión
ARG VERSION=latest

# Etapa 1: Build de React
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production=false
COPY . .
RUN npm run build && echo "Version: ${VERSION}" > build/version.txt

# Etapa 2: Nginx (sin envsubst, config fija)
FROM nginx:alpine
# No necesita gettext

# Copia build de React
COPY --from=build /app/build /usr/share/nginx/html

# Copia config fija
COPY nginx.conf /etc/nginx/nginx.conf

# No EXPOSE (Cloud Run ignora, pero para docs)
# EXPOSE 8080  # Comenta o quita, como sugieren en foros para evitar conflictos

LABEL version=${VERSION}

# CMD estándar de Nginx
CMD ["nginx", "-g", "daemon off;"]