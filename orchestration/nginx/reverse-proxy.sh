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

if (sudo stat /etc/nginx/sites-enabled/hw-app.config)
then
  echo "hw-app is enabled"
else
  echo "enabling hw-app"
  sudo ln -s /etc/nginx/sites-available/hw-app.config /etc/nginx/sites-enabled/
fi

if ( ! sudo stat /etc/nginx/sites-enabled/default )
then
  echo "default nginx site is not enabled"
else
  echo "disabling default nginx site"
  sudo rm /etc/nginx/sites-enabled/default
fi

if (curl -v --silent localhost 2>&1 | grep "Hello, World!")
then
  echo "reverse proxy is established"
else
  echo "reloading nginx service"
  sudo service nginx reload
fi