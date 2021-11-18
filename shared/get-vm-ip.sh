#!/bin/bash

# Script returns IP address of VM in KVM environment.
# In case VM name is not provided script returns IP addresses of all running VM's.

# Name of VM which IP should be returned (retrieved from user input)
vm_name=$1

# Retrieve VM IP when VM name was provided
if [ -n "$1" ]; then
  vm_ip=$(virsh domifaddr --source arp "${vm_name}" | awk 'NR>2 { print $4 }')
  echo "${vm_ip}"
# if VM name not provided retrieve IP addresses of all running VMs
else
  array_running_vm=$(virsh list | grep 'running' | awk '{print $2}')
  for vm_name in ${array_running_vm[@]};
  do
      vm_ip=$(virsh domifaddr --source arp "${vm_name}" | awk 'NR>2 { print $4 }')
      echo "${vm_name} IP: ${vm_ip}"
  done
fi
