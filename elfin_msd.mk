# elfin variant with 'soft' msd (dolby) audio hal support
export LOCAL_DEVICE_MSD_SUPPORT := y
include device/broadcom/elfin/elfin.mk

PRODUCT_NAME                   := elfin_msd
PRODUCT_MODEL                  := elfin
PRODUCT_BRAND                  := google
PRODUCT_DEVICE                 := elfin
