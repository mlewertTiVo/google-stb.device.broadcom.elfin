# mandatory device configuration.
export LOCAL_ARM_AARCH64         := y
export LOCAL_ARM_AARCH64_NOT_ABI_COMPATIBLE := y
export NEXUS_PLATFORM            := 97260
export BCHP_VER                  := A0
export PLATFORM                  := 97260
export ANDROID_PRODUCT_OUT       := elfin

# compile the rc's for the device.
LOCAL_DEVICE_RCS                 := device/broadcom/common/rcs/init.rc:root/init.elfin.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.nx.rc:root/init.nx.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/ueventd.rc:root/ueventd.elfin.rc
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.fs.verity.rc:root/init.fs.rc  # verity
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.eth.eth0.rc:root/init.eth.rc   # uses 'eth0'
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.block.rc:root/init.block.rc   # block devices
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.bcm.usb.rc:root/init.bcm.usb.rc   # uses 'configfs'
export LOCAL_DEVICE_RCS

LOCAL_DEVICE_RECOVERY_RCS        := device/broadcom/common/rcs/init.recovery.rc:root/init.recovery.elfin.rc
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.block.rc:root/init.recovery.block.rc   # block devices
LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.recovery.usb.rc:root/init.recovery.usb.rc   # uses 'configfs'
export LOCAL_DEVICE_RECOVERY_RCS

LOCAL_DEVICE_FSTAB               := device/broadcom/common/fstab/fstab.verity.squashfs.ab-update:root/fstab.bcm
LOCAL_DEVICE_FSTAB               += device/broadcom/common/fstab/fstab.verity.squashfs.ab-update:root/fstab.elfin
export LOCAL_DEVICE_FSTAB

LOCAL_DEVICE_RECOVERY_FSTAB      := device/broadcom/common/recovery/fstab.ab-update/recovery.fstab
export LOCAL_DEVICE_RECOVERY_FSTAB

# compile the media codecs for the device.
LOCAL_DEVICE_MEDIA               := device/broadcom/common/media/media_codecs_no_legacy_enc.xml:system/etc/media_codecs.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_profiles.xml:system/etc/media_profiles.xml
LOCAL_DEVICE_MEDIA               += device/broadcom/common/media/media_codecs_performance_no_legacy_enc.xml:system/etc/media_codecs_performance.xml
export LOCAL_DEVICE_MEDIA

# optional device override/addition.
export LOCAL_DEVICE_OVERLAY      := device/broadcom/elfin/overlay
export LOCAL_DEVICE_SEPOLICY_BLOCK := device/broadcom/elfin/sepolicy-block
export LOCAL_DEVICE_AON_GPIO     := device/broadcom/elfin/aon_gpio.cfg:system/vendor/power/aon_gpio.cfg
export LOCAL_DEVICE_KEY_POLL     := device/broadcom/common/keylayout/gpio_keys_polled.kl:system/usr/keylayout/gpio_keys_polled_5.kl
export LOCAL_DEVICE_BT_CONFIG    := device/broadcom/elfin/bluetooth/vnd_elfin.txt
export LOCAL_DEVICE_USERDATA     := 5927582720 # ~5.52GB
export LOCAL_DEVICE_GPT          := device/broadcom/common/gpts/ab-u.conf
export HW_ENCODER_SUPPORT        := n
export BT_RFKILL_SUPPORT         := y
export LOCAL_SYSTEMIMAGE_SQUASHFS := y
export ANDROID_ENABLE_BT         := usb
export LOCAL_KCONFIG_CHIP_OVERRIDE := 7271A0
export V3D_VARIANT               := vc5
export LOCAL_DEVICE_REFERENCE_BUILD := device/broadcom/elfin/reference_build.mk
export HW_AB_UPDATE_SUPPORT      := y
export LOCAL_DEVICE_USE_VERITY   := y
export PRODUCT_AAPT_PREF_CONFIG  := hdpi

# no legacy decoder (vp9, h263, mpeg4) in hardware s.1
export HW_DECODER_LEGACY_SUPPORT := n
# v3d mmu available.
export HW_GPU_MMU_SUPPORT        := y

# kernel command line.
LOCAL_DEVICE_KERNEL_CMDLINE      := mem=2040m@0m
LOCAL_DEVICE_KERNEL_CMDLINE      += bmem=528m@1512m
LOCAL_DEVICE_KERNEL_CMDLINE      += brcm_cma=744m@768m
LOCAL_DEVICE_KERNEL_CMDLINE      += ramoops.mem_address=0x7F800000 ramoops.mem_size=0x800000 ramoops.console_size=0x400000
LOCAL_DEVICE_KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE

# baseline the common support.
$(call inherit-product, device/broadcom/common/bcm.mk)
PRODUCT_NAME                     := elfin
PRODUCT_MODEL                    := elfin
PRODUCT_BRAND                    := broadcom
PRODUCT_DEVICE                   := elfin

# additional setup per device.
PRODUCT_PROPERTY_OVERRIDES    += ro.hardware=elfin
PRODUCT_PROPERTY_OVERRIDES    += ro.product.board=elfin
