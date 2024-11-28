# Start with a lightweight base image
FROM docker:dind

# RUN rc-update add docker default

# Set the working directory
WORKDIR /app

COPY ./src . 

# Set an entry point (optional, to directly run Docker Compose commands)
ENTRYPOINT ["dockerd-entrypoint.sh"]