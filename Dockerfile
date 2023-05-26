FROM ubuntu:18.04
VOLUME ["/mnt/vrising/server", "/mnt/vrising/persistentdata"]
ENV USERNAME=steam
ARG DEBIAN_FRONTEND="noninteractive"
ARG PGID=1000
ARG PUID=1000
EXPOSE 9876/udp
EXPOSE 9877/udp
RUN groupadd --gid $PGID $USERNAME
RUN useradd --create-home --shell /bin/bash --no-user-group --gid $PGID --uid $PUID $USERNAME
RUN dpkg --add-architecture i386 \
    && apt update \
    && apt install -y wine64 wine32 curl unzip xvfb winetricks tar winbind tzdata xserver-xorg
RUN mkdir /tmp/.X11-unix && chmod $PGID /tmp/.X11-unix
RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt purge steam steamcmd && \
    apt install -y gdebi-core  \
                   libgl1-mesa-glx:i386 \
                   wget && \
    apt install -y steam \
                   steamcmd && \
    ln -s /usr/games/steamcmd /usr/bin/steamcmd
COPY --chown=$USERNAME:$USERNAME scripts /home/$USERNAME/scripts

#USER $USERNAME

WORKDIR /home/$USERNAME/scripts
RUN chmod +x run.sh

#RUN winetricks atmlib 
#RUN winetricks corefonts 
#RUN winetricks vcrun2008 
#RUN winetricks vcrun2010 
#RUN winetricks vcrun2012 
#RUN winetricks fontsmooth-rgb 
#RUN winetricks gecko 
#RUN winetricks msxml3 
#RUN winetricks msxml6
#gdiplus
#winetricks atmlib corefonts gdiplus msxml3 msxml6 vcrun2008 vcrun2010 vcrun2012 fontsmooth-rgb gecko
CMD /home/$USERNAME/scripts/run.sh
