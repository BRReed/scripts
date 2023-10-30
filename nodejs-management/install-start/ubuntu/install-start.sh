#!/bin/sh

if ( npm ls )
then
  echo "Dependencies have been installed"
else
  echo "Installing dependencies"
  npm install
fi

if ( lsof -i:$1 )
then
  echo "the app is running on $1"
else
  echo "Starting the app"
  npm start
fi