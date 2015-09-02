# Brcm DHD related defines
BRCM_DHD_PATH      := ${BRCM_NEXUS_INSTALL_PATH}/brcm_dhd
BRCM_DHD_KO_NAME   := bcmdhd.ko
BRCM_DHD_FW_NAME    ?= pcie-ag-pktctx-splitrx-amsdutx-txbf-p2p-mchan-idauth-idsup-tdls-mfp-sr-proptxstatus-pktfilter-wowlpf-ampduhostreorder-keepalive-wfds.bin
BRCM_DHD_NVRAM_NAME ?= bcm43570.nvm

.PHONY: brcm_dhd_driver
brcm_dhd_driver: build_kernel
	@echo "'$@' started"
	+@if [ -d ${BROADCOM_DHD_SOURCE_PATH} ]; then \
		cd ${BROADCOM_DHD_SOURCE_PATH} && \
		source ./setenv-android-stb7445.sh ${BROADCOM_WIFI_CHIPSET} && \
		./bfd-drv-cfg80211.sh; \
		cp -p ${BROADCOM_DHD_SOURCE_PATH}/firmware/${BROADCOM_WIFI_CHIPSET}-roml/${BRCM_DHD_FW_NAME} ${BRCM_DHD_PATH}/firmware/fw.bin.trx; \
		if [ "${BRCM_DHD_NVRAM_NAME}" != "" ] ; then \
			cp -p ${BROADCOM_DHD_SOURCE_PATH}/nvrams/${BRCM_DHD_NVRAM_NAME} ${BRCM_DHD_PATH}/nvrams/nvm.txt; \
		fi && \
		if [ -f ${BROADCOM_DHD_SOURCE_PATH}/driver/${BRCM_DHD_KO_NAME} ]; then \
			mkdir -p ${BRCM_DHD_PATH}/driver && \
			cp -p ${BROADCOM_DHD_SOURCE_PATH}/driver/${BRCM_DHD_KO_NAME} ${BRCM_DHD_PATH}/driver; \
		else \
			echo "Error: wifi driver failed to build." ; exit -1; \
		fi \
	else \
		echo Error: ${BROADCOM_DHD_SOURCE_PATH} " does not exist" ; exit -1; \
	fi
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
