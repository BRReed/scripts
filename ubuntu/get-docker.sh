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

if [ -f /etc/ssl/certs/ca-certificates.crt ]
then
  echo "-> /etc/ssl/certs/ca-certificates.crt exists"
else
  echo "-> installing ca-certificates"
  sudo apt install ca-certificates
fi

if ( which curl )
then
  echo "-> curl is installed"
else
  echo "-> installing curl"
  sudo apt install curl
fi

if ( which gpg )
then
  echo "-> gnupg is installed"
else
  echo "-> installing gnupg"
  sudo apt install gnupg
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

if ( cat /etc/apt/sources.list.d/docker.list | grep ubuntu )
then
  echo "-> docker.list already populated"
else
  echo "-> Populating docker.list"
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
fi

if ( apt-cache show docker )
then
  echo "-> docker is in package list"
else
  echo "-> cannot find docker in packages, updating package list"
  sudo apt update
fi

if ( sudo docker ps )
then
  echo "-> docker-ce is installed"
else
  echo "-> installing docker-ce"
  sudo apt install docker-ce -y
fi