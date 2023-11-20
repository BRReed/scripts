#!/bin/bash


ssh-keygen -f ~/.ssh/known_hosts -R "$(virsh domifaddr ${VM} | awk -F'[ /]+' '{if (NR>2) print $5}')"
virsh destroy $VM && virsh undefine $VM --remove-all-storage && rm user-data