#!/bin/bash
#base
echo -e "bazovie i fastfetch poxvastatsya"
pacstrap /mnt base base-devel linux linux-firmware nano git linux-headers fastfetch
#fstab?
echo -e "fstabchick"
genfstab -U /mnt >> /mnt/etc/fstab
#pt2
echo -e "pt2.dowlanding"
curl -o /mnt/script-pt2.sh https://raw.githubusercontent.com/flaemer/flaemer/main/script-pt2.sh
chmod +x /mnt/script-pt2.sh
#end?
echo -e "baza ended"
arch-chroot /mnt
bash script-pt2.sh
