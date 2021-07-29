#!/sbin/sh
#
# apex env install/uninstall
# for android-10.0+
#
# by wzsx150
# v1.1-20200219
#


TMP_DIR=/tmp
LOG_FILE=/tmp/recovery.log
CMD_INSTALL=0
CMD_UNINSTALL=0
CMD_UNKNOW=0


if [ -n "$1" ];then
  if [ "$1" = "install" ];then
    CMD_INSTALL=1
  elif [ "$1" = "uninstall" ];then
    CMD_UNINSTALL=1
  else
    CMD_UNKNOW=1
    echo "APEX: --- abort: Unknow argument"
    #echo "APEX: --- abort: Unknow argument" >> $LOG_FILE
    echo "APEX: Usage [ install | uninstall ]"
    #echo "APEX: Usage [ install | uninstall ]" >> $LOG_FILE
    sleep 0.2
    exit 1
  fi
else
  CMD_INSTALL=1
fi


ui_print() {
  if [ -n "$1" ]; then
    echo "APEX: $1"
    #echo "APEX: $1" >> $LOG_FILE
  fi
}

abort() {
  if [ "$1" ]; then
    ui_print "--- abort: $1"
  else
    ui_print "--- abort"
  fi
  umount /system
  umount /system_root
  umount /vendor
  sleep 0.4
  ui_print " "
  exit 1
}



is_twrp() {
  twrp_version=`getprop "ro.twrp.version"`
  if [ -n "$twrp_version" -a -f "/sbin/recovery" ]; then
    ui_print "- TWRP version: $twrp_version"
  else
    abort "Not TWRP mode"
  fi
}

is_android10up() {
  sys_release=`getprop "ro.build.version.release" | cut -d'.' -f1`
  if [ "$sys_release" -ge "10" ]; then
    ui_print "- System version: $sys_release"
  else
    abort "Not android-10.0+"
  fi
}

mount_parts() {
  ui_print "- Mounting /system and /vendor"
  mount -o ro /system_root
  mount -o ro /system
  mount -o ro /vendor
  sleep 0.2
  is_mount_system=`mount | grep "/system "`
  if [ -z "$is_mount_system" ]; then
    ##fix system_root path
    [ -d "/system_root" -a -d "/system" ] && {
      [ ! -L /system ] && mv -f /system /system_EFGHIJK
      [ ! -e /system ] && ln -s /system_root/system /system
    }
  fi
}

umount_parts() {
  ui_print "- Unmounting /system and /vendor"
  umount /system
  umount /system_root
  umount /vendor
  sleep 0.2
}

umount_loops() {
  ui_print "- Unmounting loop devices"
  for i in $(seq 0 20)
  do
    loop_file=`losetup -a | grep -m 1 apex_payload.img | cut -d':' -f1`
    [ -n "$loop_file" ] && {
      umount -l "$loop_file" && losetup -d "$loop_file"
      sleep 0.2
    }
  done
}

# mount_loop <img_file> <dir>
mount_loop() {
  if [ -n "$1" -a -f "$1" ]; then
    if [ -n "$2" ]; then
      img_file="$1"
      mount_point="$2"
      [ -d "$mount_point" ] || mkdir -p "$mount_point"

      loop_device=`losetup -f`
      [ -n "$loop_device" ] && {
        ui_print "- Mounting $loop_device on $mount_point"
        losetup "$loop_device" "$img_file"
        sleep 0.1
        mount -o ro "$loop_device" "$mount_point"
      }
    fi
  fi
}

uninstall_apex() {
  is_loops=`losetup -a | grep -m 1 apex_payload.img`
  [ -n "$is_loops" ] && umount_loops
  rm -rf /apex/com.android.runtime
  rm -rf /apex/com.android.tzdata
  rm -rf /apex/com.android.conscrypt
  rm -rf /tmp/apex
  sleep 0.2
}

preparing_apex() {
  ui_print "- Preparing apex files"
  runtime_apex=`ls -d /system/apex/com.*android.runtime*`
  tzdata_apex=`ls -d /system/apex/com.*android.tzdata*`
  conscrypt_apex=`ls -d /system/apex/com.*android.conscrypt*`
  mkdir -p /apex

  ## com.android.runtime
  if [ -d "$runtime_apex" ]; then
    cp -rf "$runtime_apex" /apex/com.android.runtime
  elif [ -f "$runtime_apex" ]; then
    mkdir -p /tmp/apex/com.android.runtime
    unzip "$runtime_apex" -d /tmp/apex/com.android.runtime
    mount_loop /tmp/apex/com.android.runtime/apex_payload.img /apex/com.android.runtime
  fi
  sleep 0.2

  ## com.android.tzdata
  if [ -d "$tzdata_apex" ]; then
    cp -rf "$tzdata_apex" /apex/com.android.tzdata
  elif [ -f "$tzdata_apex" ]; then
    mkdir -p /tmp/apex/com.android.tzdata
    unzip "$tzdata_apex" -d /tmp/apex/com.android.tzdata
    mount_loop /tmp/apex/com.android.tzdata/apex_payload.img /apex/com.android.tzdata
  fi
  sleep 0.2

  ## com.android.conscrypt
  if [ -d "$conscrypt_apex" ]; then
    cp -rf "$conscrypt_apex" /apex/com.android.conscrypt
  elif [ -f "$conscrypt_apex" ]; then
    mkdir -p /tmp/apex/com.android.conscrypt
    unzip "$conscrypt_apex" -d /tmp/apex/com.android.conscrypt
    mount_loop /tmp/apex/com.android.conscrypt/apex_payload.img /apex/com.android.conscrypt
  fi
  sleep 0.2
}




# start
ui_print " "
ui_print "********************************"
ui_print " apex env install/uninstall"
ui_print "     v1.1  by wzsx150   "
ui_print "********************************"


# first to uninstall
sleep 0.4
[ "$CMD_UNINSTALL" = "1" ] && {
  ui_print "- Uninstalling APEX env for TWRP"
}

[ "$CMD_INSTALL" = "1" ] && {
  ui_print "- Installing APEX env for TWRP"
}

uninstall_apex

[ "$CMD_UNINSTALL" = "1" ] && {
  ui_print "- Done"
  ui_print " "
  sleep 0.4

  exit 0
}

# second to install
sleep 0.4
is_twrp

is_android10up

mount_parts

preparing_apex

ui_print "- Done"
sleep 0.2

umount_parts

ui_print " "

exit 0



