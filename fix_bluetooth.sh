#bin/sh

sudo apt-get -y install pulseaudio pulseaudio-utils pavucontrol pulseaudio-module-bluetooth

sudo touch /etc/bluetooth/audio.conf 
echo "# This section contains general options" | sudo tee --append /etc/bluetooth/audio.conf
echo "    [General]" | sudo tee --append /etc/bluetooth/audio.conf
echo "    Enable=Source,Sink,Media,Socket" | sudo tee --append /etc/bluetooth/audio.conf

sudo service bluetooth restart

