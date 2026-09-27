FROM node:22-alpine AS web-build
WORKDIR /web
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

FROM caddy:2-alpine
COPY backend/caddy/Caddyfile /etc/caddy/Caddyfile
COPY --from=web-build /web/dist /srv
