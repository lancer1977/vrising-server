#!/bin/sh
echo "Setting timezone to ${TZ:-UTC}"
echo "${TZ:-UTC}" > /etc/timezone 2>&1
ln -snf "/usr/share/zoneinfo/${TZ:-UTC}" /etc/localtime 2>&1
dpkg-reconfigure -f noninteractive tzdata 2>&1

server=/home/steam/persistentdata
settings=/home/steam/settings

if [ -n "${PUID:-}" ]; then
	usermod -u "$PUID" steam 2>&1
fi
if [ -n "${PGID:-}" ]; then
	groupmod -g "$PGID" steam 2>&1
fi
if [ -z "${SERVERNAME:-}" ]; then
	SERVERNAME="poly-V"
fi
if [ -z "${WORLDNAME:-}" ]; then
	WORLDNAME="world1"
fi

cd "$server"
if [ ! -e "./steaminstalled.txt" ]; then
    steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir "$server" +login anonymous +app_update 1829350 validate +quit
    touch ./steaminstalled.txt
fi

rm -f /tmp/.X0-lock

#cd ~/.wine/drive_c/VRisingServer/
#Xvfb :1 -screen 0 800x600x24 &
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:0

Xvfb :0 -screen 0 800x600x24 &
set -- "$settings" -serverName "$SERVERNAME" -saveName "$WORLDNAME" -logFile "$settings/VRisingServer.log"
if [ -n "${GAMEPORT:-}" ]; then
	set -- "$@" -gamePort "$GAMEPORT"
fi
if [ -n "${QUERYPORT:-}" ]; then
	set -- "$@" -queryPort "$QUERYPORT"
fi

wine "$server/VRisingServer.exe" "$@" 2>&1
