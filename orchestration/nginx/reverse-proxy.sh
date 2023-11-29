#!/bin/bash


if ( nginx -- version )
then
  echo "nginx is installed"
else
  echo "installing nginx"
  sudo apt install nginx
fi