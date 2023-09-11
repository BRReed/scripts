#!/bin/sh

if ( which virt-manager )
then
  echo "-> virt-manager is installed"
else
  echo "-> installing virt-manager"
  pacman -S virt-manager --noconfirm
fi

if ( which qemu-desktop )
then
  echo "-> qemu-desktop is installed"
else
  echo "-> installing qemu-desktop"
  yes | pacman -S qemu-desktop
fi

if ( which libvirtd )
then
  echo "-> libvirt is installed"
else
  echo "-> installing libvirt"
  yes | pacman -S libvirt
fi

if ( pacman -Qi edk2-ovmf )
then
  echo "-> edk2-ovmf is installed"
else
 echo "-> installing edk2-ovmf"
 yes | pacman -S edk2-ovmf
fi