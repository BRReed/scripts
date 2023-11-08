#!/bin/sh


if [ -f "./spin-up-jammy.sh" ] 
then
  echo "Ubuntu Jammy spin up script exists"
else
  echo "Getting spin-up-jammy.sh"
  curl -o ./spin-up-jammy.sh https://raw.githubusercontent.com/BRReed/scripts/main/vm-management/cloud-init-configs/ubuntu/spin-up-jammy.sh
fi

if [ -f ./get-virt.sh ]
then
  echo "get-virt.sh exists"
else
  echo "getting get-virt.sh"
  curl -o get-virt.sh https://raw.githubusercontent.com/BRReed/scripts/main/get-virt-manager/debian-based/get-virt.sh
fi

sh get-virt.sh

if ( virsh list | grep jammy-cloud )
then
  echo "jammy-cloud vm running"
else
  echo "spinning up jammy-cloud vm"
  sh ./spin-up-jammy.sh&
fi

i=0
# wait for jammy-cloud to finish initialization to continue script 
while [ $i -ne 1 ]
do 
  if ( virsh list | grep jammy-cloud )
  then
    i=1
  else
    echo "sleeping"
    sleep 60
  fi
done