#!/bin/sh
#Version 0.0.1Alpha


PACKAGES=(

	#Gnome
	'xorg'
	'gnome'
	'gnome-tweaks'
	'gnome-nettool'
	'gnome-usage'
	'gnome-multi-writer'
	'xdg-user-dirs-gtk'
	'chrome-gnome-shell'
	'adwaita-icon-theme'
	'nautilus-sendto'
	'fwupd'
	'arc-gtk-theme'
	'seahosrse'
	'gdm'
	'xscreensaver'
	'archlinux-wallpaper'
	
	#Basese
	'pacman-contrib'
	'git'
	'wget'

	#Service
	'apache'
	'php-apache'
	'mysql'

	#Lenguages
	'vim'
	'vi'
	'gcc'
	'code'
	'php'
	'python-pip'
	'ruby'
	'arduino'
	'arduino-cli'
	'arduino-docs'
	'arduino-avr-core'
	
	#Others in Command Line
	'mlocate'
	'imagemagick'
	'nmap'
	'john'
	'hydra'
	'sqlmap'
	'binwalk'
	'aircrack-ng'
	'nikto'
	'dnsutils'
	'gnu-netcat'

	#Others with GUI
	'glade'
	'firefox'
	'vlc'
	'filezilla'
	'leafpad'
	'wireshark-qt'
	'libreoffice-fresh'
)

for package in "${PACKAGES[@]}"
do
	echo "Installing: ${package}"
	pacman -S "$package" --noconfirm --needed
done

./start-Services.sh
