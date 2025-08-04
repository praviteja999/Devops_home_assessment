# Stage 1: Build using full Node (better compatibility)
FROM node:20 as builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# Optional: If you have TypeScript or need a build step
# RUN npm run build

# Stage 2: Runtime using lightweight Node Alpine
FROM node:20-alpine

WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app .

EXPOSE 3000

CMD ["node", "index.js"]
# Or: CMD ["npm", "start"] if you have a start script in package.json
