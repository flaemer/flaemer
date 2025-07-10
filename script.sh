#!/bin/bash
#наборчики пакетов
amd_pc="idk"
hp_notebook="idk"
#base шооооооо яйки шо я делаю диск наверн
read -p "boot razdel" boot_efi
if [ -z "$boot_efi" ]; then
    echo "tebe nado razdel mraz"
    exit 1
fi
mkdir -p /mnt/boot/efi
mount "$boot_efi" /mnt/boot/efi || { echo "xz ya neznayo"; exit 1; }
lsblk | grep -v "loop"
sleep 15 #zzzzz сон
#это ну пакеты нада да
echo -e "bazovie i fastfetch poxvastatsya"
pacstrap /mnt base base-devel linux linux-firmware nano git linux-headers reflector go
#fstab?
echo  "fstabchick"
sleep 5
genfstab -U /mnt >> /mnt/etc/fstab
#end?
arch-chroot /mnt <<EOF
  #сам юзер
  echo "user?"
read -p "twoy imya: " username
useradd -m -G wheel,audio,video,storage,optical -s /bin/bash "$username"
echo "tvoy parol dlya $username"
passwd "$username"
#в субо добавляется
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
#йау
sudo -u "$username" bash -c 'git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin && cd ~/yay-bin && makepkg -si --noconfirm'
#не клонируется в home в папку /tmp пакет yay-bin или в директорию /tmp/yay-bin
  # локалька
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen
  echo "LANG=en_US.UTF-8" > /etc/locale.conf
  #пароль руту этому да
  echo "pishi davai:"
  passwd
  #еще настройка
  timedatectl set-timezone Asia/Novosibirsk

  #мультилиб
  echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
  pacman -Sy
  #это выборочная короче ноут или пк пакетики то какие будут
  echo "1) notebook($hp_notebook)"
echo "2) computer($amd_pc"
read -p "hp or pc?: " choice
  case $choice in
    1)
        echo -e "notebook"
        pacman -S --noconfirm $hp_notebook;;
    2)
        echo "computer"
        pacman -S --noconfirm $amd_pc;;
esac
#что бы еще сюда добавить а ну эм блин это да ну лан это поставлю grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
#добавки
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 nowatchdog"/' /etc/default/grub
echo "GRUB_COLOR_NORMAL=\"light-blue/black\"" >> /etc/default/grub
echo "GRUB_COLOR_HIGHLIGHT=\"light-cyan/blue\"" >> /etc/default/grub
#сборка или шо то там ну грабчик
grub-mkconfig -o /boot/grub/grub.cfg
EOF
