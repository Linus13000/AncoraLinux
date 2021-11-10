#!/bin/bash
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

