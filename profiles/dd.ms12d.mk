# kernel command line.
KERNEL_CMDLINE      := mem=2000m@0m mem=40m@2008m
KERNEL_CMDLINE      += bmem=656m@410m
KERNEL_CMDLINE      += brcm_cma=512m@1066m
KERNEL_CMDLINE      += ramoops.mem_address=0x7D000000 ramoops.mem_size=0x800000 ramoops.console_size=0x400000
KERNEL_CMDLINE      += rootwait init=/init ro
export LOCAL_DEVICE_KERNEL_CMDLINE ?= ${KERNEL_CMDLINE}

# profile specific properties settings (heap match bmem regions).
PRODUCT_PROPERTY_OVERRIDES += \
   ro.nx.heap.main=112m \
   ro.nx.trim.pip=0 \
   ro.nx.dolby.ms=12

