#
# Copyright (C) 2021 The TWRP Open-Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),umi)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

# Hack some props to allow stock ROM flashing
BOARD_RECOVERY_IMAGE_PREPARE := \
    sed -i 's/ro.product.board=.*/ro.product.board=umi/' $(TARGET_RECOVERY_ROOT_OUT)/prop.default; \
    sed -i 's/ro.bootimage.build.date.utc=.*/ro.bootimage.build.date.utc=0/' $(TARGET_RECOVERY_ROOT_OUT)/prop.default; \
    sed -i 's/ro.build.date.utc=.*/ro.build.date.utc=0/' $(TARGET_RECOVERY_ROOT_OUT)/prop.default;
endif
