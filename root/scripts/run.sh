#!/bin/sh
cd /steamcmd
if [ ! -e "./steaminstalled.txt" ]; then
    ./steamcmd.sh +force_install_dir "/root/.wine/drive_c/VRisingServer/" +login anonymous +app_update 1829350 validate +quit
    touch ./steaminstalled.txt
fi

rm -r /tmp/.X0-lock

cd /root/.wine/drive_c/VRisingServer/
Xvfb :1 -screen 0 800x600x24 &
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:1
wine VRisingServer.exe