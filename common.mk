# mandatory device configuration.
export LOCAL_ARM_AARCH64         := y
export LOCAL_ARM_AARCH64_NOT_ABI_COMPATIBLE := y
export NEXUS_PLATFORM            := 97260
export BCHP_VER                  := A0
export PLATFORM                  := 97260

# binary distribution
export BCM_BINDIST_BL_ROOT       := vendor/broadcom/prebuilts/bootloaders/elfin
export BCM_BINDIST_LIBS_ROOT     := vendor/broadcom/prebuilts/nximg/4.1/elfin
export BCM_BINDIST_KNL_ROOT      := device/broadcom/elfin-kernel/4.1

# compile the rc's for the device.
ifeq ($(LOCAL_DEVICE_FULL_TREBLE),y)
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.ft.mmu.nx.rc:root/init.nx.rc
else
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.mmu.nx.rc:root/init.nx.rc
endif
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.fs.verity.rc:root/init.fs.rc   # verity
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.eth.eth0.rc:root/init.eth.rc   # uses 'eth0'
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.bcm.usb.rc:root/init.bcm.usb.rc # uses 'configfs'
export LOCAL_DEVICE_RCS

LOCAL_DEVICE_RECOVERY_RCS        += device/broadcom/elfin/rcs/init.recovery.usb.rc:root/init.recovery.usb.rc # uses 'configfs'
export LOCAL_DEVICE_RECOVERY_RCS

ifeq ($(HW_AB_UPDATE_SUPPORT),y)
LOCAL_DEVICE_RECOVERY_FSTAB      := device/broadcom/common/recovery/fstab.ab-update/recovery.fstab
else
LOCAL_DEVICE_RECOVERY_FSTAB      := device/broadcom/common/recovery/fstab.default/recovery.fstab
endif
export LOCAL_DEVICE_RECOVERY_FSTAB

# optional device override/addition.
ifeq ($(HW_AB_UPDATE_SUPPORT),y)
LOCAL_DEVICE_SEPOLICY_BLOCK      := device/broadcom/elfin/sepolicy/block
ifeq ($(LOCAL_DEVICE_FULL_TREBLE),y)
LOCAL_DEVICE_SEPOLICY_BLOCK      += device/broadcom/elfin/sepolicy/treble
endif
else
LOCAL_DEVICE_SEPOLICY_BLOCK      := device/broadcom/elfin/sepolicy-v2/block
ifeq ($(LOCAL_DEVICE_FULL_TREBLE),y)
LOCAL_DEVICE_SEPOLICY_BLOCK      += device/broadcom/elfin/sepolicy-v2/treble
endif
endif
export LOCAL_DEVICE_SEPOLICY_BLOCK
export LOCAL_DEVICE_AON_GPIO     := device/broadcom/elfin/aon_gpio.cfg:$(TARGET_COPY_OUT_VENDOR)/power/aon_gpio.cfg
export LOCAL_DEVICE_KEY_POLL     := device/broadcom/common/keylayout/gpio_keys_polled.kl:system/usr/keylayout/gpio_keys_polled.kl
export LOCAL_DEVICE_BT_CONFIG    := device/broadcom/elfin/bluetooth/vnd_elfin.txt
ifneq ($(LOCAL_DEVICE_GPT_O_LAYOUT),y)
export LOCAL_DEVICE_USERDATA     := 5368709120  # 5.0009GB.
else
export LOCAL_DEVICE_USERDATA     := 4294967296  # 4GB.
endif
export HW_ENCODER_SUPPORT        := n
export BT_RFKILL_SUPPORT         := y
export LOCAL_SYSTEMIMAGE_SQUASHFS := n
export LOCAL_VENDORIMAGE_SQUASHFS := n
export ANDROID_ENABLE_BT         := usb
export V3D_VARIANT               := vc5
export LOCAL_DEVICE_REFERENCE_BUILD := device/broadcom/elfin/reference_build.mk
export LOCAL_DEVICE_USE_VERITY   := y
export LOCAL_DEVICE_SYSTEM_VERITY_PARTITION := /dev/block/platform/rdb/f0200200.sdhci/by-name/system
export LOCAL_DEVICE_VENDOR_VERITY_PARTITION := /dev/block/platform/rdb/f0200200.sdhci/by-name/vendor

# bootloader firmware manipulation.
export LOCAL_DEVICE_SAGE_DEV_N_PROD := y
export BOLT_IMG_SWAP_BBL            := device/broadcom/elfin/blb/zb/bbl-3.1.1-zb.bin
export BOLT_IMG_SWAP_BFW            := device/broadcom/elfin/blb/zb/bfw-4.2.5-zb.bin

# no legacy decoder (vp8, h263, mpeg4) in hardware s.1
export HW_HVD_REVISION           := S
# v3d mmu available.
export HW_GPU_MMU_SUPPORT        := y
