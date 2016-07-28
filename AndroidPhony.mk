
.PHONY: android_bsu.elf
android_bsu.elf: build_bootloaderimg

.PHONY: bolt-bb.bin
bolt-bb.bin: build_bootloaderimg

.PHONY: bootloader.img
bootloader.img: build_bootloaderimg
