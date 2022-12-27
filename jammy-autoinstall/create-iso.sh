#!/bin/bash

#Script prepares ISO file for Ubuntu Server unnatended installation.
#Ubuntu live server ISO is downloaded first, then mounted and files are copied from it.
#Next ISO is prepared for unnatended installation.

#URL from which iso will be downloaded
ISO_URL="http://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso"

#Location and name for downloaded iso
ISO_LOCATION="./ubuntu.iso"

#Folder where downloaded iso will be mounted 
ISO_MNT_DIR="/mnt"

#Location for files copied from mounted iso
ISO_COPIED_FILES_DIR="./mod_iso"

#Name and location for created unattended installation ISO file
ISO_UNATTENDED_INSTALL="./autoinstall-ubuntu-jammy.iso"

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

#Create directory for unnatended install
echo "Create directory for unnatended install ${ISO_COPIED_FILES_DIR}/unnatented-install"
mkdir ${ISO_COPIED_FILES_DIR}/unnatented-install

#Copy custom grub.cfg
echo "Copy grub.cfg file to ${ISO_COPIED_FILES_DIR}"
cp ./grub.cfg ${ISO_COPIED_FILES_DIR}/boot/grub/grub.cfg

#Copy user-data
echo "Copy user-data file to ${ISO_COPIED_FILES_DIR}"
cp ./user-data ${ISO_COPIED_FILES_DIR}/unnatented-install

#Copy meta-data
echo "Copy meta-data file to ${ISO_COPIED_FILES_DIR}"
cp ./meta-data ${ISO_COPIED_FILES_DIR}/unnatented-install

#Create iso
echo "Create iso for unattended installation - ${ISO_UNATTENDED_INSTALL} "

# settings for command retrieved with command:
# xorriso -indev ubuntu.iso -report_el_torito as_mkisofs

xorriso -as mkisofs \
  --grub2-mbr --interval:local_fs:0s-15s:zero_mbrpt,zero_gpt:'ubuntu.iso' \
  --protective-msdos-label \
  -partition_cyl_align off \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b --interval:local_fs:2871452d-2879947d::'ubuntu.iso' \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2_start_717863s_size_8496d:all::' \
  -no-emul-boot \
  -boot-load-size 8496 \
  -o ${ISO_UNATTENDED_INSTALL} ${ISO_COPIED_FILES_DIR} 

#Unmount iso file
echo "Unmount iso from ${ISO_MNT_DIR}"
umount ${ISO_MNT_DIR}