# copyright 2015 - broadcom canada ltd.
#
# warning: auto-generated module, edit at your own risks...
#

# this configuration is for device avko

# start of refsw gathered configuration


export NEXUS_PLATFORM=97439
export BCHP_VER=B0
export NEXUS_USE_7439_SFF=y
export PLATFORM=97439

# end of refsw gathered config...

include device/broadcom/custom/97439B0SFF/root/pre_settings.mk
include device/broadcom/custom/97439B0SFF/SFFE/pre_settings.mk

# setup inheritance policy.
export LOCAL_RUN_TARGET := aosp

include device/broadcom/bcm_platform/bcm_platform.mk
include device/broadcom/custom/97439B0SFF/root/settings.mk

# SPOOF setting tweaks...
export LOCAL_DEVICE_KERNEL_CMDLINE := mem=768M@0x00000000 mem=512M@0x80000000 vmalloc=560M
export ANDROID_PRODUCT_OUT := avko

PRODUCT_NAME := aosp_avko
PRODUCT_DEVICE := avko
PRODUCT_MANUFACTURER := Google
PRODUCT_BRAND := Google

# exporting toolchains path for kernel image+modules
export PATH := ${ANDROID}/prebuilts/gcc/linux-x86/arm/stb/stbgcc-4.8-1.2/bin:${PATH}
