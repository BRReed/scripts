#!/bin/bash

if (stat ./Dockerfile)
then
  echo "dockerfile exists on jammy-cloud"
else
  echo "getting dockerfile onto jammy-cloud"
  curl -o ./Dockerfile https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/Dockerfile
fi

if (stat ./package.json)
then
  echo "package.json exists on jammy-cloud"
else
  echo "getting package.json onto jammy-cloud"
  curl -o ./package.json https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/package.json
fi

if (stat ./hello-world-app.js)
then
  echo "hello-world-app exists on jammy-cloud"
else
  echo "getting hello-world-app onto jammy-cloud"
  curl -o ./hello-world-app.js https://raw.githubusercontent.com/BRReed/hello-relativepath/main/hello-world-app.js
fi

if ( npm ls )
then
  echo "Dependencies have been installed"
else
  echo "Installing dependencies"
  npm install
fi

if (stat /etc/systemd/system/hello-relpath.service)
then
  echo "hello relpath service file exists"
else
  echo "getting hello-relpath service"
  sudo curl -o /etc/systemd/system/hello-relpath.service https://raw.githubusercontent.com/BRReed/scripts/main//orchestration/node-apps/hello-world/hello-relpath.service
fi

if (systemctl is-active hello-relpath)
then
  echo "hello-relpath is running"
else
  echo "starting and enabling reboot on restart for hello-relpath"
  sudo systemctl daemon-reload
  sudo systemctl start hello-relpath.service
  sudo systemctl enable hello-relpath.service
fi