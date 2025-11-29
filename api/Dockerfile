FROM node:24.11.1-slim AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app

COPY package.json yarn.lock*
RUN yarn --frozen-lockfile


# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN yarn run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json
RUN yarn --frozen-lockfile --production

EXPOSE 3000

ENV PORT=3000

# index.js is created by next build from the standalone output
CMD ["node", "dist/index.js"]