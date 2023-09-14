#!bin/bash

if ( which virt-manager )
then
  echo "-> virt-manager is installed"
else
  echo "-> installing virt-manager"
  apt install virt-manager -y
fi

if ( which kvm )
then
  echo "-> qemu-kvm is installed"
else
  echo "-> installing qemu-kvm"
  apt install qemu-kvm -y
fi

if ( which libvirtd )
then
  echo "-> libvirt is installed"
else
  echo "-> installing libvirt"
  apt install libvirt -y
fi