export ANDROID_PRODUCT_OUT       := elfin_mini

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early:root/fstab.elfin_mini
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.conf

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin_mini.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin_mini.rc
LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_mini.rc

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=1024m@0m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=224m@768m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=296m@472m
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

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
TARGET_BOOTLOADER_BOARD_NAME := elfin_mini
