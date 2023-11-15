#!/bin/bash

# get ip of vm, sshkeygenremove from known host

if !(virsh list --all | grep " ${VM} ") then
  echo "jammy-cloud vm does not exist"
else
  echo "destroy, undefine and removing all storage for jammy-cloud vm"
  virsh destroy $VM && virsh undefine $VM --remove-all-storage
fi

if !(find user-data) then
  echo "user-data does not exist"
else
  echo "removing user-data"
  rm user-data
fi
