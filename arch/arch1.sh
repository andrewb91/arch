#!/bin/bash

cryptsetup luksFormat /dev/sdb2

cryptsetup open /dev/sdb2 cryptlvm

pvcreate /dev/mapper/cryptlvm 

vgcreate vg1 /dev/mapper/cryptlvm

lvcreate -L 40G vg1 -n root
lvcreate -L 15G vg1 -n var
lvcreate -L 16G vg1 -n swap
lvcreate -L 100G vg1 -n home

mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/vg1/root
mkfs.ext4 /dev/vg1/var
mkfs.ext4 /dev/vg1/home
mkswap /dev/vg1/swap

mount /dev/vg1/root /mnt
mkdir /mnt/boot
mount /dev/sdb1 /mnt/boot
mkdir /mnt/var
mount /dev/vg1/var /mnt/var
mkdir /mnt/home
mount /dev/vg1/home /mnt/home

swapon /dev/vg1/swap
