FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN corepack enable && \
  corepack prepare pnpm@latest --activate

ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN pnpm config set global-bin-dir /usr/local/bin && \
  pnpm add -g @evilmartians/lefthook

RUN node --version && \
  pnpm --version && \
  git --version && \
  lefthook version

EXPOSE 3000

