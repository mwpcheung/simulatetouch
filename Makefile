export ARCHS = arm64
export TARGET = iphone:latest:8.0
export THEOS_DEVICE_IP = 192.168.2.206
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SimulateTouch
SimulateTouch_CFLAGS += -I./private-headers -I Iinclude
SimulateTouch_FILES = SimulateTouch.mm
SimulateTouch_LDFLAGS = -lsubstrate -lrocketbootstrap GraphicsServices.tbd
SimulateTouch_PRIVATE_FRAMEWORKS = IOKit 
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk


LIBRARY_NAME = libsimulatetouch
libsimulatetouch_FILES = STLibrary.mm
libsimulatetouch_LDFLAGS = -lrocketbootstrap
libsimulatetouch_INSTALL_PATH = /usr/lib/
libsimulatetouch_FRAMEWORKS = UIKit CoreGraphics

TOOL_NAME = stouch
stouch_FILES = main.mm STLibrary.mm
stouch_FRAMEWORKS = UIKit
stouch_INSTALL_PATH = /usr/bin/
stouch_FRAMEWORKS = UIKit CoreGraphics
stouch_LDFLAGS = -lrocketbootstrap
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/tool.mk

before-package::
	chmod 755 ./.theos/obj/debug/arm64/stouch	
	chmod 755 ./.theos/obj/debug/stouch
	chmod 755 ./.theos/_/usr/bin/stouch 
	ldid -Sprivliage.plist ./.theos/obj/debug/arm64/stouch	
	ldid -Sprivliage.plist ./.theos/obj/debug/stouch
	ldid -Sprivliage.plist ./.theos/_/usr/bin/stouch 
