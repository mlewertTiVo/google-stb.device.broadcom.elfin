KERNEL_SRC_DIR ?= kernel/private/bcm-97xxx/linux
ifneq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
  ifeq ($(TARGET_PREBUILT_KERNEL),)
    TARGET_KERNEL_BUILT_FROM_SOURCE := true
  endif
endif

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
export B_NEXUS_API_BUILD_COMPLETED := y
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/google/avko-kernel/vmlinuz-7439b0-android
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

endif

# standard target - based on the standard google atv device if present,
#                   otherwise fallback (note pdk device is not atv based in
#                   particular since device/google/atv is not part of pdk).
ifeq (,$(LOCAL_RUN_TARGET))
ifneq ($(wildcard device/google/atv/tv_core_hardware.xml),)
$(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)
$(call inherit-product, device/google/atv/products/atv_base.mk)
else
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
PRODUCT_COPY_FILES += device/google/avko/tv_core_hardware.xml:system/etc/permissions/tv_core_hardware.xml
endif
$(call inherit-product-if-exists, vendor/google/products/gms.mk)
PRODUCT_MODEL := BCM7XXX_TEST_SETTOP
endif
# aosp - inherit from AOSP-BASE, not ATV.
ifeq ($(LOCAL_RUN_TARGET),aosp)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
PRODUCT_MODEL := BCM7XXX_TEST_SETTOP
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
    ro.product.board=bcm_platform \
    ro.nx.boot.mode=dynheap

TARGET_CPU_SMP := true

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
PRODUCT_COPY_FILES += \
    device/google/avko-kernel/drivers/nexus.ko:system/vendor/drivers/nexus.ko \
    device/google/avko-kernel/drivers/nx_ashmem.ko:system/vendor/drivers/nx_ashmem.ko \
    device/google/avko-kernel/drivers/wakeup_drv.ko:system/vendor/drivers/wakeup_drv.ko
else
PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/nexus.ko:system/vendor/drivers/nexus.ko \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/nx_ashmem.ko:system/vendor/drivers/nx_ashmem.ko \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/wakeup_drv.ko:system/vendor/drivers/wakeup_drv.ko
endif

PRODUCT_COPY_FILES += \
    device/google/avko/init.blockdev.rc:root/init.blockdev.rc \
    device/google/avko/init.blockdev.rc:root/init.recovery.blockdev.rc \
    device/google/avko/init.eth.rc:root/init.eth.rc \
    device/google/avko/init.recovery.bcm_platform.rc:root/init.recovery.bcm_platform.rc \
    device/google/avko/init.recovery.nx.default.rc:root/init.recovery.nx.default.rc \
    device/google/avko/init.recovery.nx.dynheap.rc:root/init.recovery.nx.dynheap.rc \
    device/google/avko/media_codecs.xml:system/etc/media_codecs.xml \
    device/google/avko/aon_gpio.cfg:system/vendor/power/aon_gpio.cfg \
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
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.broadcomstb.rc:root/init.bcm_platform.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.broadcomstb.usb.rc:root/init.bcm_platform.usb.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.nx.default.rc:root/init.nx.default.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/init.nx.dynheap.rc:root/init.nx.dynheap.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/ueventd.bcm_platform.rc:root/ueventd.bcm_platform.rc \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/prebuilt/ws_home.html:root/ws_home.html

ifneq ($(wildcard device/google/atv/tv_core_hardware.xml),)
PRODUCT_COPY_FILES += \
    device/google/avko/bootanimation.zip:system/media/bootanimation.zip
endif

ifeq ($(ANDROID_ENABLE_BTUSB),y)
PRODUCT_COPY_FILES += \
    device/google/avko/audio_policy_btusb.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
    device/google/avko/audio_policy.conf:system/etc/audio_policy.conf
endif

ifeq ($(SAGE_SUPPORT),y)
PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_bl.bin:system/bin/sage_bl.bin \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_bl_dev.bin:system/bin/sage_bl_dev.bin \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_os_app.bin:system/bin/sage_os_app.bin \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_nexus/bin/sage_os_app_dev.bin:system/bin/sage_os_app_dev.bin
endif

ifeq ($(ANDROID_ENABLE_DHD),y)
$(call inherit-product-if-exists, device/google/avko/bcmdhd-device.mk)
endif

ifeq ($(ANDROID_ENABLE_BTUSB),y)
$(call inherit-product-if-exists, device/google/avko/bcmbtusb-device.mk)
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
   ro.nx.trim.pip=1 \
   ro.nx.trim.mosaic=1 \
   ro.nx.trim.stills=1 \
   ro.nx.trim.disp=1 \
   ro.nx.trim.minfmt=1 \
   ro.nx.trim.vc1=1 \
   ro.nx.trim.vidin=1 \
   ro.nx.mma=1 \
   ro.nx.heap.grow=8m \
   ro.nx.heap.shrink=2m \
   ro.nx.heap.gfx=48m \
   ro.nx.odv=1 \
   ro.nx.odv.use.alt=150m \
   ro.nx.odv.a1.use=50

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

ifeq ($(ANDROID_ENABLE_DHD),y)
PRODUCT_PACKAGES += \
    wpa_supplicant \
    dhcpcd.conf \
    network
endif

ifneq ($(wildcard vendor/google/Android.mk),)
# using gms, the LeanbackLauncher will be the default one.
else
PRODUCT_PACKAGES += \
   Browser \
   Calculator \
   Camera2 \
   Contacts \
   Clock \
   DeskClock \
   DevTools \
   DocumentsUI \
   DownloadProviderUi \
   Gallery2 \
   Launcher3 \
   lights.bcm_platform \
   Music \
   QuickSearchBox \
   LatinIME

ifneq ($(wildcard device/google/atv/tv_core_hardware.xml),)
PRODUCT_PACKAGES += \
   BcmTvSettingsLauncher
else
PRODUCT_PACKAGES += \
   Settings
endif
endif

PRODUCT_PACKAGES += \
    busybox \
    e2fsck \
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
    BcmUriPlayer \
    BcmOtaUpdater \
    Bouncer \
    camera.bcm_platform \
    Galaxy4 \
    gralloc.bcm_platform \
    hdmi_cec.bcm_platform \
    HoloSpiralWallpaper \
    hwcbinder \
    hwcomposer.bcm_platform \
    libbcmsideband \
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

ifneq ($(filter $(ANDROID_SUPPORTS_WIDEVINE) $(ANDROID_SUPPORTS_PLAYREADY),y),)
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
   libbcrypt \
   libdrmrootfs \
   libcmndrm \
   libcmndrm_tl \
   libsrai \
   libOMX.BCM.h264.decoder.secure

ifeq ($(ANDROID_SUPPORTS_WIDEVINE),y)
PRODUCT_PACKAGES += liboemcrypto \
                    libwvdrmengine
endif

ifeq ($(ANDROID_SUPPORTS_PLAYREADY),y)
PRODUCT_PACKAGES += libcmndrmprdy \
                    libplayreadydrmplugin \
                    libplayreadypk_host
endif
endif

endif

$(call inherit-product-if-exists, ${BCM_VENDOR_STB_ROOT}/bcm_platform/device-vendor.mk)
