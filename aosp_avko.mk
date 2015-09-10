#
# Copyright 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

export LOCAL_RUN_TARGET := aosp
include device/google/avko/avko.mk

PRODUCT_NAME := aosp_avko
PRODUCT_DEVICE := avko
PRODUCT_MANUFACTURER := Google
PRODUCT_BRAND := Google

# exporting toolchains path for kernel image+modules
export PATH := ${ANDROID}/prebuilts/gcc/linux-x86/arm/stb/stbgcc-4.8-1.3/bin:${PATH}
