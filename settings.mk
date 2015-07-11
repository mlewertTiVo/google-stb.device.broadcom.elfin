# define the following to force build output out of source tree.
#
#   specifies the root of the out folder location, final
#   output location will be <root>/$(notdir $(PWD)).
#
#   eg: 1) OUT_DIR_COMMON_BASE=/home/${USER}/android_build
#       2) source tree is /home/${USER}/android-X
#
#       location will be: /home/${USER}/android_build/android-X/...
#
#export OUT_DIR_COMMON_BASE=

export BCM_VENDOR_STB_ROOT ?= vendor/broadcom/stb

export NEXUS_PLATFORM=97439
export BCHP_VER=B0
export NEXUS_USE_7439_SFF=y
export PLATFORM=97439

export ANDROID := $(shell pwd)
export ANDROID_TOP := ${ANDROID}
export B_REFSW_ARCH := arm-linux
export B_REFSW_CROSS_COMPILE_PATH := ${ANDROID_TOP}/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8/bin
export B_REFSW_CROSS_COMPILE := ${B_REFSW_CROSS_COMPILE_PATH}/arm-linux-androideabi-
export B_REFSW_KERNEL_CROSS_COMPILE := arm-linux-
export B_REFSW_TOOLCHAIN_ARCH := arm-linux
export V3D_DEBUG ?= n

# TODO - remove need for this.
export BRCM_ANDROID_VERSION := l

export ANDROID_BUILD := y
export ANDROID_ENABLE_BTUSB ?= y
export ANDROID_ENABLE_HDMI_HDCP ?= n
export ANDROID_ENABLE_DHD ?= y
export ANDROID_SUPPORTS_DTVKIT := n
export BROADCOM_WIFI_CHIPSET := 43570a2
export BRCM_DHD_NVRAM_NAME := bcm43570_7252SSFF.nvm
export BROADCOM_DHD_SOURCE_PATH := ${ANDROID}/${BCM_VENDOR_STB_ROOT}/drivers/bcmdhd
export BCM_GPT_CONFIG_FILE := device/google/avko/makegpt.conf
export HLS_PROTOCOL_SUPPORT := y

export LINUXVER := 3.14.13
export LINUX := ${ANDROID_TOP}/kernel/private/bcm-97xxx/linux
export BCHP_VER_LOWER_LINUX_OVERRIDE :=

export NEXUS_ANDROID_SUPPORT := y
export NEXUS_MODE := proxy
export NEXUS_LOGGER_EXTERNAL := y
export NEXUS_PLATFORM_7241_WIFI := n
export NEXUS_POWER_MANAGEMENT := y
export NEXUS_REPLACE_BOILERPLATE := y
export NEXUS_SHARED_LIB := y
export NEXUS_HDMI_INPUT_SUPPORT := n
export PVR_SUPPORT := y
export REFSW_BASE_DIR := ${ANDROID}/${BCM_VENDOR_STB_ROOT}/refsw
export ROCKFORD := ${ANDROID}/${BCM_VENDOR_STB_ROOT}/refsw/rockford
export SHAREABLE := y
export SHELL := /bin/bash
export SMP := y
export SSL_SUPPORT := y
export LIVEMEDIA_SUPPORT := n

export ANDROID_SUPPORTS_WIDEVINE := y
export ANDROID_SUPPORTS_PLAYREADY := y
export ANDROID_ENABLE_HDMI_HDCP := y

ifneq ($(filter $(ANDROID_SUPPORTS_WIDEVINE) $(ANDROID_SUPPORTS_PLAYREADY) $(ANDROID_ENABLE_HDMI_HDCP),y),)
    export SAGE_SUPPORT=y
    export NEXUS_SECURITY_SUPPORT=y
    export KEYLADDER_SUPPORT=y
    export NEXUS_COMMON_CRYPTO_SUPPORT=y

    ifeq ($(ANDROID_ENABLE_HDMI_HDCP), y)
        export NEXUS_HDCP_SUPPORT=y
    endif

    ifneq ($(wildcard ${BCM_VENDOR_STB_ROOT}/bcm_platform/libsecurity/playreadydrmplugin),)
        ifeq ($(ANDROID_SUPPORTS_PLAYREADY), y)
            export MSDRM_PRDY_SUPPORT=y
            export MSDRM_PRDY_SDK_VERSION=2.5
        endif
    endif
endif

export USE_CCACHE := 1
export ANDROID_PRODUCT_OUT := avko
export NEXUS_USE_3461_FRONTEND_DAUGHTER_CARD := y
