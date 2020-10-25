# KVM Ubuntu Server Deployer

This repository contains bash scripts for deploying KVM Virtual Machine with Ubuntu Server installed in it. 

I wanted to learn about KVM and have possibility to create lab/test VM's in automated way. This was starting idea behind that project.

Scope:
- ISO for Ubuntu server 18.04.5 (alternative server installer) is downloaded and modified for unattended installation with kickstart and preseed files.
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

## Authentication
Two accounts are available in created VM:
```
username: root
password: ChangeMe!

username: test
password: test
```
User test has sudo access.

[SSH key](id_rsa_test.pub) is added to SSH `authorzied_keys` in created VM.

Commands for adding related ssh private key to authentication agent:
```bash
# Copy ssh private key to .ssh folder
cp id_rsa_test ~/.ssh

# Set file permissions and ownership
chmod 600 ~/.ssh/id_rsa_test
chown $USER:$USER ~/.ssh/id_rsa_test

# Add SSH private key to authentication agent
ssh-add ~/.ssh/id_rsa_test

# Verify that key was added
ssh-add -l

# In case when message 'Could not open a connection to your authentication agent.' is received from ssh-add
ssh-agent bash
```

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
https://askubuntu.com/questions/777218/debugging-preseed-late-command-for-ubuntu-16-04-server-tee-not-found-vs-nonexis  

BASH:  
https://stackoverflow.com/questions/20622128/bash-scripting-redirection-not-working-why  

SSH:  
https://unix.stackexchange.com/questions/48863/ssh-add-complains-could-not-open-a-connection-to-your-authentication-agent/48868  
