#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 TeamNexus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

define zero-find-vendor-blobs
    $(foreach vendor_file, $(shell find $(1) -type f | sed -n 's|^$(1)/||p'), \
    	$(if $(strip $(findstring $(vendor_file):$(vendor_file),$(PRODUCT_COPY_FILES))), \
    		$(NOOP), \
    		$(1)/$(vendor_file):$(vendor_file)))
endef

# Workaround for empty TARGET_DEVICE
TARGET_DEVICE := $(__PRODUCT_TARGET_NAME)

#
# Blobs for SM-G92xF
#
ifneq ($(filter zerofltexx zeroltexx,$(TARGET_DEVICE)),)
    PRODUCT_COPY_FILES += $(call zero-find-vendor-blobs,vendor/samsung/zero-common/devices/xx)
endif

#
# Blobs for SM-G92xP
#
ifneq ($(filter zerofltespr zeroltespr,$(TARGET_DEVICE)),)
    PRODUCT_COPY_FILES += $(call zero-find-vendor-blobs,vendor/samsung/zero-common/devices/spr)
endif

#
# Blobs for non-SM-G92xP
#
ifeq ($(filter zerofltespr zeroltespr,$(TARGET_DEVICE)),)
    PRODUCT_COPY_FILES += $(call zero-find-vendor-blobs,vendor/samsung/zero-common/devices/non-spr)
endif

#
# Commons blobs
#
PRODUCT_COPY_FILES += $(call zero-find-vendor-blobs,vendor/samsung/zero-common/proprietary)
