# Installs multiple packages on Ubuntu 18.04 (Bionic Beaver)
# Inspired by and loosely based on https://gist.github.com/h4cc/c54d3944cb555f32ffdf25a5fa1f2602
# Feel free to use this if you would like to. 

.PHONY:	all preparations libs update upgrade fonts gnome atom python ruby vagrant graphics obs 3dprint darktable networking harddisk google_chrome archives media pandoc system virtualbox ansible docker filesystem tools teamviewer unetbootin steam libreoffice_full wine unity3d unifi gitkraken googleplaymusic

all:
	@echo "Installation of ALL targets"
	make preparations libs
	make update
	make upgrade
	make gnome
	make python
	make atom
	make graphics darktable 
	make 3dprint
	make obs
	make networking google_chrome
	# make dropbox 
	make harddisk
	make media
	make pandoc
	make archives system filesystem tools
	make ansible virtualbox vagrant
	make docker
	make teamviewer
	make steam
	make libreoffice_full
	make unetbootin
	make wine
	make gitkraken
	make googleplaymusic
	make skype
	make fonts

preparations:
	sudo apt-add-repository universe
	sudo apt-add-repository multiverse
	sudo apt-add-repository restricted
	make update
	sudo apt -y install software-properties-common build-essential checkinstall wget curl git libssl-dev apt-transport-https ca-certificates flatpak gnome-software-plugin-flatpak

libs:
	sudo apt -y install libavahi-compat-libdnssd-dev

update:
	sudo apt clean all
	sudo apt update

upgrade:
	sudo apt -y full-upgrade
	sudo snap refresh
	sudo flatpak update

fonts:
	sudo apt -y install ttf-mscorefonts-installer # Install Microsoft fonts.
	curl https://raw.githubusercontent.com/dylanmtaylor/Web-Font-Load/master/install_generic.sh | bash # Install all the google fonts
	mkdir -p ~/.fonts/
	rm -f ~/.fonts/FiraCode-*
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Bold.otf -O ~/.fonts/FiraCode-Bold.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Light.otf -O ~/.fonts/FiraCode-Light.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Medium.otf -O ~/.fonts/FiraCode-Medium.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Regular.otf -O ~/.fonts/FiraCode-Regular.otf
	wget https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Retina.otf -O ~/.fonts/FiraCode-Retina.otf
	fc-cache -v
	
gnome:
	# Default GDM is pretty ugly. This forces upstream GDM theming.
	sudo apt -y install gnome-session vanilla-gnome-default-settings
	sudo update-alternatives --set gdm3.css /usr/share/gnome-shell/theme/gnome-shell.css

atom:
	curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	make update
	sudo apt -y install gconf-service gconf2 gir1.2-gnomekeyring-1.0
	sudo apt -y install atom
	# sudo flatpak install -y https://flathub.org/repo/appstream/io.atom.Atom.flatpakref
	# rm -f atom-amd64.deb
	# wget https://atom.io/download/deb -O atom-amd64.deb
	# sudo dpkg -i atom-amd64.deb

python:
	make preparations
	sudo -H apt -y install python-pip python-minimal
	sudo -H pip install --upgrade pip

ruby:
	sudo apt -y install ruby ruby-dev ruby-bundler jekyll
	sudo gem install bundler
	
vagrant:
	sudo apt -y install vagrant
	
graphics:
	sudo apt -y install gimp gimp-data gimp-plugin-registry gimp-data-extras inkscape krita graphviz libav-tools jpegoptim mesa-utils shutter

obs:
	sudo apt -y install obs-studio

3dprint:
	sudo apt -y install slic3r cura freecad libcanberra-gtk-module #libcanberra-gtk-module:i386

darktable:
	sudo apt -y install darktable

networking:
	sudo apt -y install pidgin filezilla vinagre remmina pepperflashplugin-nonfree hexchat wireshark-gtk zenmap samba

harddisk:
	sudo apt -y install smartmontools nvme-cli smart-notifier #gsmartcontrol

