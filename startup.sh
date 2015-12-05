mkdir /app
mount  /dev/vg_data/lv_data_other /app
echo "/dev/vg_data/lv_data_other /app                       ext4    defaults        1 1" >> /etc/fstab
