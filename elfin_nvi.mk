# non-vendor-image layout: there is no separate partition for vendor.img in O+.
export LOCAL_NVI_LAYOUT          := y
export ANDROID_PRODUCT_OUT       := elfin_nvi

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early:root/fstab.elfin_nvi
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.nvi.conf

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin_nvi.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin_nvi.rc
LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_nvi.rc

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
$(call inherit-product, build/make/target/product/product_launched_with_n.mk)
PRODUCT_NAME                     := elfin_nvi
PRODUCT_MODEL                    := elfin_nvi
PRODUCT_BRAND                    := broadcom
PRODUCT_DEVICE                   := elfin_nvi

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES    += ro.hardware=elfin_nvi
TARGET_BOOTLOADER_BOARD_NAME := elfin_nvi
