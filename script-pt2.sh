#!/bin/bash

# Проверка на chroot (чтобы случайно не запустить вне chroot)
if ! grep -q '/mnt' /proc/mounts; then
    echo -e "\e[31mЭтот скрипт должен запускаться внутри chroot!\e[0m"
    exit 1
fi

### 1. Настройка времени (UTC+7)
echo -e "\e[32m[1] Настраиваю время (UTC+7)...\e[0m"
timedatectl set-timezone Asia/Novosibirsk
timedatectl set-ntp true
hwclock --systohc --utc

### 2. Включение multilib
echo -e "\e[32m[2] Включаю multilib...\e[0m"
sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
pacman -Sy

### 3. Создание пользователя
echo -e "\e[32m[3] Создаю пользователя...\e[0m"
read -p "Введите имя пользователя: " username
useradd -m -G wheel -s /bin/bash "$username"
echo -e "\e[33mЗадайте пароль для $username:\e[0m"
passwd "$username"

### 4. Настройка sudo
echo -e "\e[32m[4] Настраиваю sudo...\e[0m"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

### 5. Установка AUR-хелпера (yay)
echo -e "\e[32m[5] Устанавливаю yay...\e[0m"
pacman -S --noconfirm --needed go
sudo -u "$username" bash -c 'git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin && cd /tmp/yay-bin && makepkg -si --noconfirm'

### 6. Меню выбора пакетов
echo -e "\e[36m\nВыберите вариант установки:\e[0m"
echo "1) Минимальный набор (терминал)"
echo "2) Рабочий стол (XFCE)"
echo "3) Игровая конфигурация (Steam + Wine)"
read -p "Ваш выбор (1-3): " choice

case $choice in
    1)
        echo -e "\e[32mУстанавливаю терминальные утилиты...\e[0m"
        pacman -S --noconfirm fastfetch
        ;;
    2)
        echo -e "\e[32mУстанавливаю XFCE...\e[0m"
        pacman -S --noconfirm btop fastfetch
         ;;
    3)
        echo -e "\e[32mУстанавливаю Steam + Wine...\e[0m"
        pacman -S --noconfirm steam wine-staging lutris vulkan-intel lib32-vulkan-intel
        ;;
esac

echo -e "\e[32m\nУстановка завершена!\e[0m"
echo -e "Войдите под пользователем \e[33m$username\e[0m и используйте \e[33myay\e[0m для AUR."
