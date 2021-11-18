# Ubuntu Bionic unnatended installation with preseed files

Script `create-iso.sh` prepares ISO for Ubuntu Bionic unnatended installation with preseed files.  

## Usage
```bash
#Download Ubuntu Bionic ISO and mount it, create unattended install ISO afterwards
sudo ./bionic-preseed/create-iso.sh

#Create VM with name labsrv
#Operating system will be installed from ISO prepared by create-iso.sh script
./bionic-preseed/create-vm.sh labsrv

#Retrieve IP address of labsrv VM
./shared/get-vm-ip.sh labsrv

#Delete VM with name labsrv
./shared/delete-vm.sh labsrv
```

## Authentication
Two accounts are available in created VM:
```
username: root
password: ChangeMe!

username: test
password: test
```
User `test` has sudo access without password requirement.
