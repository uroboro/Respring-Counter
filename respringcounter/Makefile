include theos/makefiles/common.mk

TWEAK_NAME = respringcounter
respringcounter_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	#PreferenceLoader plist
	$(ECHO_NOTHING)if [ -f Preferences.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/respringcounter; cp Preferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/respringcounter/; fi$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"
