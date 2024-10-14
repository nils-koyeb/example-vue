FROM node:slim as build

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY . /app

RUN pnpm install
RUN pnpm build

FROM nginx

COPY --from=build /app/dist /usr/share/nginx/html
