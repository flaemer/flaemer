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
passwd "$USERNAME"
echo "Configuring sudo..."
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers || { echo "Failed to configure sudo"; exit 1; }

#root passwor
echo "Set root password:"
passwd || { echo "Failed to set root password"; exit 1; }

#PACKAGES
case $choice in
    1) pacman -S $hp_notebook;;
    2) pacman -S  $amd_pc;;
    *) echo "Invalid choice, skipping additional packages";;
esac

# Install yay
echo "Installing yay..."
sudo -u "$USERNAME" bash -c 'git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin &&
    cd /tmp/yay-bin &&
    makepkg -si --noconfirm' || { echo "Yay installation failed"; exit 1; }

# Configure locale
echo "Setting up locale..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen || { echo "Locale generation failed"; exit 1; }
echo "LANG=en_US.UTF-8" > /etc/locale.conf


# Configure timezone
ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
hwclock --systohc

# Enable multilib
echo "Enabling multilib..."
sed -i '/^#\[multilib\]/{n;s/^#//;}' /etc/pacman.conf
sed -i 's/^#\[multilib\]/\[multilib\]/' /etc/pacman.conf
pacman -Sy || { echo "Repository update failed"; exit 1; }

# Copy configs
echo "Copying configurations..."
sudo -u "$USERNAME" bash -c 'git clone https://github.com/flaemer/flaemer.git /tmp/repo_tmp &&
    cp -rn /tmp/repo_tmp/.config /home/'"$USERNAME"'/' ||
    echo "Warning: Failed to copy configs"
echo "Base installation complete!"
EOF
