# android_device_xiaomi_umi
For building OrangeFox Recovery for Xiaomi Mi 10

OrangeFox Recovery device tree for Xiaomi Mi 10

All blobs are extracted from ()miui_UMI_V12.5.10.0.RJBCNXM) firmware.

The Xiaomi Mi 10 (codenamed _"umi"_) is high-end smartphone from Xiaomi.

Xiaomi Mi 10 / 10 Pro was announced and released in February 2020.

## Device specifications

| Device       | Xiaomi Mi 10                                |
| -----------: | :------------------------------------------ |
| SoC          | Qualcomm SM8250 Snapdragon 865              |
| CPU          | 8x Qualcomm® Kryo™ 585 up to 2.84GHz        |
| GPU          | Adreno 630                                  |
| Memory       | 8GB / 12GB RAM (LPDDR5)                     |
| Shipped Android version | 10                               |
| Storage      | 128GB / 256GB / 512GB UFS 3.0 flash storage |
| Battery      | Non-removable Li-Po 4780mAh                 |
| Dimensions   | 162.58 x 74.8 x 8.96 mm                     |
| Display      | 2340 x 1080 (19.5:9), 6.67 inch             |

## Device picture

![Xiaomi Mi 10](https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1581494372.61732687.jpg)

## Features

Works:

- [X] ADB
- [X] Decryption of /data (Android 11 only!!))
- [X] Screen brightness settings
- [X] Vibration support
- [X] MTP
- [X] Flashing (opengapps, roms, images and so on)
- [X] USB OTG
- [X] Fasbootd
- [X] Sideload (adb sideload update.zip)
- [X] Reboot to bootloader/recovery/system/fasbootd
- [X] F2FS/EXT4 Support, exFAT/NTFS where supported

## Compile

First checkout minimal OrangeFox Recovery with aosp tree:

mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
  git clone https://gitlab.com/OrangeFox/sync.git (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
  cd ~/OrangeFox_sync/sync/
  ./orangefox_sync.sh --branch 11.0 --path ~/fox_11.0

Then You have to place your device trees, kernels in the proper locations.

path="device/xiaomi/umi" name="yarpiin/twrp_device_xiaomi_umi" remote="github" revision="OrangeFox" />


Finally execute these:

cd ~/OrangeFox # (or whichever directory has the synced manifest)
    source build/envsetup.sh
  export ALLOW_MISSING_DEPENDENCIES=true
  export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
  export LC_ALL="C"

  lunch twrp_umi-eng && mka recoveryimage


## Other Sources

Tree use pre-compiled kernel - https://github.com/yarpiin/White-Wolf-UMI-UNI
