#!/bin/sh

if ( LC_ALL=C lscpu | grep Virtualization )
then
  echo "->Virtualization parameters are enabled."
else
  echo "->Please enable Virtualization paramaters and run this script again."
  exit
fi