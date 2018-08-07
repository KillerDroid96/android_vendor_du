# Versioning System
DU_BASE_VERSION = v12.4

ifndef DU_BUILD_TYPE
    DU_BUILD_TYPE := UNOFFICIAL
endif

# Only include DU-Updater for unofficial, official, weeklies, and rc builds
ifeq ($(filter-out UNOFFICIAL OFFICIAL WEEKLIES RC,$(DU_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        DU-Updater
endif

# Sign builds if building an unofficial, official or weekly build
ifeq ($(filter-out UNOFFICIAL OFFICIAL WEEKLIES,$(DU_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ../.keys/releasekey
endif

# Set all versions
DATE := $(shell date -u +%Y%m%d)
DU_VERSION := $(TARGET_PRODUCT)-$(DU_BASE_VERSION)-$(DATE)-$(shell date -u +%H%M)-$(DU_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.du.version=$(DU_VERSION) \
    ro.mod.version=$(DU_BUILD_TYPE)-$(DU_BASE_VERSION)-$(DATE)
