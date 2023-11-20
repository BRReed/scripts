#!/bin/sh

if ( apt-cache show npm )
then
  echo "npm is in packages list"
else
  echo "cannot find npm, updating package list"
  sudo DEBIAN_FRONTEND=noninteractive apt update
fi

if ( apt-cache show nodejs )
then
  echo "nodejs is in packages list"
else
  echo "cannot find nodejs, updating packages list"
  sudo DEBIAN_FRONTEND=noninteractive apt update
fi

if ( dpkg -s npm )
then
  echo "-> npm is installed"
else
  echo "-> Installing npm"
  sudo apt install npm -y
fi

if ( dpkg -s nodejs )
then
  echo "-> nodejs is installed"
else
  echo "-> Installing nodejs"
  sudo apt install nodejs -y
fi