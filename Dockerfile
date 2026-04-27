# Use Node.js runtime from Amazon's public ECR (no Docker Hub rate limit)
FROM public.ecr.aws/docker/library/node:20-alpine

# ECS container health checks commonly use curl in CMD-SHELL checks.
RUN apk add --no-cache curl

# Set working directory
WORKDIR /usr/src/app

# Copy package manifests and install dependencies first for better caching
COPY package*.json ./
RUN npm install --production --quiet

# Copy app source
COPY . .

# Expose port 80 for ALB load balancer
EXPOSE 80

# Start the app
CMD ["npm", "start"]
