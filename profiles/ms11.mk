# kernel command line.
KERNEL_CMDLINE      := mem=2000m@0m mem=40m@2008m
KERNEL_CMDLINE      += bmem=548m@398m
KERNEL_CMDLINE      += brcm_cma=574m@962m
KERNEL_CMDLINE      += ramoops.mem_address=0x7D000000 ramoops.mem_size=0x800000 ramoops.console_size=0x400000
KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE ?= ${KERNEL_CMDLINE}

# profile specific properties settings (heap match bmem regions).
PRODUCT_PROPERTY_OVERRIDES += \
   ro.nx.heap.main=112m \
   ro.nx.dolby.ms=11 \
   ro.nx.audio_loudness=ebu

