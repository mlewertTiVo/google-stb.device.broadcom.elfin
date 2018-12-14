ifndef LOCAL_PRODUCT_OUT
export LOCAL_PRODUCT_OUT         := elfin
endif
export LOCAL_CFG_PROFILE         ?= default

ifeq ($(LOCAL_DEVICE_FORCED_NAB),y)
export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/nab.o.conf
LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
else
export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.o.conf
LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin
endif
export LOCAL_DEVICE_GPT_O_LAYOUT := y
export LOCAL_DEVICE_FSTAB

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.elfin.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block.rc:root/init.recovery.block.rc # block devices

# compile the media codecs for the device.
ifeq ($(HW_HVD_REDUX),y)
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_with_pip__no_legacy_enc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
else
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_no_legacy_enc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
endif
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, build/make/target/product/product_launched_with_o.mk)
$(call inherit-product, device/broadcom/common/bcm.mk)
PRODUCT_NAME                     := elfin
PRODUCT_MODEL                    := elfin
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196609 \
   ro.nx.mma=1 \
   ro.v3d.disable_buffer_age=true \
   \
   ro.nx.heap.video_secure=80m \
   ro.nx.heap.drv_managed=0m \
   ro.nx.heap.grow=2m \
   ro.nx.heap.shrink=2m \
   ro.nx.heap.gfx=64m \
   \
   ro.nx.capable.cb=1 \
   ro.nx.capable.bg=1 \
   ro.nx.hwc2.tweak.fbcomp=0 \
   ro.sf.lcd_density=320 \
   \
   ro.nx.eth.irq_mode_mask=3:2 \
   \
   ro.com.google.clientidbase=android-elfin-tv

# last but not least, include device flavor profile.
include device/broadcom/elfin/profiles/${LOCAL_CFG_PROFILE}.mk

TARGET_BOOTLOADER_BOARD_NAME  := elfin
