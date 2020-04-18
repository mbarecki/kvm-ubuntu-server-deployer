# KVM Ubuntu Server Deployer

This repository contains bash scripts for deploying KVM Virtual Machine with Ubuntu Server installed in it. 

I wanted to learn about KVM and have possibility to create lab/test VM's in automated way. This was starting idea behind that project.

Scope:
- ISO for Ubuntu server 18.04.4 (alternative server installer) is downloaded and modified for unattended installation with kickstart and preseed files.
- VM in KVM environment is deployed and Ubuntu server is installed in it from prepared ISO.

## Requirements
KVM installed and listed tools available:
- mkisofs  
- wget
- virsh 
- virt-install 

## Installation
Clone repository:
```bash
git clone https://github.com/mbarecki/kvm-ubuntu-server-deployer.git
```

## Usage
```bash
#Change to the folder with cloned repository
cd kvm-ubuntu-server-deployer

#Download Ubuntu ISO and mount it, create unattended install ISO afterwards
sudo ./create_iso.sh

#Create VM with name labsrv
#Operating system will be installed from ISO prepared by create_iso.sh script
./create_vm.sh labsrv

#Delete VM with name labsrv
./delete_vm.sh labsrv
```

Two accounts are available in created VM:
```
username: root
password: ChangeMe!

username: test
password: test
```
User test has sudo access.

SSH server is installed in created VM. 

## Sources
Links to resources which helped me during work on that project:  

KVM installation in Ubuntu system:  
https://help.ubuntu.com/community/KVM/Installation  

KVM related topics:  
https://www.linux-kvm.org/page/Main_Page  
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-virsh-delete  
https://computingforgeeks.com/virsh-commands-cheatsheet/  

ISO preparation for unattended Ubuntu Server installation:  
https://askubuntu.com/questions/122505/how-do-i-create-a-completely-unattended-install-of-ubuntu  
https://askubuntu.com/questions/16757/kickstart-file-is-ignored-by-the-installer  
