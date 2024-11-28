# Use an Alpine image as the base
FROM alpine:3.20

# Install Node.js, npm, and Nginx
RUN apk update && apk add --no-cache nodejs npm openssh sslh dos2unix zip

# Create the SSH directory and configure it
RUN mkdir /var/run/sshd \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && touch /root/.ssh/authorized_keys \
    && chmod 600 /root/.ssh/authorized_keys \
    && chown -R root:root /root/.ssh

COPY ./sslh/sslh.conf /etc/sslh.conf

WORKDIR /scripts

COPY ./scripts .

RUN chmod +x /scripts/entrypoint.sh && dos2unix /scripts/entrypoint.sh

RUN find ./ -type f -name "*.sh" -exec chmod +x {} \; -exec dos2unix {} \;

# Set the working directory inside the container
WORKDIR /app

# Copy application code to the working directory
COPY ./server . 

# Install dependencies
RUN npm install --production

EXPOSE 4000

ENTRYPOINT ["/scripts/entrypoint.sh"]

RUN rm -rf /tmp/*