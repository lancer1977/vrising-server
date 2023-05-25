FROM ubuntu

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt install -y wine64 wine32 curl unzip xvfb winetricks tar winbind


RUN mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/'Stunlock Studios'/VRisingServer/Settings \
    && mkdir /steamcmd \
    && cd /steamcmd \
    && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar xz \
    && mkdir -p /root/.wine/drive_c/VRisingServer/ \
    && cd /steamcmd

COPY root .

WORKDIR /scripts

RUN chmod +x ./run.sh
RUN mkdir /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

EXPOSE 27015/udp
EXPOSE 27016/udp
run ln  /root/.wine/drive_c/users/root/AppData/LocalLow/Stunlock Studios/VRisingServer /mnt/
CMD ./run.sh