# Ubuntu Focal autoinstallation with cloud-init config

Script `create-iso.sh` prepares ISO for Ubuntu Focal unnatended installation with cloud-init config.  

## Usage
```bash
#Download Ubuntu Focal ISO and mount it, create unattended install ISO afterwards
sudo ./focal-autoinstall/create-iso.sh

#Create VM with name labserver
#Operating system will be installed from ISO prepared by create-iso.sh script
./focal-autoinstall/create-vm.sh labserver

#Retrieve IP address of labserver VM
./shared/get-vm-ip.sh labserver

#Delete VM with name labserver
./shared/delete-vm.sh labserver
```

## Authentication
Test accounts is available in created VM:
```
username: test
password: test
```
User `test` has sudo access without password requirement.
