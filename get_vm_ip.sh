#!/bin/bash

# Script returns IP address of VM in KVM environment

# Name of VM which IP should be returned (retrieved from user input)
vm_name=$1

# Retrieve MAC address of VM
vm_mac=$(virsh domiflist "${vm_name}" | awk 'NR>2 {print $5}' | awk '!/^$/')

# Retrieve IP address from dhcp leases for VM MAC
vm_ip=$(virsh net-dhcp-leases default --mac "${vm_mac}" | awk 'NR>2 { print $5 }')

echo "${vm_ip}"
