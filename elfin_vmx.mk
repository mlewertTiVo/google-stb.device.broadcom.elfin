# Enable VMX MediaCas support
export ANDROID_SUPPORTS_MEDIACAS := y
export ANDROID_ENABLE_CAS_VMX    := y

include device/broadcom/elfin/elfin.mk

PRODUCT_NAME                   := elfin_vmx
PRODUCT_MODEL                  := elfin
PRODUCT_BRAND                  := google
PRODUCT_DEVICE                 := elfin

export LOCAL_DEVICE_SIGNING_PKG := elfin

# Common Verimatrix product definitions
include device/broadcom/common/cas/product_vmx.mk
