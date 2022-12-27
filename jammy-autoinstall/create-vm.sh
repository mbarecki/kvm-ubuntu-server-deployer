#!/bin/bash

#Script creates VM in KVM environment.
#Variable ISO_UNATTENDED_INSTALL points to file prepared by script create-iso.sh

#Name for created VM (retrieved from user input)
vm_name=$1

#Amount of RAM for VM in MB
VM_RAM="2048"

#Amount of CPUS for VM
VM_VCPUS="2"

#VM disk size in GB
VM_DISK_SIZE="10"

#VM disk format
VM_DISK_FORMAT="qcow2"

#Network bridge to which VM will be connected
VM_NETWORK_BRIDGE="virbr0"

#os variant which will be instaled in VM
VM_OS_VARIANT="ubuntu22.04"

#Location for VM disk file (KVM default virtual storage location)
VM_DISK_LOCATION="/var/lib/libvirt/images"

#Name and location for unattended installation ISO file
ISO_UNATTENDED_INSTALL="./autoinstall-ubuntu-jammy.iso"

#Create VM
virt-install \
--name ${vm_name} \
--os-variant ${VM_OS_VARIANT} \
--ram ${VM_RAM} \
--vcpus ${VM_VCPUS} \
--network bridge=${VM_NETWORK_BRIDGE} \
--cdrom ${ISO_UNATTENDED_INSTALL} \
--disk ${VM_DISK_LOCATION}/${vm_name}.${VM_DISK_FORMAT},size=${VM_DISK_SIZE},format=${VM_DISK_FORMAT}
