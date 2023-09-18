#!bin/bash

if ( which virt-manager )
then
  echo "-> virt-manager is installed"
else
  echo "-> installing virt-manager"
  apt install virt-manager -y
fi
