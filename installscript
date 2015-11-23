#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
#pacstrap -i $1 base base-devel --noconfirm
#genfstab -U $1 > $1/etc/fstab
cp ./chrootscript $1/
arch-chroot $1 /bin/bash /chrootscript
#reboot