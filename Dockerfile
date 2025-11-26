ARG VERSION

###############################################
# BUILD REACT
###############################################
FROM node:18-alpine AS build
WORKDIR /app

# --- Variables para Blue/Green ---
ARG VERSION
ENV REACT_APP_ENV=$VERSION

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build && echo "Version: ${VERSION}" > build/version.txt

###############################################
# NGINX (FINAL)
###############################################
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

LABEL version=${VERSION}

CMD ["nginx", "-g", "daemon off;"]
