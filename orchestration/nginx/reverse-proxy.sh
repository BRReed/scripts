#!/bin/bash


if ( nginx -v )
then
  echo "nginx is installed"
else
  echo "installing nginx"
  sudo apt install nginx -y
fi