# Use an Alpine image as the base
FROM alpine:3.20

ARG PUBLIC_TOKEN_SSH
ARG SERVER_SSH_SECRETS

# Install Node.js, npm, and Nginx
RUN apk update && apk add --no-cache nodejs npm openssh sslh dos2unix zip

COPY ./sslh/sslh.conf /etc/sslh.conf

WORKDIR /scripts

COPY ./scripts .

RUN chmod +x /scripts/entrypoint.sh && dos2unix /scripts/entrypoint.sh

RUN find ./ -type f -name "*.sh" -exec chmod +x {} \; -exec dos2unix {} \;

# Set up a new user named "user" with user ID 1000
RUN adduser -D -u 1000 user

# Switch to the "user" user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME

# RUN --mount=type=secret,id=PUBLIC_TOKEN_SSH,mode=0444,required=true \
#     cat /run/secrets/PUBLIC_TOKEN_SSH | base64 -d >> /root/.ssh/authorized_keys

# RUN --mount=type=secret,id=SERVER_SSH_SECRETS,mode=0444,required=true \
#     cat /run/secrets/SERVER_SSH_SECRETS | base64 -d | ./extract-zip.sh /etc/ssh

RUN mkdir -p ./.ssh ./custom_ssh
RUN echo $PUBLIC_TOKEN_SSH | base64 -d >> ./.ssh/authorized_keys
RUN echo $SERVER_SSH_SECRETS | base64 -d | /scripts/extract-zip.sh ./custom_ssh

WORKDIR $HOME/app

# Copy application code to the working directory
COPY ./server . 

# Install dependencies
RUN npm install --production

EXPOSE 4000

ENTRYPOINT ["/scripts/entrypoint.sh"]

RUN rm -rf /tmp/*