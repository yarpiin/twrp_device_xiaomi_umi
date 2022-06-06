#
# Copyright (C) 2021 The TWRP Open-Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# The below variables will be generated automatically
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Release name
PRODUCT_RELEASE_NAME := umi
DEVICE_PATH := device/xiaomi/umi

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from device
$(call inherit-product, device/xiaomi/umi/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := umi
PRODUCT_NAME := twrp_umi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi10 5G
PRODUCT_MANUFACTURER := Xiaomi
