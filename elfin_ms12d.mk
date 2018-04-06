export LOCAL_PRODUCT_OUT       := elfin_ms12d
export LOCAL_DEVICE_FULL_TREBLE  := y

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin_ms12d
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.o.conf
export LOCAL_DEVICE_GPT_O_LAYOUT := y

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.elfin_ms12d.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_ms12d.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block.rc:root/init.recovery.block.rc # block devices

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=2008m@0m mem=32m@2016m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=548m@398m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=574m@948m
LOCAL_DEVICE_KERNEL_CMDLINE      += ramoops.mem_address=0x7D800000 ramoops.mem_size=0x800000 ramoops.console_size=0x400000
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

# dolby MS12 config D
export BDSP_MS12_SUPPORT         := D

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_no_legacy_enc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
#$(call inherit-product, build/make/target/product/product_launched_with_o.mk)
PRODUCT_SHIPPING_API_LEVEL       := 26
PRODUCT_NAME                     := elfin_ms12d
PRODUCT_MODEL                    := elfin_ms12d
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin_ms12d

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.hardware=eelfin_ms12d \
   \
   ro.opengles.version=196609 \
   debug.hwui.render_dirty_regions=false \
   ro.nx.mma=1 \
   ro.v3d.disable_buffer_age=true \
   \
   ro.nx.heap.video_secure=80m \
   ro.nx.heap.main=112m \
   ro.nx.heap.drv_managed=0m \
   ro.nx.heap.grow=2m \
   ro.nx.heap.shrink=2m \
   ro.nx.heap.gfx=64m \
   \
   ro.nx.dolby.ms=12 \
   \
   ro.nx.capable.cb=1 \
   ro.nx.capable.bg=1 \
   ro.nx.hwc2.tweak.fbcomp=1 \
   ro.sf.lcd_density=320 \
   \
   ro.nx.eth.irq_mode_mask=3:2 \
   \
   ro.com.google.clientidbase=android-elfin-tv \
   ro.nrdp.modelgroup=ELFIN \
   ro.nrdp.validation=ninja_5.1

TARGET_BOOTLOADER_BOARD_NAME  := elfin_ms12d
