#!/sbin/sh
#
# TODO: this kludge is needed to prevent issues with mounting
# system and vendor in some zip installers and in the gui
#
sleep 1
mount -w /product > /dev/null
mount -w /vendor > /dev/null
mount -w /odm > /dev/null
mount -w /system_ext > /dev/null
mount -w /system_root > /dev/null

sleep 1
umount /product > /dev/null
umount /vendor > /dev/null
umount /odm > /dev/null
umount /system_ext > /dev/null
umount /system_root > /dev/null

sleep 1
mkdir /data/media
mkdir /data/media/0
mkdir /tmp/install
mkdir /tmp/install/bin

exit 0
#