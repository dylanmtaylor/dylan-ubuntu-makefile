# Installs multiple packages on Ubuntu 18.04 (Bionic Beaver)
# Inspired by and loosely based on https://gist.github.com/h4cc/c54d3944cb555f32ffdf25a5fa1f2602
# Feel free to use this if you would like to. 

.PHONY:	all preparations libs update upgrade fonts atom python ruby virtualbox vagrant graphics darktable networking google_chrome dropbox slack archives media pandoc system docker ansible filesystem  tools nautilus httpie esl_repo erlang elixir couchdb teamviewer xmind presentation steam libreoffice_full

all:
	@echo "Installation of ALL targets"
	make preparations libs
	make update
	make upgrade
	make fonts
	make atom
	make graphics darktable 
	make 3dprint
	make networking google_chrome dropbox httpie
	make media pandoc
	make presentation
	make archives system filesystem tools nautilus
	make docker ansible virtualbox vagrant
	make teamviewer
	make xmind
	make steam
	make libreoffice_full
	make unetbootin

preparations:
	make update
	sudo apt -y install software-properties-common build-essential checkinstall wget curl git libssl-dev apt-transport-https ca-certificates

libs:
	sudo apt -y install libavahi-compat-libdnssd-dev

update:
	sudo apt clean all
	sudo apt update

upgrade:
	sudo apt -y full-upgrade

fonts:
	mkdir -p ~/.fonts/
	rm -f ~/.fonts/FiraCode-*
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Bold.otf -O ~/.fonts/FiraCode-Bold.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Light.otf -O ~/.fonts/FiraCode-Light.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Medium.otf -O ~/.fonts/FiraCode-Medium.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Regular.otf -O ~/.fonts/FiraCode-Regular.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Retina.otf -O ~/.fonts/FiraCode-Retina.otf
	fc-cache -v

atom:
	sudo apt -y install gconf-service gconf2
	rm -f atom-amd64.deb
	wget https://atom.io/download/deb -O atom-amd64.deb
	sudo dpkg -i atom-amd64.deb

python:
	make preparations
	sudo -H apt -y install python-pip
	sudo -H pip install --upgrade pip

ruby:
	sudo apt -y install ruby ruby-dev ruby-bundler
	sudo gem install bundler

graphics:
	sudo apt -y install gimp gimp-data gimp-plugin-registry gimp-data-extras krita geeqie graphviz libav-tools jpegoptim mesa-utils shutter

3dprint:
	sudo apt -y install slic3r cura freecad

darktable:
	sudo apt -y install darktable

networking:
	sudo apt -y install pidgin filezilla vinagre remmina chromium-browser pepperflashplugin-nonfree hexchat

google_chrome:
	rm -f google-chrome-stable_current_amd64.deb
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt -y install libappindicator1 libindicator7
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
	
archives:
	sudo apt -y install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

media:
	sudo apt -y install mplayer mplayer-gui vlc ubuntu-restricted-extras libavcodec-extra libdvdread4 blender totem okular okular-extra-backends audacity
	sudo apt -y install libxvidcore4 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-alsa gstreamer1.0-fluendo-mp3 gstreamer1.0-libav
	# DVD Playback
	sudo apt -y install libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg

pandoc:
	sudo apt -y install pandoc pandoc-citeproc texlive texlive-latex-extra texlive-latex-base texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra texlive-lang-german texlive-xetex preview-latex-style dvipng nbibtex perl-tk

system:
	sudo apt -y install icedtea-8-plugin openjdk-8-jre subversion rabbitvcs-nautilus git curl vim network-manager-openvpn gparted gnome-disk-utility usb-creator-gtk traceroute cloc whois mssh inotify-tools openssh-server sqlite3 etckeeper stress gksu ntp heaptrack heaptrack-gui neovim-qt

virtualbox: 
	sudo apt -y install VirtualBox\*

ansible:
	sudo apt -y install ansible
	
filesystem:
	sudo apt -y install cryptsetup exfat-fuse exfat-utils e2fsprogs mtools dosfstools hfsutils hfsprogs jfsutils util-linux lvm2 nilfs-tools ntfs-3g reiser4progs reiserfsprogs xfsprogs attr quota f2fs-tools sshfs go-mtpfs jmtpfs

tools:
	sudo apt -y install htop meld guake keepassx retext vim geany ghex myrepos baobab byobu gnome-tweaks

teamviewer:
	rm -f teamviewer_amd64.deb
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
	sudo dpkg -i teamviewer_amd64.deb
	rm -f teamviewer_amd64.deb

unetbootin:
# workaround
#	sudo add-apt-repository ppa:gezakovacs/ppa
	echo "deb http://ppa.launchpad.net/gezakovacs/ppa/ubuntu artful main" | sudo tee /etc/apt/sources.list.d/gezakovacs-ubuntu-ppa-bionic.list
	sudo apt-get update
	sudo apt-get -y install unetbootin

steam:
	sudo apt -y install python-apt
	wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
	sudo dpkg -i steam.deb

libreoffice_full:
	sudo apt -y install libreoffice
	
