#!/bin/sh
echo "Setting timezone to $TZ"
echo $TZ > /etc/timezone 2>&1
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 2>&1
dpkg-reconfigure -f noninteractive tzdata 2>&1
if [ ! -z $UID ]; then
	usermod -u $UID docker 2>&1
fi 
if [ ! -z $GID ]; then
	groupmod -g $GID docker 2>&1
fi
if [ -z $SERVERNAME ]; then
	SERVERNAME="poly-V"
fi
if [ -z $WORLDNAME ]; then
	WORLDNAME="world1"
fi
game_port=""
if [ ! -z $GAMEPORT ]; then
	game_port=" -gamePort $GAMEPORT"
fi
query_port=""
if [ ! -z $QUERYPORT ]; then
	query_port=" -queryPort $QUERYPORT"
fi

cd /steamcmd

#1604030 - steam
#1829350 - ikd
./steamcmd.sh +force_install_dir "/root/.wine/drive_c/VRisingServer/" +login anonymous +app_update 1829350 validate +quit

rm -r /tmp/.X1-lock

cd /root/.wine/drive_c/VRisingServer/
Xvfb :1 -screen 0 1024x768x16 &
#export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:1
#wine VRisingServer.exe
wine64 /root/.wine/drive_c/VRisingServer/VRisingServer.exe -persistentDataPath $p -serverName "$SERVERNAME" -saveName "$WORLDNAME" -logFile "$p/VRisingServer.log" "$game_port" "$query_port" 2>&1
/usr/bin/tail -f /mnt/vrising/persistentdata/VRisingServer.log