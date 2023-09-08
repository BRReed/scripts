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
  yes | pacman -S virt-manager
fi