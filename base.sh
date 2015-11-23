#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
curl -O https://raw.githubusercontent.com/BBuLLeTT/BArch/master/barch.service
curl -O https://raw.githubusercontent.com/BBuLLeTT/BArch/master/barch.sh
curl -O https://raw.githubusercontent.com/BBuLLeTT/BArch/master/chroot.sh
#pacstrap -i $1 base base-devel --noconfirm
#genfstab -U $1 > $1/etc/fstab
cp ./chroot.sh $1/
cp ./barch.service $1/etc/systemd/system/
cp ./barch.sh $1/etc/profile.d/
arch-chroot $1 /bin/bash /chroot.sh
#reboot