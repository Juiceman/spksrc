SPK_NAME = nzedb
SPK_VERS = 0.6.1.2
SPK_REV = 1
SPK_ICON = src/nzedb.png

DEPENDS  = cross/busybox cross/$(SPK_NAME)
SPK_DEPENDS = "PEAR"

MAINTAINER = cytec
DESCRIPTION = nZEDb automatically scans usenet, similar to the way google search bots scan the internet.
ADMIN_URL = /nzedb/www/
RELOAD_UI = yes
DISPLAY_NAME = nZEDb
BETA = 1
CHANGELOG = "initial release"

HOMEPAGE   = https://github.com/nZEDb/nZEDb
LICENSE    = GPLv3

WIZARDS_DIR = src/wizard/
CONF_DIR = src/conf/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_DEP_SERVICES = apache-web mysql
START_DEP_SERVICES = apache-web mysql

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = nzedb_extra_install

BUSYBOX_CONFIG = daemon nice
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: nzedb_extra_install
nzedb_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 src/nzedb.sh $(STAGING_DIR)/bin/
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
