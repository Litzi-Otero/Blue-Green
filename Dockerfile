ARG VERSION=latest

FROM node:18-alpine AS build
WORKDIR /app

ARG VERSION
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build && echo "Version: ${VERSION}" > build/version.txt

FROM nginx:alpine
ARG VERSION

COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
LABEL version=${VERSION}

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD /bin/sh -c 'test -f /var/run/nginx.pid'

CMD ["nginx", "-g", "daemon off;"]
