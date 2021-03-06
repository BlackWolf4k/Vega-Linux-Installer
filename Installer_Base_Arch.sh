#!/bin/sh
#Arch-Linux base system installer
#Version: 0.0.1Alpha

RRD="\e[31m"
RED="\e[91m"
CYN="\e[94m"
YLL="\e[93m"
CLS="\e[m"

echo -e "${RED}This is a base installer not %100 secure... do not run it in your main pc\nTHIS WORK ONLY IN ${CLS}'${YLL}EFI${CLS}'\n\n"
echo "Plase insert keyboard type ( en - de - it... )"
read keyboard
loadkeys "$keyboard"
  
echo -e "${CYN}Please enter${CLS} ${YLL}hostname${CLS}:"
read hostname
echo -e "${CYN}Plase eneter${CLS} ${YLL}root password${CLS}:"
read root_password
echo -e "${CYN}Please enter${CLS} ${YLL}username${CLS}: ( all must be lower ):" 
read username
echo -e "${CYN}Please enter${CLS} ${YLL}$username password${CLS}:"
read user_password
echo -e "$user_password"
echo -e "Plase insert ${YLL}Regione and City${CLS} in the following way: America/Chicago | Europe/Rome )"
read TimeZone
echo -e "${YLL}Plase chooese the disk:${CLS}"
fdisk -l 
echo -e "${RRD}BE CAREFULL, YOU ARE GOING TO FORMATE THE SELECTED DISK ( /dev/sda if only 1 disk EMPTY )${CLS}"
read disk
fdisk "$disk"

timedatectl set-ntp true
timedatectl status

echo -e "${RRD}PLASE PRESS CTRL+C THEN ENTER${CLS}"
fdisk ${disk} <<EEOF
g
n
1

+550M
n
2

+4G
n
3


t
1
1
t
2
19
w
EEOF

mkfs.fat -F32 ${disk}1
mkswap ${disk}2
swapon ${disk}2
mkfs.ext4 ${disk}3
mount ${disk}3 /mnt
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt <<EEOF
ln -sf /usr/share/zoneinfo/${TimeZone} /etc/localtime
hwclock --systohc
pacman -S nano --noconfirm
sed -i 's/#it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
touch /etc/hostname
echo -e "$hostname" > /etc/hostname
echo -e "\n127.0.0.1    localhost\n::1      localhost\n127.0.1.1    $hostname.localdomain   $hostname" >> /etc/hosts
echo -e "${root_password}\n${root_password}" | passwd
useradd -m "$username"
echo -e "${user_password}\n${user_password}" | passwd "${username}"
usermod -aG wheel,audio,video,optical,storage "${username}"
pacman -S sudo --noconfirm
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
pacman -S grub --noconfirm
pacman -S  efibootmgr dosfstools os-prober mtools --noconfirm
mkdir /boot/EFI
mount "${disk}1" /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub-uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S networkmanager --noconfirm
systemctl enable NetworkManager
exit
EEOF
umount -l /mnt
echo -e "${RDD}Be sure to remove Installation Driver before reboot ( 5 seconds )${CLS}"
sleep 5
reboot
