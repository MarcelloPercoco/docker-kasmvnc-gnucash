FROM ghcr.io/linuxserver/baseimage-rdesktop-web:arch

# set version label
LABEL maintainer="Cobra1978"

RUN \
  echo "**** install packages ****" && \
  pacman -Syu --noconfirm && \
  pacman -S gnucash mariadb-libs libdbi-drivers postgresql-libs --noconfirm && \
  echo "**** cleanup ****" && \
  pacman -Scc --noconfirm

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config

HEALTHCHECK CMD curl --fail 'http://localhost:3000' || echo exit 1
