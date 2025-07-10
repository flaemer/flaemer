#!/bin/bash
# reflector yeye
reflector --country Russia --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
# Package sets
amd_pc="btop"
hp_notebook="fastfetch"

# Mount boot razdel
read -p "Enter boot partition (e.g., /dev/sda1): " boot_efi
[ -z "$boot_efi" ] && { echo "Boot partition not specified!"; exit 1; }

mkdir -p /mnt/boot/efi
mount "$boot_efi" /mnt/boot/efi || { echo "Error mounting $boot_efi"; exit 1; }

echo "Checking partitions:"
lsblk | grep -v "loop"
sleep 2

# Install base packages
echo "Installing base packages..."
pacstrap /mnt base base-devel linux linux-firmware nano sudo git linux-headers reflector go

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab || { echo "Failed to generate fstab"; exit 1; }
read -p "your name: " USERNAME
# Package selection
echo "Select system type:"
echo "1) Laptop ($hp_notebook)"
echo "2) Desktop ($amd_pc)"

read -p "Your choice (1-2): " choice

# Chroot section
arch-chroot /mnt /bin/bash <<EOF

#user
GROUPS="wheel,audio,video,storage"
useradd -m -G "$GROUPS" -s /bin/bash "$USERNAME" 2>/dev/null
echo "Configuring sudo..."
echo "$USERNAME ALL=(ALL:ALL) ALL" >> /etc/sudoers || { echo "Failed to configure sudo"; exit 1; }

#еще рандомное хз я заебался
echo "[multilib] >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen

#yay bro
mkdir /home/$USERNAME/yay-bin
yay="yay-bin"
git clone https://aur.archlinux.org/yay-bin.git ~/$yay &&
cd ~/yay &&
makepkg -si --noconfirm'
    
#PACKAGES
case $choice in
    1) pacman -S $hp_notebook;;
    2) pacman -S  $amd_pc;;
    *) echo "Invalid choice, skipping additional packages";;
esac

# Copy configs
echo "Copying configurations..."
sudo -u "$USERNAME" bash -c 'git clone https://github.com/flaemer/flaemer.git /tmp/repo_tmp &&
    cp -rn /tmp/repo_tmp/.config /home/'"$USERNAME"'/' ||
    echo "Warning: Failed to copy configs"
echo "Base installation complete!"
EOF
