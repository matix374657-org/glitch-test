# # Use an Alpine image as the base
# FROM alpine:3.20

# # Install Node.js, npm, and Nginx
# RUN apk update && apk add --no-cache nodejs npm openssh sslh

# COPY ./secret/sftp-client/id_rsa.pub /tmp/ssh/id_rsa.pub

# # Create the SSH directory and configure it
# RUN mkdir /var/run/sshd \
#     && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
#     && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
#     && mkdir -p /root/.ssh \
#     && ssh-keygen -A \
#     && chmod 700 /root/.ssh \
#     && touch /root/.ssh/authorized_keys \
#     && cat /tmp/ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
#     && chmod 600 /root/.ssh/authorized_keys \
#     && chown -R root:root /root/.ssh

# COPY ./sslh/sslh.cfg /etc/sslh.cfg

# # Set the working directory inside the container
# WORKDIR /app

# # Copy application code to the working directory
# COPY ./server . 

# # Install dependencies
# RUN npm install --production

# # Expose ports for Nginx (default: 80)
# EXPOSE 80

# # Start Nginx and the Node.js application
# CMD ["sh", "-c", "/usr/sbin/sshd && npm start"]

# RUN rm -rf /tmp/*


# Start with a lightweight base image
FROM alpine:3.20

# Install dependencies
RUN apk add --no-cache \
    docker \
    docker-compose \
    bash \
    curl \
    jq \
    git

# Add a non-root user (optional)
RUN addgroup -S docker && adduser -S docker -G docker
USER docker

# Set the working directory
WORKDIR /app

# Set an entry point (optional, to directly run Docker Compose commands)
ENTRYPOINT ["docker-compose", "up"]