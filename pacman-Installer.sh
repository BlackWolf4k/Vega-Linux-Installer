#!/bin/sh
#Change over
#Utils installer

PACKAGES={
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
	'code'
	'php'
	'python-pip'
	'ruby'
	'arduino'
	'arduino-cli'
	'arduino-docs'
	'arduino-avr-core'

	
	#Other in Command Line
	'mlocate'
	'imagemagick'
	'nmap'
	'john'
	'hydra'
	'sqlmap'
	'binwalk'
	'aircrack-ng'
	'nikto'

	#Other with GUI
	'firefox'
	'vlc'
	'filezilla'
	'leafpad'
	'wireshark-qt'
	'libreoffice-fresh'
}

for package in "${PACKAGES}"
do
	echo "Installing: ${package}"
	sudo pacman -S "$package" --noconfirm --needed
done

echo -e "\nFine\n"