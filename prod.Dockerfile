FROM node:lts-slim as base
RUN apt-get update -y && apt-get install -y git openssl

FROM base as clone
ARG GIT_TOKEN
ARG GIT_USER
ARG REPO
ENV BRANCH=main
RUN git clone https://${GIT_USER}:${GIT_TOKEN}@github.com/${GIT_USER}/${REPO}.git ./app  --branch=${BRANCH} --single-branch --depth 1

FROM base as deps
WORKDIR /app
COPY --from=clone /app/package.json /app/package-lock.json  ./
RUN npm ci

FROM base as build
WORKDIR /app
COPY --from=clone ./app . 
COPY --from=deps /app/node_modules ./node_modules
ENV NEXT_TELEMETRY_DISABLED=1
COPY .env .env.production
RUN  npm run build

FROM base as run
WORKDIR  /app
ENV NEXT_TELEMETRY_DISABLED=1
COPY --from=build /app/public ./public
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
ENTRYPOINT ["node", "server.js"]
