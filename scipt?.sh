#!/bin/bash

# Function to select partitions
select_partition() {
  local prompt=$1
  local mountpoint=$2
  local format=$3

  # Show available partitions
  echo -e "\nAvailable partitions:"
  lsblk -f | grep -v "loop"

  # Ask for partition selection
  read -p "$prompt (e.g. /dev/sda1): " partition

  # Verify partition exists
  if [ ! -b "$partition" ]; then
    echo "Error: Partition $partition doesn't exist!"
    exit 1
  fi

  # Formatting (if needed)
  if [ "$format" = "y" ]; then
    read -p "Format $partition? (y/N): " format_confirm
    if [ "$format_confirm" = "y" ]; then
      mkfs.fat -F32 "$partition"  # For EFI
    fi
  fi

  # Create mount point
  mkdir -p "/mnt$mountpoint"

  # Mount partition
  mount "$partition" "/mnt$mountpoint"
  echo "Mounted $partition at /mnt$mountpoint"
}

### Main Installation Script ###

# Mount root partition
select_partition "Select ROOT partition (for /)" "" "n"

# Mount EFI partition
select_partition "Select EFI partition (for /boot/efi)" "/boot/efi" "y"

# Optional home partition
read -p "Mount separate /home partition? (y/N): " home_confirm
if [ "$home_confirm" = "y" ]; then
  select_partition "Select HOME partition" "/home" "n"
fi

# Install base packages
echo -e "\nInstalling base packages..."
pacstrap /mnt base base-devel linux linux-firmware nano git linux-headers fastfetch

# Generate fstab
echo -e "\nGenerating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Download part 2 script
echo -e "\nDownloading part 2 script..."
curl -o /mnt/script-pt2.sh https://raw.githubusercontent.com/flaemer/flaemer/main/script-pt2.sh
chmod +x /mnt/script-pt2.sh

# Execute part 2 in chroot
echo -e "\nExecuting part 2 script in chroot..."
arch-chroot /mnt

echo -e "\nBase installation complete!"
