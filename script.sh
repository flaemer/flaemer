!/bin/bash
#антиэто ну там вроде хз ну анти кто то
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    echo "интернет нада братанчик"
    exit 1
fi
### 1. Настройка системы
echo "установка базы"
pacstrap /mnt base base-devel linux linux-firmware networkmanager nano git linux-headers
### 2. Настройка пользователя ###
read -p "Введите имя пользователя: " username
useradd -m -G wheel,audio,video,storage,optical -s /bin/bash "$username"
echo "Установите пароль для $username:"
read -p "Введите пароль пользователя: " password
passwd "$password"
#для субо
read -sp "Введите пароль для субо братана: " rootpass
echo "root:$rootpass" | chpasswd
unset rootpass
### 3. Настройка sudo
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "все этот ну вот он $username создан и теперь тоже может юзать судо"
echo "я хз как мне лень виртуалку запусктаь пиши сам arch-chroot /mnt"
