#############################################################################
#    (c)2010-2014 Broadcom Corporation
#
# This program is the proprietary software of Broadcom Corporation and/or its licensors,
# and may only be used, duplicated, modified or distributed pursuant to the terms and
# conditions of a separate, written license agreement executed between you and Broadcom
# (an "Authorized License").  Except as set forth in an Authorized License, Broadcom grants
# no license (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software and all
# intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED LICENSE, THEN YOU
# HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD IMMEDIATELY
# NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
# Except as expressly set forth in the Authorized License,
#
# 1.     This program, including its structure, sequence and organization, constitutes the valuable trade
# secrets of Broadcom, and you shall use all reasonable efforts to protect the confidentiality thereof,
# and to use this information only in connection with your use of Broadcom integrated circuit products.
#
# 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
# AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
# WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
# THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED WARRANTIES
# OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE,
# LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION
# OR CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE ENTIRE RISK ARISING OUT OF
# USE OR PERFORMANCE OF THE SOFTWARE.
#
# 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
# LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT, OR
# EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO YOUR
# USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF THE AMOUNT
# ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER IS GREATER. THESE
# LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF
# ANY LIMITED REMEDY.
#
#############################################################################

KERNEL_DIR := $(shell [ -e $(ANDROID_TOP)/kernel/private/bcm-97xxx/uclinux-rootfs ] && echo "$(ANDROID_TOP)/kernel/private/bcm-97xxx/uclinux-rootfs")
ifeq ($(KERNEL_DIR),)
KERNEL_DIR := $(ANDROID_TOP)/kernel/private/bcm-97xxx/rootfs
endif

ifeq ($(OUT_DIR_COMMON_BASE),)
KERNEL_OUT_DIR := out/target/product/${ANDROID_PRODUCT_OUT}
KERNEL_OUT_DIR_ABS := ${ANDROID_TOP}/${KERNEL_OUT_DIR}
else
KERNEL_OUT_DIR := ${OUT_DIR_COMMON_BASE}/$(notdir $(PWD))/target/product/${ANDROID_PRODUCT_OUT}
KERNEL_OUT_DIR_ABS := ${KERNEL_OUT_DIR}
endif

KERNEL_VER := vmlinuz-7439b0-android

.PHONY: build_kernel
AUTOCONF := $(LINUX)/include/generated/autoconf.h
build_kernel:
	@echo "'$@' started"
	-@if [ -f $(AUTOCONF) ]; then \
		cp -pv $(AUTOCONF) $(AUTOCONF)_refsw; \
	fi
	$(MAKE) -C $(KERNEL_DIR) $(KERNEL_VER)
	-@if [ -f $(AUTOCONF)_refsw ]; then \
		if [ `diff -q $(AUTOCONF)_refsw $(AUTOCONF) | wc -l` -eq 0 ]; then \
			echo "'generated/autoconf.h' is unchanged"; \
			cp -pv $(AUTOCONF)_refsw $(AUTOCONF); \
		fi; \
		rm -f $(AUTOCONF)_refsw; \
	fi
	cp -pv $(KERNEL_DIR)/images/$(KERNEL_VER) $(KERNEL_OUT_DIR_ABS)/kernel
	@echo "'$@' completed"

$(KERNEL_OUT_DIR)/kernel: build_kernel
	@echo "'build_kernel' target: $@"

.PHONY: clean_drivers
clean_drivers: clean_brcm_dhd_driver

.PHONY: clean_kernel
clean_kernel: clean_drivers
	$(MAKE) -C $(KERNEL_DIR) distclean
	rm -f $(KERNEL_DIR)/images/$(KERNEL_VER)
	rm -f $(KERNEL_OUT_DIR_ABS)/kernel
