#!/bin/sh

if ( npm ls )
then
  echo "Dependencies have been installed"
else
  echo "Installing dependencies"
  npm install
fi

# $1 expected to be address of app localhost:80, google.com, etc 
if [ "$(curl -s -o /dev/null -w "%{http_code}" $1)" -eq 200 ]
then
  echo "the app is running on $1"
else
  echo "Starting the app"
  npm start
fi