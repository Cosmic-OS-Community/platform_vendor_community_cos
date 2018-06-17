ifeq ($(COS_CB), true)
	COS_BUILD_TYPE := COMMUNITY
	COSMIC_VERSION_CODENAME := COMMUNITY
endif

ifeq ($(COS_CB),true)
    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS-Community/platform_vendor_community_cos/master/cos.devices)
    FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
    endif
    ifneq ($(IS_OFFICIAL), true)
       COS_CB=false
       $(error Device is not official "$(FOUND)")
    endif
    PRODUCT_GENERIC_PROPERTIES += \
        persist.ota.romname=$(TARGET_PRODUCT) \
        persist.ota.version=$(shell date +%Y%m%d) \
        persist.ota.manifest=https://raw.githubusercontent.com/Cosmic-OS-Community/platform_vendor_community_ota/master/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif
