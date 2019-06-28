#/bin/sh

wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt-mark hold libcurl4
sudo dpkg -i --ignore-depends=libcurl3 viber.deb
sudo apt install -f -y
sudo dpkg -i --ignore-depends=libcurl3 viber.deb
sudo apt-mark unhold libcurl4

