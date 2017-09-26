export ANDROID_PRODUCT_OUT       := elfin_mini

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:root/fstab.elfin_mini
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.conf

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin_mini.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin_mini.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block-zram.rc:root/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_mini.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block-zram.rc:root/init.recovery.block.rc # block devices

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=1024m@0m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=256m@736m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=224m@512m
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_hd.xml:system/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:system/etc/media_profiles.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance_mini.xml:system/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

LOCAL_DEVICE_DALVIK_CONFIG       := frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk
export LOCAL_DEVICE_DALVIK_CONFIG

export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay_mini

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
#$(call inherit-product, build/make/target/product/product_launched_with_n.mk)
PRODUCT_NAME                     := elfin_mini
PRODUCT_MODEL                    := elfin_mini
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin_mini

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES    += ro.hardware=elfin_mini
TARGET_BOOTLOADER_BOARD_NAME  := elfin_mini
