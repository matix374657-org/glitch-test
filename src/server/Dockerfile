# Use an Alpine image as the base
FROM alpine:3.20

# Install Node.js, npm, and Nginx
RUN apk update && apk add --no-cache nodejs npm

# Set the working directory inside the container
WORKDIR /app

# Copy application code to the working directory
COPY ./server . 

# Install dependencies
RUN npm install --production

# Expose ports for Nginx (default: 80)
EXPOSE 80

# Start Nginx and the Node.js application
CMD ["sh", "-c", "npm start"]