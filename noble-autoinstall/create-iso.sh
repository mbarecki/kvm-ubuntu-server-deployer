#!/bin/bash

#Script prepares ISO file for Ubuntu Server unnatended installation.
#Ubuntu live server ISO is downloaded first, then mounted and files are copied from it.
#Next ISO is prepared for unnatended installation.

#URL from which iso will be downloaded
ISO_URL="https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso"

#Location and name for downloaded iso
ISO_LOCATION="./ubuntu-noble.iso"

#Folder where downloaded iso will be mounted 
ISO_MNT_DIR="/mnt"

#Location for files copied from mounted iso
ISO_COPIED_FILES_DIR="./mod_iso"

#Created unattended installation ISO file name
ISO_UNATTENDED_INSTALL_NAME="autoinstall-ubuntu-noble.iso"

#Created unattended installation ISO file location
ISO_UNATTENDED_INSTALL_LOCATION="/var/lib/libvirt/images/${ISO_UNATTENDED_INSTALL_NAME}"

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
echo "Create iso for unattended installation - ${ISO_UNATTENDED_INSTALL_LOCATION} "

# settings for command retrieved with command:
# xorriso -indev ubuntu-noble.iso -report_el_torito as_mkisofs

xorriso -as mkisofs \
  --grub2-mbr --interval:local_fs:0s-15s:zero_mbrpt,zero_gpt:'ubuntu-noble.iso' \
  --protective-msdos-label \
  -partition_cyl_align off \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b --interval:local_fs:6441216d-6451375d::'ubuntu-noble.iso' \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2_start_1610304s_size_10160d:all::' \
  -no-emul-boot \
  -boot-load-size 10160 \
  -o ${ISO_UNATTENDED_INSTALL_LOCATION} ${ISO_COPIED_FILES_DIR}

#Unmount iso file
echo "Unmount iso from ${ISO_MNT_DIR}"
umount ${ISO_MNT_DIR}