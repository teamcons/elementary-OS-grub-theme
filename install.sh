#!/bin/bash


# Restart the script with sudo if user forgor it
if [[ $EUID -ne 0 ]];
then
    echo "This script requires root privileges!"
    exec sudo /bin/bash "$0"
fi

# Create theme folder
mkdir -v /boot/grub/themes
mkdir -v /boot/grub/themes/elementaryOS

# Move theme there
cp -vr ./* /boot/grub/themes/elementaryOS/
cp -vr ./fonts/inter* /boot/grub/fonts/

# If user gave in a logo, overwrite the default with it
if [[ -f "$*" ]] 
then
    cp -frv "$*" /boot/grub/themes/elementaryOS/logo.png
fi


# Lets avoid pollution: Remove previous GRUB_THEME entry if any
cat "/etc/default/grub"             > /etc/default/grub.previous
cat "/etc/default/grub.previous"      | grep -v "GRUB_THEME="  > "/etc/default/grub"

# Leave nothing behind
rm -rf "/etc/default/grub.previous"

# Add entry
echo "GRUB_THEME=/boot/grub/themes/elementaryOS/theme.txt" >> "/etc/default/grub"

# Update grub configuration
# Is update-grub enough ?
update-grub
