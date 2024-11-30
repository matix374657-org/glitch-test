FROM node:22-alpine

# Update and install git
RUN apk update && apk add --no-cache git

# Install pnpm globally using npm
RUN npm install -g pnpm

WORKDIR /tmp

RUN git clone https://github.com/suhasdeshpande/server.git ./

WORKDIR /app

RUN cp /tmp/package.json ./package.json
RUN cp /tmp/pnpm-lock.yaml /app/pnpm-lock.yaml

RUN pnpm install --prod && \
    pnpm store prune

RUN cp -r /tmp/* ./

RUN rm -rf /tmp/*

RUN apk del git

EXPOSE 5000

ENV NODE_ENV=production
ENTRYPOINT ["node", "./bin/server", "--port", "5000", "--domain", "matix374657-test-matrix-space.hf.space"]