google_chrome:
	# rm -f google-chrome-stable_current_amd64.deb
	# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
	make update
	sudo apt -y install google-chrome-stable libappindicator1 libindicator7
	# sudo dpkg -i google-chrome-stable_current_amd64.deb
	# rm -f google-chrome-stable_current_amd64.deb
	
dropbox:
	sudo apt -y install nautilus-dropbox
	
archives:
	sudo apt -y install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

media:
	sudo apt -y install mplayer mplayer-gui vlc ubuntu-restricted-extras libavcodec-extra libdvdread4 blender totem okular okular-extra-backends audacity brasero handbrake
	sudo apt -y install libxvidcore4 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-alsa gstreamer1.0-fluendo-mp3 gstreamer1.0-libav
	# DVD Playback
	sudo apt -y install libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
	# Fix mplayer bug - "Error in skin config file on line 6: PNG read error in /usr/share/mplayer/skins/default/main"
	cd /usr/share/mplayer/skins/default; for FILE in *.png ; do sudo convert $$FILE -define png:format=png24 $$FILE ; done

pandoc:
	sudo apt install pandoc pandoc-citeproc dvipng perl-tk fonts-lmodern fonts-texgyre lmodern tex-gyre
	# sudo apt -y install texlive texlive-latex-extra texlive-latex-base texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra texlive-lang-german texlive-xetex preview-latex-style nbibtex

system:
	sudo apt -y install icedtea-8-plugin openjdk-8-jre subversion rabbitvcs-nautilus git git-gui curl vim network-manager-openvpn gparted gnome-disk-utility usb-creator-gtk traceroute cloc whois mssh inotify-tools openssh-server sqlite3 etckeeper stress gksu ntp heaptrack heaptrack-gui neovim

virtualbox: 
	sudo apt -y install virtualbox-modules virtualbox-guest-utils virtualbox-guest-additions-iso virtualbox virtualbox-guest-dkms

ansible:
	sudo apt -y install ansible

docker:
	sudo snap install docker

filesystem:
	sudo apt -y install cryptsetup libblockdev-crypto2 exfat-fuse exfat-utils e2fsprogs mtools dosfstools hfsutils hfsprogs jfsutils util-linux lvm2 nilfs-tools ntfs-3g reiser4progs reiserfsprogs xfsprogs attr quota f2fs-tools sshfs go-mtpfs jmtpfs

tools:
	sudo apt -y install htop meld guake keepassx retext vim geany glade ghex myrepos baobab byobu gnome-tweaks pv fortune cowsay lolcat screenfetch

teamviewer:
	sudo apt -y install qml-module-qtquick-dialogs qml-module-qtquick-privatewidgets
	rm -f teamviewer_amd64.deb
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
	sudo dpkg -i teamviewer_amd64.deb
	rm -f teamviewer_amd64.deb

unetbootin:
	# workaround
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D45DF2E8FC91AE7E
	echo "deb http://ppa.launchpad.net/gezakovacs/ppa/ubuntu artful main" | sudo tee /etc/apt/sources.list.d/gezakovacs-ubuntu-ppa-bionic.list
	sudo apt-get update
	sudo apt-get -y install unetbootin

steam:
	sudo apt -y install python-apt
	wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
	sudo dpkg -i steam.deb

libreoffice_full:
	sudo apt -y install libreoffice
	
wine:
	sudo apt -y install --install-recommends wine-dev mono-complete dosbox
 
unity3d:
	rm -f UnitySetup-2018.1.0b8
	wget https://beta.unity3d.com/download/ee2fb9f9da52/UnitySetup-2018.1.0b8
	chmod +x UnitySetup-2018.1.0b8
	sudo ./UnitySetup-2018.1.0b8 --unattended -l $$HOME/Unity3D
	sudo chown -R $$USER:$$USER $$HOME/Unity3D
	
unifi:
	echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
	sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
	sudo apt-get update --allow-releaseinfo-change
	sudo apt -y install unifi
	
gitkraken:
	sudo snap install gitkraken

googleplaymusic:
	sudo flatpak install -y https://flathub.org/repo/appstream/com.googleplaymusicdesktopplayer.GPMDP.flatpakref
	
skype:
	sudo flatpak install -y https://flathub.org/repo/appstream/com.skype.Client.flatpakref
