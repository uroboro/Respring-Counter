include theos/makefiles/common.mk

TOOL_NAME = respringcounter
respringcounter_FILES = main.mm

include $(THEOS_MAKE_PATH)/tool.mk
SUBPROJECTS += respringcounter
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	@exec ssh -p $(THEOS_DEVICE_PORT) root@$(THEOS_DEVICE_IP) "launchctl unload /Library/LaunchDaemons/com.uroboro.daemon.respringcounter.plist"
	@exec ssh -p $(THEOS_DEVICE_PORT) root@$(THEOS_DEVICE_IP) "launchctl load /Library/LaunchDaemons/com.uroboro.daemon.respringcounter.plist"
