export LOCAL_PRODUCT_OUT         := elfin_fhd
export LOCAL_DEVICE_FULL_TREBLE  := y

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin_fhd
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.o.conf
export LOCAL_DEVICE_GPT_O_LAYOUT := y

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.elfin_fhd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block-zram.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_fhd.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block-zram.rc:root/init.recovery.block.rc # block devices

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=992m@0m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=314m@678m
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_hd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance_hd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

LOCAL_DEVICE_DALVIK_CONFIG       := frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk
export LOCAL_DEVICE_DALVIK_CONFIG

export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay_hd

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
#$(call inherit-product, build/make/target/product/product_launched_with_o_mr1.mk)
PRODUCT_SHIPPING_API_LEVEL       := 27
PRODUCT_NAME                     := elfin_fhd
PRODUCT_MODEL                    := elfin_fhd
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin_fhd

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.hardware=elfin_fhd \
   \
   ro.opengles.version=196609 \
   debug.hwui.render_dirty_regions=false \
   ro.nx.mma=1 \
   ro.v3d.disable_buffer_age=true \
   \
   ro.nx.heap.video_secure=56m \
   ro.nx.heap.main=56m \
   ro.nx.heap.drv_managed=0m \
   ro.nx.heap.gfx=128m \
   \
   ro.nx.capable.cb=1 \
   ro.nx.capable.bg=1 \
   ro.nx.hwc2.tweak.fbcomp=1 \
   ro.sf.lcd_density=320 \
   \
   ro.nx.trim.4kdec=1 \
   ro.nx.trim.10bcol=1 \
   ro.nx.trim.d0hd=1 \
   ro.nx.trim.deint=1 \
   \
   ro.nx.eth.irq_mode_mask=3:2 \
   \
   ro.com.google.clientidbase=android-elfin-tv \
   ro.nrdp.modelgroup=ELFIN \
   ro.nrdp.validation=ninja_5.1 \
   \
   ro.config.low_ram=true

TARGET_BOOTLOADER_BOARD_NAME  := elfin_fhd
