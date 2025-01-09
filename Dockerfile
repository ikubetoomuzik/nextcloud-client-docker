# Set base image
FROM alpine:latest

# Set container label
LABEL org.opencontainers.image.title="Nextcloud-Client Docker Image" \
      org.opencontainers.image.description="Docker image for Nextcloud Sync" \
      org.opencontainers.image.documentation="https://github.com/dontobi/nextcloud-client.rpi#readme" \
      org.opencontainers.image.authors="Tobias Schug <github@myhome.zone>" \
      org.opencontainers.image.url="https://github.com/dontobi/nextcloud-client.rpi" \
      org.opencontainers.image.source="https://github.com/dontobi/nextcloud-client.rpi" \
      org.opencontainers.image.base.name="docker.io/library/alpine:latest" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${DATI}"

# Set Volumes

# Set Arguments
ARG USER=ncsync
ARG USER_UID=99
ARG USER_GID=100

# Set Variables
ENV USER=$USER \
    USER_UID=$USER_UID \
    USER_GID=$USER_GID \
    NC_USER="" \
    NC_PASS="" \
    NC_INTERVAL=300 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SOURCE_DIR="/media/nextcloud/" \
    NC_PATH="" \
    NC_SILENT=false \
    NC_EXIT=false \
    NC_HIDDEN=false

# Building
# create group and user
RUN addgroup -g $USER_GID $USER && adduser -G $USER -D -u $USER_UID $USER
# update repositories and install nextcloud-client
RUN apk -U --no-cache add nextcloud-client moreutils && rm -rf /etc/apk/cache
# add run script
ADD run.sh /usr/bin/run.sh

# Entrypoint
CMD /usr/bin/run.sh
