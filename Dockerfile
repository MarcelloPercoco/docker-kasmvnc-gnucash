FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

# set version label
LABEL maintainer="Cobra1978"

# copy nginx configuration
RUN cp /defaults/default.conf /etc/nginx/conf.d/

# add local files
COPY /root/defaults /

RUN \
  echo "**** install packages ****" && \
  pacman -Syu --noconfirm && \
  pacman -Sy gnucash mariadb-libs libdbi-drivers postgresql-libs --noconfirm && \
  echo "**** cleanup ****" && \
  pacman -Scc --noconfirm

# ports and volumes
EXPOSE 3000

VOLUME /config

HEALTHCHECK CMD curl --fail 'http://localhost:3000' || echo exit 1
