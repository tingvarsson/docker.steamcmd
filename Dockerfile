# SteamCMD

FROM debian:buster-slim
LABEL maintainer Thomas Ingvarsson <ingvarsson.thomas@gmail.com>

ARG PUID=1000
ENV USER steam
ENV HOME /home/$USER
ENV STEAMCMD_DIR /home/$USER/steamcmd

RUN apt-get update \
    && apt-get install -y \
    curl \
    lib32gcc1 \
    lib32stdc++6 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -u $PUID -m $USER

USER $USER

RUN mkdir -p $STEAMCMD_DIR \
    && curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz -C $STEAMCMD_DIR

WORKDIR $STEAMCMD_DIR
CMD ["steamcmd.sh"]