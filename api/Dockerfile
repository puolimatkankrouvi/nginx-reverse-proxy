FROM node:24.11.1-slim AS base
WORKDIR /app

FROM base AS deps

# Copy only the files Yarn needs
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn

RUN yarn install --immutable

FROM base AS builder

COPY --from=deps /app /app
COPY . .

RUN yarn build

FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json
COPY --from=deps /app/.yarn ./.yarn
COPY --from=deps /app/.yarnrc.yml ./.yarnrc.yml
COPY --from=deps /app/yarn.lock ./yarn.lock

RUN yarn workspaces focus --all --production

EXPOSE 3000

CMD ["node", "dist/index.js"]
