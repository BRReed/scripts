#!/bin/bash


if ( nginx -v )
then
  echo "nginx is installed"
else
  echo "installing nginx"
  sudo apt install nginx -y
fi

if (sudo stat /etc/nginx/sites-available/hw-app.config)
then
  echo "hw-app config file exists"
else
  echo "getting hw-app.config"
  sudo curl -o /etc/nginx/sites-available/hw-app.config PLACEHOLDER FOR CONFIG URL
fi