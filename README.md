# android_device_xiaomi_umi
For building TWRP for Xiaomi Mi 10

TWRP device tree for Xiaomi Mi 10

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

First checkout minimal twrp with aosp tree:

```
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/umi" name="yarpiin/twrp_device_xiaomi_umi" remote="github" revision="android-11.0" />
```

Finally execute these:

```
. build/envsetup.sh
lunch twrp_umi-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.
```

To test it:

```
fastboot boot out/target/product/umi/recovery.img
```

## Other Sources

Tree use pre-compiled kernel - https://github.com/yarpiin/White-Wolf-UMI-UNI
