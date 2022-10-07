#!/bin/bash

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable fstrim.timer
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service
systemctl enable ssh
systemctl enable ufw
systemctl enable acpid
systemctl mask systemd-rfkill.service systemd-rfkill.socket

useradd -m drew
echo drew:password | chpasswd


echo "drew ALL=(ALL) ALL" >> /etc/sudoers.d/drew

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
