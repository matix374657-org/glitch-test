# Use an Alpine image as the base
FROM alpine:3.18

# Install Node.js, npm, and Nginx
RUN apk add --no-cache nodejs npm nginx

# Set the working directory inside the container
WORKDIR /app

# Copy application code to the working directory
COPY ./server . 

# Install dependencies
RUN npm install --production

RUN rm -rf /etc/nginx/http.d/*

# Copy additional Nginx configuration
COPY ./nginx-proxy/config/nginx-http-proxy.conf /etc/nginx/http.d/nginx-proxy.conf

# Expose ports for Nginx (default: 80)
EXPOSE 80

# Start Nginx and the Node.js application
CMD ["sh", "-c", "npm start"]