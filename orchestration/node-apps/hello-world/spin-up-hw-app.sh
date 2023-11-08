#!/bin/sh


if [ -d "./ubuntu/" ]
then
  echo "ubuntu sub directory exists"
else
  echo "making directory ./ubuntu"
  mkdir ./ubuntu/
fi

if [ -f "./ubuntu/spin-up-jammy.sh" ] 
then
  echo "Ubuntu Jammy spin up script exists"
else
  echo "Getting spin-up-jammy.sh"
  curl -o ./ubuntu/spin-up-jammy.sh https://raw.githubusercontent.com/BRReed/scripts/main/vm-management/cloud-init-configs/ubuntu/spin-up-jammy.sh
fi