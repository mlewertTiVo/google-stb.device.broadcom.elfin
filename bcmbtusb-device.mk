# This makefile copies the prebuilt BT kernel module and corresponding firmware and configuration files

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

ADDITIONAL_BUILD_PROPERTIES += \
    ro.rfkilldisabled=1

ifeq ($(BROADCOM_WIFI_CHIPSET),43242a1)

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/firmware/BCM43242A1_001.002.007.0074.0000_Generic_USB_Class2_Generic_3DTV_TBFC_37_4MHz_Wake_on_BLE_Hisense.hcd:system/vendor/broadcom/btusb/firmware/BCM43242A1_001.002.007.0074.0000_Generic_USB_Class2_Generic_3DTV_TBFC_37_4MHz_Wake_on_BLE_Hisense.hcd

endif

ifeq ($(BROADCOM_WIFI_CHIPSET),43570a0)

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/firmware/BCM43569A0_001.001.009.0039.0000_Generic_USB_40MHz_fcbga_BU_TXPwr_8dbm_4.hcd:system/vendor/broadcom/btusb/firmware/BCM43569A0_001.001.009.0039.0000_Generic_USB_40MHz_fcbga_BU_TXPwr_8dbm_4.hcd

endif

ifeq ($(BROADCOM_WIFI_CHIPSET),43570a2)

PRODUCT_COPY_FILES += \
    ${BCM_VENDOR_STB_ROOT}/bcm_platform/brcm_btusb/firmware/BCM43569A2_001.003.004.0044.0000_Generic_USB_40MHz_fcbga_BU_Tx6dbm_desen_Freebox.hcd:system/vendor/broadcom/btusb/firmware/BCM43569A2_001.003.004.0044.0000_Generic_USB_40MHz_fcbga_BU_Tx6dbm_desen_Freebox.hcd

endif

PRODUCT_PACKAGES += \
	audio.a2dp.default
