FROM node:22-alpine AS web-build
WORKDIR /web
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

FROM caddy:2-alpine
ARG CADDYFILE=Caddyfile
COPY backend/caddy/${CADDYFILE} /etc/caddy/Caddyfile
COPY backend/caddy/public/ /srv/public/
COPY backend/caddy/admin/ /srv/admin/
COPY --from=web-build /web/dist/ /srv/app/
