# Use an Alpine image as the base
FROM nginx:mainline-alpine3.20

# Install Node.js, npm, and Nginx
RUN apk add --no-cache nodejs npm openssh

COPY ./secret/sftp-client/id_rsa.pub /secret/ssh/id_rsa.pub

# Create the SSH directory and configure it
RUN mkdir /var/run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
    && mkdir -p /root/.ssh \
    && ssh-keygen -A \
    && chmod 700 /root/.ssh \
    && touch /root/.ssh/authorized_keys \
    && cat /secret/ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 600 /root/.ssh/authorized_keys \
    && chown -R root:root /root/.ssh

# Set the working directory inside the container
WORKDIR /app

# Copy application code to the working directory
COPY ./server . 

# Install dependencies
RUN npm install --production

RUN rm -rf /etc/nginx/http.d/* && rm -rf /etc/nginx/conf.d/*

# Copy additional Nginx configuration
COPY ./nginx-proxy/config/nginx-http-proxy.conf /etc/nginx/http.d/nginx-http-proxy.conf

COPY ./nginx-proxy/config/nginx-proxy.conf /etc/nginx/conf.d/nginx-proxy.conf

COPY ./nginx-proxy/config/main-nginx.conf /etc/nginx/nginx.conf

# Expose ports for Nginx (default: 80)
EXPOSE 80

# Start Nginx and the Node.js application
CMD ["sh", "-c", "/usr/sbin/sshd && npm start"]