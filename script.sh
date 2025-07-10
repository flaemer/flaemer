#!/bin/bash
# Arch Linux installation script (English version)

# Package sets
amd_pc="base-devel linux-headers reflector"
hp_notebook="fastfetch"

# Mount boot partition
read -p "Enter boot partition (e.g., /dev/sda1): " boot_efi
if [ -z "$boot_efi" ]; then
    echo "Boot partition not specified!"
    exit 1
fi

sudo mkdir -p /mnt/boot/efi
sudo mount "$boot_efi" /mnt/boot/efi || { echo "Error mounting $boot_efi"; exit 1; }

echo "Checking partitions:"
lsblk | grep -v "loop"
sleep 3

# Install base packages
echo "Installing base packages..."
sudo pacstrap /mnt base base-devel linux linux-firmware nano git linux-headers reflector go || { echo "Package installation failed"; exit 1; }

# Generate fstab
echo "Generating fstab..."
sleep 2
sudo genfstab -U /mnt >> /mnt/etc/fstab || { echo "Failed to generate fstab"; exit 1; }

# Chroot section
sudo arch-chroot /mnt /bin/bash <<EOF
    # Create user
    echo "Creating user..."
    read -p "Enter username: " username
    useradd -m -G wheel,audio,video,storage,optical -s /bin/bash "\$username" || { echo "User creation failed"; exit 1; }
    echo "Set password for \$username"
    passwd "\$username"
    
    # Configure sudo
    echo "Configuring sudo..."
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers || { echo "Sudo configuration failed"; exit 1; }
    
    # Install yay
    echo "Installing yay..."
    sudo -u "\$username" bash -c 'git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin && cd ~/yay-bin && makepkg -si --noconfirm' || { echo "Yay installation failed"; exit 1; }
    
    # Configure locale
    echo "Setting up locale..."
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen || { echo "Locale generation failed"; exit 1; }
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    
    # Set root password
    echo "Set root password:"
    passwd || { echo "Failed to set root password"; exit 1; }
    
    # Configure timezone
    timedatectl set-timezone Asia/Novosibirsk || { echo "Timezone configuration failed"; exit 1; }
    
    # Enable multilib
    echo "Enabling multilib..."
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
    pacman -Sy || { echo "Repository update failed"; exit 1; }
    
    # Package selection
    echo "Select system type:"
    echo "1) Laptop ($hp_notebook)"
    echo "2) Desktop ($amd_pc)"
    
    read -p "Your choice (1-2): " choice
    case \$choice in
        1)
            echo "Installing laptop packages..."
            pacman -S --noconfirm $hp_notebook;;
        2)
            echo "Installing desktop packages..."
            pacman -S --noconfirm $amd_pc;;
        *)
            echo "Invalid choice, skipping additional packages";;
    esac
    
    # Copy configs
    echo "Copying configurations..."
    sudo -u "\$username" bash -c 'git clone https://github.com/flaemer/flaemer.git ~/repo_tmp && cp -rn ~/repo_tmp/.config /home/'\$username'/' || echo "Warning: Failed to copy configs"
    
    echo "Base installation complete!"
EOF

# Post-install notes
echo "After reboot remember to:"
echo "1. Enable network: sudo systemctl enable NetworkManager"
echo "2. Install graphical environment if needed"
