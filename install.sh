#!/bin/bash
loadkeys de-latin1
wifi=no
read -p "Do you want to use wifi? Type yes or no " wifi
#echo $wifi
if [ "$wifi" == "yes" ]
	then 
	       echo "Not implemented yet. Skipping..."
fi
timedatectl set-ntp true
fdisk -l
disk=none
read -p "Create one boot partition with type Linux. Type full disk path." disk 
fdisk $disk
mkfs.ext4 ${disk}1
mount ${disk}1 /mnt
pacstrap /mnt base linux linux-firmware grub vim iwd dhcpcd sudo amd-ucode intel-ucode xorg mesa xf86-video-intel lxde base-devel git python
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
echo en_US.UTF-8 >> /etc/locale.gen
echo de_DE.UTF-8 >> /etc/locale.gen
locale-gen
echo de_DE.UTF-8 >> /etc/locale.conf
echo KEYMAP=de-latin1 >> /etc/vconsole.conf
echo AncoraLinux >> /etc/hostname
passwd
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo "Now reboot"
exit
