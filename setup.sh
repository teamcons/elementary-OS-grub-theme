#!/bin/bash


# Create theme folder
mkdir -v /boot/grub/themes

# Move theme there
cp -vri "eOS-grub-theme" /boot/grub/themes

# Link to it in config
echo "GRUB_THEME=/boot/grub/themes/eOS-grub-theme/theme.txt" >> /etc/default/grub

# Update grub configuration
update-grub
