
# elfin variant which does not support a|b mode, therefore
# only legacy style single slot and recovery.
export LOCAL_DEVICE_FORCED_NAB := y
include device/broadcom/elfin/elfin.mk

PRODUCT_NAME                   := elfin_nab
PRODUCT_MODEL                  := elfin
PRODUCT_BRAND                  := google
PRODUCT_DEVICE                 := elfin
