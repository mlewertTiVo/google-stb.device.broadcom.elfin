export LOCAL_PRODUCT_OUT       := elfin_l
export LOCAL_DEVICE_FULL_TREBLE  := y

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin_l/fstab/fstab.verity.early:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin_l/fstab/fstab.verity.early:root/fstab.elfin_l
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/default_v3.conf
export LOCAL_DEVICE_RECOVERY_LEGACY := 67108864 # 64M
export LOCAL_DEVICE_SYSTEM_LEGACY := 1602224128 # 1528M

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin_l.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin_l.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block.rc:root/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_l.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block.rc:root/init.recovery.block.rc # block devices

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=2008m@0m mem=32m@2016m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=532m@414m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=574m@948m
LOCAL_DEVICE_KERNEL_CMDLINE      += ramoops.mem_address=0x7D800000 ramoops.mem_size=0x800000 ramoops.console_size=0x400000
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_no_legacy_enc.xml:system/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:system/etc/media_profiles.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
$(call inherit-product, build/make/target/product/product_launched_with_n.mk)
PRODUCT_NAME                     := elfin_l
PRODUCT_MODEL                    := elfin_l
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin_l

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES    += ro.hardware=elfin_l
TARGET_BOOTLOADER_BOARD_NAME := elfin_l
