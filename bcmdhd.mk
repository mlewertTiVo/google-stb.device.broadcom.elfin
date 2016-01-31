# Brcm DHD related defines
BRCM_DHD_PATH      := ${BRCM_NEXUS_INSTALL_PATH}/brcm_dhd
BRCM_DHD_KO_NAME   := bcmdhd.ko
BRCM_DHD_FW_NAME    ?= pcie-ag-pktctx-splitrx-amsdutx-txbf-p2p-mchan-idauth-idsup-tdls-mfp-sr-proptxstatus-pktfilter-wowlpf-ampduhostreorder-keepalive-wfds.bin
BRCM_DHD_NVRAM_DIR ?= ${BROADCOM_DHD_SOURCE_PATH}/nvrams
BRCM_DHD_NVRAM_NAME ?= bcm43570.nvm

.PHONY: brcm_dhd_driver
brcm_dhd_driver: build_kernel
	@echo "'$@' started"
	cd ${BROADCOM_DHD_SOURCE_PATH} && source ./setenv-android-stb7445.sh ${BROADCOM_WIFI_CHIPSET} && ./bfd-drv-cfg80211.sh;
	cp -p ${BROADCOM_DHD_SOURCE_PATH}/firmware/${BROADCOM_WIFI_CHIPSET}-roml/${BRCM_DHD_FW_NAME} ${BRCM_DHD_PATH}/firmware/fw.bin.trx;
	cp -p ${BRCM_DHD_NVRAM_DIR}/${BRCM_DHD_NVRAM_NAME} ${BRCM_DHD_PATH}/nvrams/nvm.txt;
	mkdir -p ${BRCM_DHD_PATH}/driver;
	cp -p ${BROADCOM_DHD_SOURCE_PATH}/driver/${BRCM_DHD_KO_NAME} ${BRCM_DHD_PATH}/driver;
	@echo "'$@' completed"


.PHONY: clean_brcm_dhd_driver
clean_brcm_dhd_driver:
	+@if [ -d ${BROADCOM_DHD_SOURCE_PATH} ]; then \
		cd ${BROADCOM_DHD_SOURCE_PATH} && \
		source ./setenv-android-stb7445.sh ${BROADCOM_WIFI_CHIPSET} && \
		./bfd-drv-cfg80211.sh clean; \
	fi
	rm -fv ${BRCM_DHD_PATH}/driver/${BRCM_DHD_KO_NAME}
	rm -fv ${BRCM_DHD_PATH}/firmware/fw.bin.trx
	rm -fv ${BRCM_DHD_PATH}/nvrams/nvm.txt
