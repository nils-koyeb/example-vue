FROM node:slim as build

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY . /app

ARG VITE_MY_VARIABLE
ENV VITE_MY_VARIABLE $VITE_MY_VARIABLE

RUN pnpm install
RUN pnpm build

FROM nginx

COPY --from=build /app/dist /usr/share/nginx/html
