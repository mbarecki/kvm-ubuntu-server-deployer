#!/bin/bash

# Script returns IP address of VM in KVM environment

# Name of VM which IP should be returned (retrieved from user input)
vm_name=$1

# Retrieve VM IP using arp
vm_ip=$(virsh domifaddr --source arp "${vm_name}" | awk 'NR>2 { print $4 }')

echo "${vm_ip}"
