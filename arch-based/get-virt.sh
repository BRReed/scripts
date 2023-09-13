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

if ( which dnsmasq )
then
  echo "-> dnsmasq installed"
else
  echo "-> installing dnsmasq"
  yes | pacman -S dnsmasq
fi

if ( which iptables-nft )
then
  echo "-> iptables-nft installed"
else
  echo "-> installing iptables-nft"
  yes | pacman -S iptables-nft
fi

echo "-> enabling libvirtd.service"
systemctl enable libvirtd.service

echo "-> starting libvirtd.service"
systemctl start libvirtd.service

echo "-> adding user: $USER to libvirt group"
usermod -a -G libvirt $USER

echo "-> enabling virtqemud"
systemctl enable virtqemud

echo "-> starting virtqemud"
systemctl start virtqemud

echo "-> enabling virtstoraged"
systemctl enable virtstoraged

echo "-> starting virtstoraged"
systemctl start virtstoraged

echo "-> enabling virtnetworkd"
systemctl enable virtnetworkd

echo "-> starting virtnetworkd"
systemctl start virtnetworkd