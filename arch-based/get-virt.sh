#!/bin/sh

if ( LC_ALL=C lscpu | grep Virtualization )
then
  echo "-> Virtualization parameters are enabled."
else
  echo "-> Please enable Virtualization paramaters and run this script again."
  exit
fi

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