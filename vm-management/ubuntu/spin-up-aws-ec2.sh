#!/bin/bash


if (unzip --version)
then
  echo "unzip is installed"
else
  echo "installing unzip"
  sudo apt install unzip -y
fi