#!/bin/bash


if (unzip --version)
then
  echo "unzip is installed"
else
  echo "installing unzip"
  sudo apt install unzip -y
fi

if (stat ./awscliv2.zip)
then
  echo "awscliv2.zip exists"
else
  echo "getting awscliv2.zip"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
fi

if (stat ./aws/install)
then
  echo "awscliv2.zip has been unzipped"
else
  echo "unzipping awscliv2.zip"
  unzip awscliv2.zip
fi

if (aws --version)
then
  echo "aws cli is installed"
else
  echo "installing aws cli"
  sudo ./aws/install
fi