#!/bin/bash
# Arch Linux installation script (English version)

# Package sets
amd_pc="btop"
hp_notebook="fastfetch"

# Mount boot partition
read -p "Enter boot partition (e.g., /dev/sda1): " boot_efi
[ -z "$boot_efi" ] && { echo "Boot partition not specified!"; exit 1; }

mkdir -p /mnt/boot/efi
mount "$boot_efi" /mnt/boot/efi || { echo "Error mounting $boot_efi"; exit 1; }

echo "Checking partitions:"
lsblk | grep -v "loop"
sleep 3

# Install base packages
echo "Installing base packages..."
pacstrap -C /etc/pacman.conf -c /mnt \
    base base-devel linux linux-firmware \
    nano sudo git linux-headers reflector go \
    --needed --cachedir=/var/cache/pacman/pkg

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab || { echo "Failed to generate fstab"; exit 1; }

# Chroot section
arch-chroot /mnt /bin/bash <<'EOF'

# Явно запрашиваем имя пользователя ПЕРЕД chroot
echo "your nama:"
read username

# Проверяем, что имя не пустое
[ -z "$username" ] && { echo "paste something"; exit 1; }

# Создаём пользователя
useradd -m -G wheel -s /bin/bash "$username" || { echo "error user add "; exit 1; }

# Устанавливаем пароль
echo "Установите пароль для $username:"
passwd "$username" || { echo "Ошибка установки пароля"; exit 1; }
# Configure sudo
echo "Configuring sudo..."
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers || { echo "Failed to configure sudo"; exit 1; }

# Install yay
echo "Installing yay..."
sudo -u "$username" bash -c 'git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin &&
    cd /tmp/yay-bin &&
    makepkg -si --noconfirm' || { echo "Yay installation failed"; exit 1; }

# Configure locale
echo "Setting up locale..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen || { echo "Locale generation failed"; exit 1; }
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set root password
echo "Set root password:"
passwd || { echo "Failed to set root password"; exit 1; }

# Configure timezone
ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
hwclock --systohc

# Enable multilib
echo "Enabling multilib..."
sed -i '/^#\[multilib\]/{n;s/^#//;}' /etc/pacman.conf
sed -i 's/^#\[multilib\]/\[multilib\]/' /etc/pacman.conf
pacman -Sy || { echo "Repository update failed"; exit 1; }

# Package selection
echo "Select system type:"
echo "1) Laptop ($hp_notebook)"
echo "2) Desktop ($amd_pc)"

read -p "Your choice (1-2): " choice
case $choice in
    1) pacman -S --noconfirm $hp_notebook;;
    2) pacman -S --noconfirm $amd_pc;;
    *) echo "Invalid choice, skipping additional packages";;
esac

# Copy configs
echo "Copying configurations..."
sudo -u "$username" bash -c 'git clone https://github.com/flaemer/flaemer.git /tmp/repo_tmp &&
    cp -rn /tmp/repo_tmp/.config /home/'"$username"'/' ||
    echo "Warning: Failed to copy configs"

echo "Base installation complete!"
EOF
