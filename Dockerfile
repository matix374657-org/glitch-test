# Use the official Node.js LTS image as a base
FROM node:18-slim

# Set the working directory inside the container
WORKDIR /app

# Copy application code to the working directory
COPY ./server .

# Install dependencies
RUN npm install --production

# Expose the port your app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]