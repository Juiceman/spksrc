SPK_NAME = gopoststuff
SPK_VERS = 0.2.0
SPK_REV = 2
SPK_ICON = src/gopoststuff.png

DEPENDS  = cross/$(SPK_NAME)

RELOAD_UI = yes
STARTABLE = no
BETA = 1

MAINTAINER = cytec
DESCRIPTION = "GoPostStuff is a simple client for posting binaries to Usenet, written in Go. If you've seen/used newsmangler, imagine that but faster (and maybe better one day)."
DISPLAY_NAME = GoPostStuff

HOMEPAGE   = https://github.com/madcowfred/GoPostStuff
LICENSE    =

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = gopoststuff_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: gopoststuff_extra_install
gopoststuff_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/app
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
