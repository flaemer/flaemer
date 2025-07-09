#!/bin/bash
### 2. Установка базовой системы
echo -e "\e[32m[2] Устанавливаю базовые пакеты...\e[0m"
pacstrap /mnt base base-devel linux linux-firmware nano git linux-headers

### 3. Генерация fstab
echo -e "\e[32m[3] Генерирую fstab...\e[0m"
genfstab -U /mnt >> /mnt/etc/fstab

### 4. Копируем часть 2 скрипта в /mnt
echo -e "\e[32m[4] Готовлю часть 2 для chroot...\e[0m"
curl -o /mnt/script-2.sh https://raw.githubusercontent.com/flaemer/flaemer/script-2.sh
chmod +x /mnt/script-2.sh

echo -e "\e[32m\nБазовая установка завершена!\e[0m"
echo -e "Перейдите в chroot и запустите часть 2:"
echo -e "  arch-chroot /mnt"
echo -e "  ./script-2.sh"
