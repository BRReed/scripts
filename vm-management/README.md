# VM Management

## SPIN UP A VM

change `jammy-cloud` in the following command to the name of your VM

change `ubuntu/spin-up-jammy.sh` in the following command to the location of your spin up script

`export VM=jammy-cloud; sh ubuntu/spin-up-jammy.sh && while ( ! ssh -t -o StrictHostKeyChecking=no brian@$(virsh domifaddr $VM | awk -F'[ /]+' '{if (NR>2) print $5}') 2>/dev/null ); do echo -n "."; done
`

## DESTROY A VM

change `jammy-cloud` in the following command to the name of your VM

change `ubuntu/destroy-jammy.sh` in the following command to the location of your spin up script

`export VM=jammy-cloud; sh ubuntu/destroy-jammy.sh`