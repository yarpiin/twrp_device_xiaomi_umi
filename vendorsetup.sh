#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="umi"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TARGET_ARCH=arm64
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_NO_RELOAD_AFTER_DECRYPTION=1
    export FOX_DISABLE_APP_MANAGER=1
    export OF_MAINTAINER=yarpiin
    export FOX_VERSION=White_Wolf-A11
    export OF_PATCH_AVB20=1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"; # Tuesday, January 1, 2019 12:00:00 AM GMT+00:00
    export OF_CHECK_OVERWRITE_ATTEMPTS=1
    export OF_FBE_METADATA_MOUNT_IGNORE=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export FOX_ADVANCED_SECURITY=1
    export OF_NO_SAMSUNG_SPECIAL=1
    export FOX_INSTALLER_DEBUG_MODE=1
    export OF_USE_TWRP_SAR_DETECT=1
    export OF_TARGET_DEVICES=umi
    export OF_USE_GREEN_LED=0
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export OF_QUICK_BACKUP_LIST="/boot;/dtbo;"
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
    export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1

	# Let's see which are our build vars
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
