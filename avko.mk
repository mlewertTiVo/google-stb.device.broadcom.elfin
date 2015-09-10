#
# Copyright 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# It is required to build the Kernel from source.
KERNEL_SRC_DIR ?= kernel/private/bcm-97xxx/linux
ifeq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
  $(error Unable to build kernel from source, aborting.)
endif

# standard target - based on the standard google atv device if present,
#                   otherwise fallback (note pdk device is not atv based in
#                   particular since device/google/atv is not part of pdk).
ifeq (,$(LOCAL_RUN_TARGET))
  ifneq ($(wildcard $(TOPDIR)device/google/atv/tv_core_hardware.xml),)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)
    $(call inherit-product-if-exists, $(TOPDIR)device/google/atv/products/atv_base.mk)
  else
    $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
    PRODUCT_COPY_FILES += $(TOPDIR)device/google/avko/tv_core_hardware.xml:system/etc/permissions/tv_core_hardware.xml
  endif
  $(call inherit-product-if-exists, $(TOPDIR)vendor/google/products/gms.mk)
endif
# aosp - inherit from AOSP-BASE, not ATV.
ifeq ($(LOCAL_RUN_TARGET),aosp)
  PRODUCT_COPY_FILES += $(TOPDIR)device/google/avko/tv_core_hardware.xml:system/etc/permissions/tv_core_hardware.xml
  $(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
  $(call inherit-product-if-exists, $(TOPDIR)vendor/google/products/gms.mk)
endif

include device/google/avko/settings.mk

ifeq ($(TARGET_BUILD_VARIANT),user)
  export B_REFSW_DEBUG ?= n
  export B_REFSW_DEBUG_LEVEL :=
else
  export B_REFSW_DEBUG ?= y
  export B_REFSW_DEBUG_LEVEL := msg
endif

ifneq ($(wildcard device/google/atv/tv_core_hardware.xml),)
  # purposefully swap overlay layout to override some settings from
  # the ATV setup.
  DEVICE_PACKAGE_OVERLAYS := device/google/avko/overlay
  DEVICE_PACKAGE_OVERLAYS += device/google/atv/overlay
else
  DEVICE_PACKAGE_OVERLAYS += device/google/avko/overlay
endif

PRODUCT_AAPT_CONFIG := normal large xlarge tvdpi hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.hardware=bcm_platform \
    ro.product.board=bcm_platform

TARGET_CPU_SMP := true

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/nexus.ko:system/vendor/drivers/nexus.ko \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/nx_ashmem.ko:system/vendor/drivers/nx_ashmem.ko \
    device/google/avko/init.blockdev.rc:root/init.blockdev.rc \
    device/google/avko/init.blockdev.rc:root/init.recovery.blockdev.rc \
    device/google/avko/init.eth.rc:root/init.eth.rc \
    device/google/avko/init.recovery.bcm_platform.rc:root/init.recovery.bcm_platform.rc \
    device/google/avko/init.recovery.nx.dynheap.rc:root/init.recovery.nx.dynheap.rc \
    device/google/avko/media_codecs.xml:system/etc/media_codecs.xml \
    device/google/avko/aon_gpio.cfg:system/vendor/power/aon_gpio.cfg \
    device/google/avko/audio_policy_btusb.conf:system/etc/audio_policy.conf \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/google/avko/webview-command-line:/data/local/tmp/webview-command-line \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.live_tv.xml:system/etc/permissions/android.software.live_tv.xml \
    frameworks/native/data/etc/android.software.webview.xml:system/etc/permissions/android.software.webview.xml \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/libnexusir/irkeymap/broadcom_black.ikm:system/usr/irkeymap/broadcom_black.ikm \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/libnexusir/irkeymap/broadcom_silver.ikm:system/usr/irkeymap/broadcom_silver.ikm \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/fstab.broadcomstb:root/fstab.bcm_platform \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/gps.conf:system/etc/gps.conf \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.broadcomstb.nonxsock.rc:root/init.bcm_platform.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.broadcomstb.usb.rc:root/init.bcm_platform.usb.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.nx.dynheap.rc:root/init.nx.dynheap.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/ueventd.bcm_platform.rc:root/ueventd.bcm_platform.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/ws_home.html:root/ws_home.html \
    ${BCM_VENDOR_STB_ROOT}/drivers/droid_pm/droid_pm.ko:system/vendor/drivers/droid_pm.ko

ifneq ($(wildcard device/google/atv/tv_core_hardware.xml),)
  PRODUCT_COPY_FILES += \
      device/google/avko/bootanimation.zip:system/media/bootanimation.zip
endif

ifeq ($(SAGE_SUPPORT),y)
  PRODUCT_COPY_FILES += \
      ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_bl.bin:system/bin/sage_bl.bin \
      ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_bl_dev.bin:system/bin/sage_bl_dev.bin \
      ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_os_app.bin:system/bin/sage_os_app.bin \
      ${BCM_VENDOR_STB_ROOT}/bcm_platform/libsecurity/sage/7439B0/sage_os_app_dev.bin:system/bin/sage_os_app_dev.bin
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.bq.gpu_to_cpu_unsupported=1 \
    ro.zygote.disable_gl_preload=true

# GMS package integration.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-acme

# nx configuration.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608 \
    debug.hwui.render_dirty_regions=false \
    ro.nx.heap.video_secure=80m \
    ro.nx.heap.main=96m \
    ro.nx.heap.drv_managed=0m \
    ro.nx.mma=1 \
    ro.nx.heap.grow=8m \
    ro.nx.heap.shrink=2m \
    ro.nx.heap.gfx=48m \
    ro.nx.odv=1 \
    ro.nx.odv.use.alt=150m \
    ro.nx.odv.a1.use=50

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

PRODUCT_PACKAGES += \
    wpa_supplicant \
    dhcpcd.conf \
    network \
    ethtool \
    busybox \
    e2fsck \
    nxdispfmt \
    nxserver \
    nxlogger \
    makegpt \
    makehwcfg

# only for full image.
ifeq (,$(filter redux,$(LOCAL_RUN_TARGET)))
  PRODUCT_PACKAGES += \
      audio.primary.bcm_platform \
      audio.usb.default \
      audio.r_submix.default \
      audio.atvr.default \
      libaudiopolicymanagerdefault \
      libaudiopolicymanager \
      BcmAdjustScreenOffset \
      BcmCoverFlow \
      BcmTVInput \
      BcmOtaUpdater \
      camera.bcm_platform \
      Galaxy4 \
      gralloc.bcm_platform \
      hdmi_cec.bcm_platform \
      HoloSpiralWallpaper \
      hwcbinder \
      hwcomposer.bcm_platform \
      libhwcbinder \
      libhwcconv \
      libjni_adjustScreenOffset \
      libjni_changedisplayformat \
      libjni_generalSTBFunctions \
      libGLES_nexus \
      libnexusir \
      libpmlibservice \
      libpng \
      libquake \
      libstagefrighthw \
      libbcrypt \
      libdrmrootfs \
      libcmndrm \
      libcmndrm_tl \
      libsrai \
      libOMX.BCM.h264.decoder.secure \
      liboemcrypto \
      libwvdrmengine \
      libcmndrmprdy \
      libplayreadydrmplugin \
      libplayreadypk_host \
      LiveWallpapers \
      LiveWallpapersPicker \
      memtrack.bcm_platform \
      power.bcm_platform \
      pmlibserver \
      send_cec \
      tv_input.bcm_platform \
      TV \
      MagicSmokeWallpapers \
      NoiseField \
      PhaseBeam \
      PhotoTable \
      TvProvider \
      VisualizationWallpapers

  ifneq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_PACKAGES += \
	ExoPlayerDemo
  endif

  PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
endif

$(call inherit-product-if-exists, ${BCM_VENDOR_STB_ROOT}/bcm_platform/device-vendor.mk)


PRODUCT_NAME := avko
PRODUCT_DEVICE := avko
PRODUCT_MODEL := avko
PRODUCT_CHARACTERISTICS := tv
PRODUCT_MANUFACTURER := Google
PRODUCT_BRAND := Google

# exporting toolchains path for kernel image+modules
export PATH := ${ANDROID}/prebuilts/gcc/linux-x86/arm/stb/stbgcc-4.8-1.3/bin:${PATH}

# This makefile copies the prebuilt BT kernel module and corresponding firmware and configuration files

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

ADDITIONAL_BUILD_PROPERTIES += \
    ro.rfkilldisabled=1

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/firmware/BCM43569A2_001.003.004.0044.0000_Generic_USB_40MHz_fcbga_BU_Tx6dbm_desen_Freebox.hcd:system/vendor/broadcom/btusb/firmware/BCM43569A2_001.003.004.0044.0000_Generic_USB_40MHz_fcbga_BU_Tx6dbm_desen_Freebox.hcd

PRODUCT_PACKAGES += \
	audio.a2dp.default

# This makefile copies the prebuilt wifi driver module and corresponding firmware and configuration files
BRCM_DHD_DRIVER_TARGETS := \
	${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/firmware/fw.bin.trx \
	${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/nvrams/nvm.txt \
	${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/driver/bcmdhd.ko \
	${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/wl \
	${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/dhd

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/driver/bcmdhd.ko:system/vendor/broadcom/dhd/driver/bcmdhd.ko \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/firmware/fw.bin.trx:system/vendor/firmware/broadcom/dhd/firmware/fw.bin.trx \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/wl:system/bin/wl \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/dhd:system/bin/dhd \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/nvrams/nvm.txt:system/vendor/firmware/broadcom/dhd/nvrams/nvm.txt \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/init.brcm_dhd.rc:root/init.brcm_dhd.rc \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    dhcpcd.conf \
    network \
    wpa_supplicant

PRODUCT_PROPERTY_OVERRIDES += \
   wifi.interface=wlan0

$(BRCM_DHD_DRIVER_TARGETS): brcm_dhd_driver
	@echo "'brcm_dhd_driver' target: $@"
