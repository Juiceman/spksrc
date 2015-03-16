SPK_NAME = gogs
SPK_VERS = 0.5.13
SPK_REV = 1
SPK_ICON = src/gogs.png

DEPENDS  = cross/$(SPK_NAME)

RELOAD_UI = yes
STARTABLE = no
BETA = 1

MAINTAINER = cytec
DESCRIPTION = "Gogs(Go Git Service) is a painless self-hosted Git Service written in Go."
DISPLAY_NAME = Gogs

HOMEPAGE   = http://gogs.io
LICENSE    =

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = gogs_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: gogs_extra_install
gogs_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/bin/custom
	install -m 755 -d $(STAGING_DIR)/bin/custom/conf
	install -m 755 src/app.ini $(STAGING_DIR)/bin/custom/conf/app.ini
	install -m 755 -d $(STAGING_DIR)/app
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
