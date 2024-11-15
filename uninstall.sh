#!/bin/bash


# Restart the script with sudo if user forgor it
if [[ $EUID -ne 0 ]];
then
    echo "This script requires root privileges!"
    exec sudo /bin/bash "$0"
fi

# Remove the line
cat "/etc/default/grub"               > "/etc/default/grub.previous"
cat "/etc/default/grub.previous"      | grep -v "GRUB_THEME="  > "/etc/default/grub"

# Update grub configuration
# Is update-grub enough ?
update-grub

# Interactively ask if remove theme completely
rm -rvi "/boot/grub/themes/elementaryOS"

# Leave nothing behind
rm -rf "/etc/default/grub.previous"
