#!/bin/bash

#Script prepares ISO file for Ubuntu Server unnatended installation.
#Ubuntu live server ISO is downloaded first, then mounted and files are copied from it.
#Next ISO is prepared for unnatended installation.

#URL from which iso will be downloaded (ubuntu alternative server installer)
ISO_URL="http://releases.ubuntu.com/20.04/ubuntu-20.04.5-live-server-amd64.iso"

#Location and name for downloaded iso
ISO_LOCATION="./ubuntu.iso"

#Folder where downloaded iso will be mounted 
ISO_MNT_DIR="/mnt"

#Location for files copied from mounted iso
ISO_COPIED_FILES_DIR="./mod_iso"

#Name and location for created unattended installation ISO file
ISO_UNATTENDED_INSTALL="./autoinstall-ubuntu-focal.iso"

#Download iso if it is not present on the disk
if [ -f "${ISO_LOCATION}" ]; then
	echo "ISO file exists - do not need to download it"
else
	echo "Downloading iso file"
	wget --output-document ${ISO_LOCATION} $ISO_URL
fi

#Mount downloaded iso file
echo "Mounting iso"
mount --options loop,ro ${ISO_LOCATION} ${ISO_MNT_DIR}

#Copy files from mounted iso
echo "Copy files from mounted iso"
cp --recursive --no-target-directory ${ISO_MNT_DIR} ${ISO_COPIED_FILES_DIR}

#Replace file with boot options
echo "Replace txt.cfg in ${ISO_COPIED_FILES_DIR}/isolinux"
cp txt.cfg ${ISO_COPIED_FILES_DIR}/isolinux

#Modify isolinux.cfg
echo "Modify default boot option in isolinux.cfg"
sed --in-place 's/default vesamenu.c32/default install/' ${ISO_COPIED_FILES_DIR}/isolinux/isolinux.cfg
echo "Delete ui option in isolinux.cfg"
sed --in-place '/ui gfxboot bootlogo/d' ${ISO_COPIED_FILES_DIR}/isolinux/isolinux.cfg

#Create directory for unnatended install
echo "Create directory for unnatended install ${ISO_COPIED_FILES_DIR}/unnatented-install"
mkdir ${ISO_COPIED_FILES_DIR}/unnatented-install

#Copy user-data
echo "Copy user-data file to ${ISO_COPIED_FILES_DIR}"
cp ./user-data ${ISO_COPIED_FILES_DIR}/unnatented-install

#Copy meta-data
echo "Copy meta-data file to ${ISO_COPIED_FILES_DIR}"
cp ./meta-data ${ISO_COPIED_FILES_DIR}/unnatented-install

#Create iso
echo "Create iso for unattended installation - ${ISO_UNATTENDED_INSTALL} "
mkisofs -quiet \
        -D -r -V UNATTENDED_INSTALL -cache-inodes -J -l -b isolinux/isolinux.bin \
        -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
        -o ${ISO_UNATTENDED_INSTALL} ${ISO_COPIED_FILES_DIR} 

#Unmount iso file
echo "Unmount iso from ${ISO_MNT_DIR}"
umount ${ISO_MNT_DIR}
