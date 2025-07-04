# syntax=docker/dockerfile:1
ARG NODE_VERSION=24

FROM node:${NODE_VERSION}-alpine3.22 AS base
LABEL maintainer="apooorva01@gmail.com"
WORKDIR /usr/src/app
EXPOSE 4000

FROM base AS dev
COPY package.json package-lock.json ./
RUN npm ci --include=dev
COPY . .
USER node
CMD [ "npm", "run", "dev" ]

FROM base AS prod
COPY package.json package-lock.json ./
 RUN npm ci --omit=dev
COPY . .
USER node
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:4000/ap1/v1 || exit 1


CMD [ "node", "src/server.js" ]

