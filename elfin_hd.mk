ifndef LOCAL_PRODUCT_OUT
export LOCAL_PRODUCT_OUT         := elfin_hd
endif
export LOCAL_DEVICE_FULL_TREBLE  := y

LOCAL_DEVICE_FSTAB               := device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/elfin/fstab/fstab.verity.ab-update.early.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.elfin_hd
export LOCAL_DEVICE_FSTAB

export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.o.conf
export LOCAL_DEVICE_GPT_O_LAYOUT := y

LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.elfin_hd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block-zram.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.block.rc # block devices

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin_hd.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block-zram.rc:root/init.recovery.block.rc # block devices

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=1000m@0m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=180m@812m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=142m@670m
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
LOCAL_DEVICE_KERNEL_CMDLINE      += vmalloc=320m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcmv3d.ignore_cma=1
export LOCAL_DEVICE_KERNEL_CMDLINE

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_hd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/elfin/media_codecs_performance_hd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

LOCAL_DEVICE_DALVIK_CONFIG       := device/broadcom/elfin/elfin_fhd/dalvik-heap.mk
export LOCAL_DEVICE_DALVIK_CONFIG

export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay_hd

# common to all elfin devices.
include device/broadcom/elfin/common.mk

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
#$(call inherit-product, build/make/target/product/product_launched_with_o_mr1.mk)
PRODUCT_SHIPPING_API_LEVEL       := 27
PRODUCT_NAME                     := elfin_hd
PRODUCT_MODEL                    := elfin_hd
PRODUCT_BRAND                    := google
PRODUCT_DEVICE                   := elfin_hd

PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK   := true

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.hardware=elfin_hd \
   \
   ro.opengles.version=196609 \
   ro.nx.mma=1 \
   ro.v3d.disable_buffer_age=true \
   \
   ro.nx.heap.video_secure=30m \
   ro.nx.heap.main=66m \
   ro.nx.heap.drv_managed=0m \
   ro.nx.heap.grow=8m \
   ro.nx.heap.gfx=0m \
   ro.nx.heap.gs=0 \
   \
   ro.nx.capable.cb=1 \
   ro.nx.capable.bg=1 \
   ro.nx.hwc2.tweak.fbcomp=1 \
   ro.nx.hwc2.tweak.fbs=2 \
   ro.nx.hwc2.gfb.w=1280 \
   ro.nx.hwc2.gfb.h=720 \
   ro.nx.hwc2.nfb.w=1280 \
   ro.nx.hwc2.nfb.h=720 \
   ro.sf.lcd_density=213 \
   \
   ro.nx.trim.4kdec=1 \
   ro.nx.trim.10bcol=1 \
   ro.nx.trim.d0hd=1 \
   ro.nx.trim.deint=1 \
   \
   ro.nx.eth.irq_mode_mask=3:2 \
   \
   ro.com.google.clientidbase=android-elfin-tv \
   \
   ro.config.low_ram=true \
   ro.lmk.low=800 \
   ro.lmk.medium=600 \
   ro.lmk.critical=-700 \
   ro.lmk.kill_heaviest_task=true \
   ro.lmk.kill_timeout_ms=0 \
   ro.lmk.critical_upgrade=true \
   ro.lmk.upgrade_pressure=40 \
   ro.lmk.downgrade_pressure=60 \
   \
   pm.dexopt.shared=quicken \
   \
   ro.nx.audio.pbkfifosz=48k

TARGET_BOOTLOADER_BOARD_NAME  := elfin_hd
