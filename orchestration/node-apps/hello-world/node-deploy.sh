#!/bin/bash

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "stat ./Dockerfile" )
then
  echo "dockerfile exists on jammy-cloud"
else
  echo "getting dockerfile onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./Dockerfile https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/Dockerfile"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "stat ./package.json" )
then
  echo "package.json exists on jammy-cloud"
else
  echo "getting package.json onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./package.json https://raw.githubusercontent.com/BRReed/hello-relativepath/main/scripts/docker/hello-world-app/package.json"
fi

if ( ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "stat ./hello-world-app.js" )
then
  echo "hello-world-app exists on jammy-cloud"
else
  echo "getting hello-world-app onto jammy-cloud"
  ssh -q brian@$(virsh domifaddr jammy-cloud | awk -F'[ /]+' '{if (NR>2) print $5}') "curl -o ./hello-world-app.js https://raw.githubusercontent.com/BRReed/hello-relativepath/main/hello-world-app.js"
fi