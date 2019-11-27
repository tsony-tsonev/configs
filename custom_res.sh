#/bin/sh

if [  $# -le 2 ] 
then 
	echo "usage:\n./${0##*/} WIDTH HEGHT REFRESH_RATE\n\nIf want to just add the resolution without appling it - provide the -na flag to the end\nexample:\n./${0##*/} 1920 1080 60 -na"
	exit 1
fi

WIDTH=$1
HEIGHT=$2
REFRESH_RATE=$3

set -e
MODELINE=$(gtf $WIDTH $HEIGHT $REFRESH_RATE | grep Modeline | cut -c 12-)
ACTIVE_DISPLAY=$(xrandr -q | grep connected | sed -n -e 's/ connected primary.*$//p')

set -x
sudo xrandr --newmode $MODELINE
sudo xrandr --addmode $ACTIVE_DISPLAY "${WIDTH}x${HEIGHT}_${REFRESH_RATE}.00"

if [ "$4" = "-na" ]
then
    exit 0
fi

xrandr --output $ACTIVE_DISPLAY --mode "${WIDTH}x${HEIGHT}_${REFRESH_RATE}.00"
