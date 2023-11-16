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

if ( virsh list | grep jammy-cloud )
then
  echo "jammy-cloud vm running"
else
  echo "spinning up jammy-cloud vm"
  export VM=jammy-cloud; curl https://raw.githubusercontent.com/BRReed/scripts/main/vm-management/ubuntu/spin-up-jammy.sh | bash && while ( ! ssh -t -o StrictHostKeyChecking=no brian@$(virsh domifaddr $VM | awk -F'[ /]+' '{if (NR>2) print $5}') 2>/dev/null ); do echo -n "."; done
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'docker --version' )
then
  echo "docker exists on remote vm"
else
  echo "getting docker on remote vm"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'curl https://raw.githubusercontent.com/BRReed/scripts/main/get-docker/ubuntu/get-docker.sh | bash'
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'dpkg -s npm' )
then
  echo "npm exists on remote vm"
else
  echo "getting npm on remote vm"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') 'curl https://raw.githubusercontent.com/BRReed/scripts/main/get-node/ubuntu/get-node.sh | bash'
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./Dockerfile ] )
then
  echo "dockerfile exists on jammy-cloud"
else
  echo "getting dockerfile onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./Dockerfile https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/Dockerfile"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./package.json ] )
then
  echo "package.json exists on jammy-cloud"
else
  echo "getting package.json onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./package.json https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/package.json"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') [ -f ./hello-world-app.js ] )
then
  echo "hello-world-app exists on jammy-cloud"
else
  echo "getting hello-world-app onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./hello-world-app.js https://raw.githubusercontent.com/BRReed/hello-relativepath/main/hello-world-app.js"
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