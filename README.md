# Dylan's Ubuntu 18.04 LTS Makefile
A makefile I use to install many of the applications I use on Ubuntu 18.04. This is mostly used for rapidly reinstalling daily builds and setting up new systems. It allows me to keep my experience consistent, and it contains setup commands for repositories, snaps and flatpaks for applications, allowing me to get the latest version, even if it is not shipped by Ubuntu.

### Usage

While this is created to meet my own needs, it may prove useful to others, so I am sharing it publicly. Use at your own risk, and feel free to take it and modify it. To run this, copy and paste the following into a terminal:

``` bash
sudo apt -y install git make ; git clone https://github.com/dylanmtaylor/dylan-ubuntu-makefile.git ; cd dylan-ubuntu-makefile ; make
```

Some targets are meant to be executed separately, including:

* unity3d: Installs http://unity3d.com
* fonts: Sets up various font packages and thousands of Google Web Fonts.
* dropbox: Adds Nautilus dropbox integration
* driverppa: Enables upstream unsupported proprietary graphics drivers newer than those shipped in Ubuntu

It is a known issue that vanilla-gnome-default-settings installation closes make. Either install this first, or just re-run the make command.
