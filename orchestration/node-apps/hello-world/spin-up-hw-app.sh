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

if [ -f "./get-docker.sh" ]
then
  echo "get docker script exists"
else
  echo "getting get-docker.sh"
  curl -o ./get-docker.sh https://raw.githubusercontent.com/BRReed/scripts/main/get-docker/ubuntu/get-docker.sh
fi

# check if get-docker script already exists on vm
if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./get-docker.sh ] )
then
  echo "get-docker.sh exists on jammy-cloud"
else
  echo "getting get-docker.sh onto jammy-cloud"
  cat ./get-docker.sh | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./get-docker.sh"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'docker --version' )
then
  echo "docker exists on remote vm"
else
  echo "getting docker on remote vm"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'bash < ./get-docker.sh'
fi