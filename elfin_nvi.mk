# non-vendor-image layout: there is no separate partition for vendor.img in O+.
export LOCAL_NVI_LAYOUT          := y
export LOCAL_PRODUCT_OUT       := elfin_nvi

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin_nvi
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.nvi.conf

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.elfin_nvi.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_nvi.rc
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

export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay

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
