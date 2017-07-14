export ANDROID_PRODUCT_OUT       := elfin

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.squashfs.ab-update.early:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.squashfs.ab-update.early:root/fstab.elfin
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.conf

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin.rc
LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin.rc

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
PRODUCT_NAME                     := elfin
PRODUCT_MODEL                    := elfin
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES    += ro.hardware=elfin
PRODUCT_PROPERTY_OVERRIDES    += ro.product.board=elfin
