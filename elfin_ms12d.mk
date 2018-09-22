# elfin variant with dolby ms12d support.
export BDSP_MS12_SUPPORT       := D
export LOCAL_CFG_PROFILE       := ms12d
include device/broadcom/elfin/elfin.mk

PRODUCT_NAME                   := elfin_ms12d
PRODUCT_MODEL                  := elfin_ms12d
PRODUCT_BRAND                  := google
PRODUCT_DEVICE                 := elfin
