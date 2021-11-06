#!/usr/bin/env bash
VM_NAME="micro"

multipass stop ${VM_NAME} 
multipass delete ${VM_NAME}
multipass purge

