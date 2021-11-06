#!/usr/bin/env bash

VM_NAME="micro"
PLAYBOOK="https://raw.githubusercontent.com/rajasoun/traefik-load-balancer/main/provision/docker.yml"

if ! [ -x "$(command -v multipass)" ]; then
    echo 'Error: multipass is not installed.' >&2
    echo 'Goto https://multipass.run/'
    exit 1
fi

multipass launch --name $VM_NAME --cpus 2 --mem 2G --disk 5G --cloud-init provision/cloud-init.yaml
multipass exec $VM_NAME -- sudo apt-get install ansible -y 
multipass exec $VM_NAME -- ansible-galaxy install geerlingguy.docker
multipass exec $VM_NAME -- wget ${PLAYBOOK} -P  /tmp
multipass exec $VM_NAME -- ansible-playbook /tmp/docker.yml
multipass shell $VM_NAME
