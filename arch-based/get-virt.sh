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

echo "-> adding user: $USER to libvirt group"
usermod -a -G libvirt $USER

if ( systemctl is-enabled libvirtd )
then
  echo "-> libvirtd is enabled"
else
  echo "-> enabling libvirtd.service"
  systemctl enable libvirtd.service
fi

if ( systemctl is-active libvirtd )
then
  echo "-> libvirtd is started"
else
  echo "-> starting libvirtd.service"
  systemctl start libvirtd.service
fi

if ( systemctl is-enabled virtqemud )
then
  echo "-> virtqemud is enabled"
else
  echo "-> enabling virtqemud"
  systemctl enable virtqemud
fi

if ( systemctl is-active virtqemud )
then
  echo "-> virtqemud is started"
else
  echo "-> starting virtqemud"
  systemctl start virtqemud
fi

if ( systemctl is-enabled virtstoraged )
then
  echo "-> virtstoraged is enabled"
else
  echo "-> enabling virtstoraged"
  systemctl enable virtstoraged
fi

echo "-> starting virtstoraged"
systemctl start virtstoraged

echo "-> enabling virtnetworkd"
systemctl enable virtnetworkd

echo "-> starting virtnetworkd"
systemctl start virtnetworkd