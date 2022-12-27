# KVM Ubuntu Server Deployer

This repository contains bash scripts for deploying KVM Virtual Machine with Ubuntu Server installed in it. 

I wanted to learn about KVM and have possibility to create lab/test VM's in automated way. This was starting idea behind that project.

Scope:
- ISO for Ubuntu Bionic server is downloaded and modified for unattended installation with kickstart and preseed files.
- ISO for Ubuntu Focal server is downloaded and modified for unattended installation with cloud-init config.
- ISO for Ubuntu Jammy server is downloaded and modified for unattended installation with cloud-init config.
- VM in KVM environment is deployed and Ubuntu server is installed in it from prepared ISO.

Additional information can be found in files:
- [Ubuntu Bionic installation](bionic-preseed/README.md)
- [Ubuntu Focal installation](focal-autoinstall/README.md)
- [Ubuntu Jammy installation](jammy-autoinstall/README.md)
- [SSH access to created VM](./shared/ssh-information.md)

## Requirements
KVM installed and listed tools available:
- mkisofs  
- xorriso  
- wget
- virsh 
- virt-install 

## Installation
Clone repository:
```bash
git clone https://github.com/mbarecki/kvm-ubuntu-server-deployer.git
```

## Sources
Links to resources which helped me during work on that project:  

KVM installation in Ubuntu system:  
- https://help.ubuntu.com/community/KVM/Installation  

KVM related topics:  
- https://www.linux-kvm.org/page/Main_Page  
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-virsh-delete  
- https://computingforgeeks.com/virsh-commands-cheatsheet/  

ISO preparation for unattended Ubuntu Server Bionic installation:  
- https://askubuntu.com/questions/122505/how-do-i-create-a-completely-unattended-install-of-ubuntu  
- https://askubuntu.com/questions/16757/kickstart-file-is-ignored-by-the-installer  
- https://askubuntu.com/questions/777218/debugging-preseed-late-command-for-ubuntu-16-04-server-tee-not-found-vs-nonexis  

ISO preparation for Ubuntu Focal automated installation with cloud-init config:
- https://ubuntu.com/server/docs/install/autoinstall
- https://cloudinit.readthedocs.io/en/latest/topics/datasources/nocloud.html
- https://cloudinit.readthedocs.io/en/latest/topics/examples.html
- https://www.pugetsystems.com/labs/hpc/How-To-Make-Ubuntu-Autoinstall-ISO-with-Cloud-init-2213/
- https://louwrentius.com/understanding-the-ubuntu-2004-lts-server-autoinstaller.html
- https://askubuntu.com/questions/644798/custom-livecd-skip-install-boot-to-desktop-and-run-custom-app
- https://arstechnica.com/civis/viewtopic.php?f=16&t=1479316

BASH:  
- https://stackoverflow.com/questions/20622128/bash-scripting-redirection-not-working-why  

SSH:  
- https://unix.stackexchange.com/questions/48863/ssh-add-complains-could-not-open-a-connection-to-your-authentication-agent/48868  
