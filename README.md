# get-virt-manager


## Deploy

1. confirm the target system's virtualization parameters are enabled:
    enter `LC_ALL=C lscpu | grep Virtualization` into target system's terminal.
    Any returned value means they are enabled.

2. Download `get-virt.sh` to the directory of your choosing. 

3. Run the command `arch-based/sh get-virt.sh`