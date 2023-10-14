#!/bin/sh


if ( apt-cache show ca-certificates )
then
  echo "-> ca-certificates is in packages list"
else
  echo "-> cannot find ca-certificates, updating package list"
  sudo DEBIAN_FRONTEND=noninteractive apt update
fi 

if ( apt-cache show curl )
then
  echo "-> curl is in packages list"
else
  echo "-> cannot find curl, updating packages list"
  sudo DEBIAN_FRONTEND=noninteractive apt update
fi

if ( apt-cache show gnupg )
then
  echo "-> gnupg is in packages list"
else
  echo "-> cannot find gnupg, updating packages list"
  sudo DEBIAN_FRONTEND=noninteractive apt update
fi

if [ -d /etc/apt/keyrings ]
then
  echo "-> /etc/apt/keyrings exists"
else
  echo "-> creating /etc/apt/keyrings"
  sudo install -m 0755 -d /etc/apt/keyrings
fi

if [ -f /etc/apt/keyrings/docker.gpg ]
then
  echo "-> docker.gpg exists"
else
  echo "-> getting docker.gpg"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi 