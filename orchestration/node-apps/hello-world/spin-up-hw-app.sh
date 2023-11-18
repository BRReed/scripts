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
  curl https://raw.githubusercontent.com/BRReed/scripts/main/vm-management/ubuntu/spin-up-jammy.sh | bash && while ( ! ssh -t -o StrictHostKeyChecking=no brian@$(virsh domifaddr $VM | awk -F'[ /]+' '{if (NR>2) print $5}') 2>/dev/null ); do echo -n "."; done
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

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl localhost:3000" )
then
  echo "hello world app is started"
else
  echo "starting hello-world-app"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl https://raw.githubusercontent.com/BRReed/scripts/breed/orches-relpath/orchestration/node-apps/hello-world/node-deploy.sh | bash"
fi