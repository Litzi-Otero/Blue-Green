ARG VERSION=latest

# ============================
# 1) Build del React
# ============================
FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build && echo "Version: ${VERSION}" > build/version.txt

# ============================
# 2) Contenedor final con Nginx
# ============================
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

LABEL version=${VERSION}

CMD ["nginx", "-g", "daemon off;"]
