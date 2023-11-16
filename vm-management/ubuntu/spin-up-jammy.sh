#!/bin/bash


if (find user-data) then
  echo "user-data exists"
else
  echo "Creating user-data"
  tee "./user-data" > /dev/null << EOF
#cloud-config

hostname: 
  - ${VM}
users:
  - default
  - name: brian
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh-authorized-keys:
      - $(cat ~/.ssh/id_ed25519.pub)
EOF
fi

if (find ~/spaghetti/scripts/vm-management/images/jammy-server-cloudimg-amd64.img) then
  echo "jammy-server-cloudimg-amd64.img exists"
else
  echo "Downloading latest jammy-server-cloudimg-amd64.img"
  wget -O ~/spaghetti/scripts/vm-management/images/jammy-server-cloudimg-amd64.img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
fi

if [ -f ./$VM.qcow2 ]; then
  echo "${VM}.qcow2 already exists"
else
  echo "creating ${VM}.qcow2"
  qemu-img create -F qcow2 -b ~/spaghetti/scripts/vm-management/images/jammy-server-cloudimg-amd64.img -f qcow2 ./$VM.qcow2 50G
fi

if (virsh list | grep running | grep $VM) then
  echo "${VM} already exists"
else
  echo "Installing ${VM} vm"
  virt-install --name $VM --memory 4096 --vcpus 4 --os-variant ubuntujammy --disk ./$VM.qcow2 --cloud-init user-data=./user-data --import --noautoconsole --autostart
fi