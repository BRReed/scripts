#!/bin/bash

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
    ssh -o StrictHostKeyChecking=no brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "bash --version"
    i=1
  else
    echo "sleeping"
    sleep 60
  fi
done

# GET DOCKER COMMANDS

if [ -f "./get-docker.sh" ]
then
  echo "get docker script exists locally"
else
  echo "getting get-docker.sh"
  curl -o ./get-docker.sh https://raw.githubusercontent.com/BRReed/scripts/main/get-docker/ubuntu/get-docker.sh
fi

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

# GET NODE COMMANDS

if [ -f "./get-node.sh" ]
then
  echo "get node script exists locally"
else
  echo "getting get node script"
  curl -o ./get-node.sh https://raw.githubusercontent.com/BRReed/scripts/main/get-node/ubuntu/get-node.sh
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./get-node.sh ] )
then
  echo "get-node.sh exists on jammy-cloud"
else
  echo "getting get-docker.sh onto jammy-cloud"
  cat ./get-node.sh | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./get-node.sh"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'dpkg -s npm' )
then
  echo "npm exists on remote vm"
else
  echo "getting npm on remote vm"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'bash < ./get-node.sh'
fi

# DOCKERFILE COMMANDS

if [ -f "./Dockerfile" ]
then
  echo "dockerfile exists locally"
else
  echo "getting dockerfile"
  curl -o ./Dockerfile https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/Dockerfile
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./Dockerfile ] )
then
  echo "dockerfile exists on jammy-cloud"
else
  echo "getting dockerfile onto jammy-cloud"
  cat ./Dockerfile | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./Dockerfile"
fi

# PACKAGE.JSON COMMANDS

if [ -f "./package.json" ]
then
  echo "package.json exists locally"
else
  echo "getting package.json"
  curl -o ./package.json https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/package.json
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./package.json ] )
then
  echo "package.json exists on jammy-cloud"
else
  echo "getting package.json onto jammy-cloud"
  cat ./package.json | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./package.json"
fi

if [ -f "./hello-world-app.js" ]
then 
  echo "hello-world-app exists locally"
else
  echo "getting hello-world-app"
  curl -o ./hello-world-app.js https://raw.githubusercontent.com/BRReed/hello-relativepath/main/hello-world-app.js
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./hello-world-app.js ] )
then
  echo "hello-world-app exists on jammy-cloud"
else
  echo "getting hello-world-app onto jammy-cloud"
  cat ./hello-world-app.js | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./hello-world-app.js"
fi

if [ -f "./install-start.sh" ]
then 
  echo "install start node script exists locally"
else
  echo "getting install-start script"
  curl -o ./install-start.sh https://raw.githubusercontent.com/BRReed/scripts/main/nodejs-management/install-start/ubuntu/install-start.sh
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./install-start.sh ] )
then
  echo "install-start exists on jammy-cloud"
else
  echo "getting install-start onto jammy-cloud"
  cat ./install-start.sh | ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "cat > ./install-start.sh"
fi

ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'bash < ./install-start.sh&'