#!/bin/sh

if ( curl --version )
then
  echo "curl is installed"
else
  echo "installing curl"
  sudo apt install curl -y
fi

if ( virt-install --version )
then
  echo "virt-install is installed"
else
  echo "installing virt-install"
  sudo apt install virtinst -y
fi

if [ -f "./spin-up-jammy.sh" ] 
then
  echo "Ubuntu Jammy spin up script exists"
else
  echo "Getting spin-up-jammy.sh"
  curl -o ./spin-up-jammy.sh https://raw.githubusercontent.com/BRReed/scripts/main/vm-management/cloud-init-configs/ubuntu/spin-up-jammy.sh
fi

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
    echo "ITS UP!"
    i=1
  else
    echo "sleeping"
    sleep 60
  fi
done