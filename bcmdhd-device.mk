# This makefile copies the prebuilt wifi driver moduel and corresponding firmware and configuration files
${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/firmware/fw.bin.trx: refsw_build
${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/nvrams/nvm.txt: refsw_build

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/firmware/fw.bin.trx:system/vendor/firmware/broadcom/dhd/firmware/fw.bin.trx \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/nvrams/nvm.txt:system/vendor/firmware/broadcom/dhd/nvrams/nvm.txt \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/init.brcm_dhd.rc:root/init.brcm_dhd.rc

else

${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/driver/bcmdhd.ko: refsw_build
${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/wl: refsw_build
${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/dhd: refsw_build

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/driver/bcmdhd.ko:system/vendor/broadcom/dhd/driver/bcmdhd.ko \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/firmware/fw.bin.trx:system/vendor/firmware/broadcom/dhd/firmware/fw.bin.trx \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/wl:system/bin/wl \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/tools/dhd:system/bin/dhd \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/nvrams/nvm.txt:system/vendor/firmware/broadcom/dhd/nvrams/nvm.txt \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_dhd/init.brcm_dhd.rc:root/init.brcm_dhd.rc
endif

PRODUCT_COPY_FILES += \
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

