#!/bin/bash


if (sudo stat /usr/lib/hello-relpath/package.json)
then
  echo "package.json exists on jammy-cloud"
else
  echo "getting package.json onto jammy-cloud"
  sudo curl -o /usr/lib/hello-relpath/package.json --create-dirs https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/package.json
fi

if (sudo stat /usr/lib/hello-relpath/hello-world-app.js)
then
  echo "hello-world-app exists on jammy-cloud"
else
  echo "getting hello-world-app onto jammy-cloud"
  sudo curl -o /usr/lib/hello-relpath/hello-world-app.js --create-dirs https://raw.githubusercontent.com/BRReed/hello-relativepath/main/hello-world-app.js
fi

if (stat /etc/systemd/system/hello-relpath.service)
then
  echo "hello relpath service file exists"
else
  echo "getting hello-relpath service"
  sudo curl -o /etc/systemd/system/hello-relpath.service https://raw.githubusercontent.com/BRReed/scripts/main/orchestration/node-apps/hello-world/hello-relpath.service
fi

if (systemctl is-active hello-relpath)
then
  echo "hello-relpath is running"
else
  echo "starting hello-relpath"
  sudo systemctl start hello-relpath.service
fi

if (systemctl is-enabled hello-relpath)
then
  echo "hello-relpath is enabled"
else
  echo "enabling hello-relpath"
  sudo systemctl enable hello-relpath.service
fi