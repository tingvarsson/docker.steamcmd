# SteamCMD
#
# Version 1.0.0

FROM ubuntu:latest
LABEL maintainer Thomas Ingvarsson <ingvarsson.thomas@gmail.com>

RUN apt-get -y update && \
    apt-get -y install curl lib32gcc1 lib32stdc++6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV USER steam
ENV HOME /home/$USER
env STEAMCMD_DIR $HOME/steamcmd

RUN useradd $USER && \
    mkdir -p $STEAMCMD_DIR && \
    chown -R $USER:$USER $HOME

RUN cd $STEAMCMD_DIR && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

USER $USER
WORKDIR $STEAMCMD_DIR

CMD ["./steamcmd.sh"]