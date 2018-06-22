# mandatory device configuration.
export LOCAL_ARM_AARCH64         := y
export LOCAL_ARM_AARCH64_NOT_ABI_COMPATIBLE := y
export NEXUS_PLATFORM            := 97260
export BCHP_VER                  := A0
export PLATFORM                  := 97260
export BOLT_BOARD_VB             := BCM972604USFF

# binary distribution
export BCM_DIST_FORCED_BINDIST   := y
export BCM_BINDIST_BL_ROOT       := vendor/broadcom/prebuilts/bootloaders/elfin
ifeq ($(BDSP_MS12_SUPPORT),D)
export BCM_BINDIST_LIBS_ROOT     := vendor/broadcom/prebuilts/nximg/4.9/elfin-ms12d
export BCM_BINDIST_KNL_ROOT      := device/broadcom/elfin-kernel/4.9-ms12d
else
export BCM_BINDIST_LIBS_ROOT     := vendor/broadcom/prebuilts/nximg/4.9/elfin
export BCM_BINDIST_KNL_ROOT      := device/broadcom/elfin-kernel/4.9
endif

# compile the rc's for the device.
ifeq ($(LOCAL_DEVICE_FULL_TREBLE),y)
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.ft.mmu.nx.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.nx.rc
else
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.mmu.nx.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.nx.rc
endif
LOCAL_DEVICE_RCS                 += device/broadcom/common/rcs/init.fs.verity.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.fs.rc   # verity
LOCAL_DEVICE_RCS                 += device/broadcom/elfin/rcs/init.bcm.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.bcm.usb.rc # uses 'configfs'
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
else
LOCAL_DEVICE_SEPOLICY_BLOCK      := device/broadcom/elfin/sepolicy-v2/block
endif
ifeq ($(LOCAL_DEVICE_FULL_TREBLE),y)
LOCAL_DEVICE_SEPOLICY_BLOCK      += device/broadcom/elfin/sepolicy/treble
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
ifeq (${LOCAL_ARM_AARCH64_COMPAT_32_BIT},y)
export LOCAL_DEVICE_BOOT         := 67108864   # 64M
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

# TODO: fix up the zd|zb use case.
export LOCAL_DEVICE_PAK_BINARY      := pak.72604.zd.bin

# no legacy decoder (vp8, h263, mpeg4) in hardware s.1
export HW_HVD_REVISION           := S
# v3d mmu available.
export HW_GPU_MMU_SUPPORT        := y

