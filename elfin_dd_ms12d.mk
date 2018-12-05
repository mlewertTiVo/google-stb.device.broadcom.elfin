# elfin variant with dual decoder (main + pip) and dolby ms12d support
export HW_HVD_REDUX            := y
export BDSP_MS12_SUPPORT       := D
export LOCAL_CFG_PROFILE       := dd.ms12d
include device/broadcom/elfin/elfin.mk

PRODUCT_NAME                   := elfin_dd_ms12d
PRODUCT_MODEL                  := elfin
PRODUCT_BRAND                  := google
PRODUCT_DEVICE                 := elfin
