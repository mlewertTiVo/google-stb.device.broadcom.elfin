LOCAL_PATH := $(my-dir)

include $(LOCAL_PATH)/AndroidKernel.mk
include $(LOCAL_PATH)/AndroidPhony.mk

INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/bootloader.prod.img

ifneq ($(BCM_DIST_BLIMG_BINS),y)
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/gpt.bin
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/bootloader.dev.img
endif

