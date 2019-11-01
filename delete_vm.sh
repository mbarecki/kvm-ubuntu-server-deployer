#!/bin/bash

#Script deletes VM from KVM environment.
#VM is deleted with all associated storage.

#Name of VM which should be deleted (retrieved from user input)
vm_name=$1

#Shutdown VM
virsh destroy ${vm_name}

#Prepare array with VM snapshot names
array_snapshot=$(virsh snapshot-list ${vm_name} | grep -e shutoff -e running -e paused | awk '{print $1}')

#Delete VM snapshots
for snapshot in ${array_snapshot[@]};
do
    echo "Removing snapshot: ${snapshot}"
	virsh snapshot-delete ${vm_name} $snapshot
done

#Delete VM with all associated storage volumes
virsh undefine ${vm_name} --remove-all-storage



