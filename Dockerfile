FROM node:20-alpine

WORKDIR /usr/src/app

# Copy package files first (cache-friendly)
COPY package*.json ./

# Install production deps only (modern npm flag)
RUN npm ci --omit=dev

# Copy app source
COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]