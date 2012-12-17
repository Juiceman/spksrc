SPK_NAME = synodlnatrakt
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 3
SPK_ICON = src/synodlnatrakt.png
DSM_UI_DIR = app

DEPENDS  = cross/bzip2 cross/python cross/libjpeg cross/pil

MAINTAINER = cytec
DESCRIPTION = Dafuq is this?
ADMIN_PORT = 1337
RELOAD_UI = yes
DISPLAY_NAME = SynoDLNAtrakt

HOMEPAGE   = http://cytec.us/forum/
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)
PYTHON_LIB_DIR = lib/python2.7
PLIST_TRANSFORM = sed "s%@PYTHON_SITE_PACKAGES@%$(PYTHON_LIB_DIR)/site-packages%"

POST_STRIP_TARGET = synodlnatrakt_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: couchpotato_extra_install
couchpotatoserver_extra_install: $(STAGING_DIR)/share/SynoDLNAtrakt
	install -m 755 -d $(STAGING_DIR)/var
	install -m 600 src/config.ini $(STAGING_DIR)/var/config.ini
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 src/app/synodlnatrakt.cgi.py $(STAGING_DIR)/app/synodlnatrakt.cgi
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/SynoDLNAtrakt:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone https://github.com/cytec/SynoDLNAtrakt.git SynoDLNAtrakt
	rm -fr $(STAGING_DIR)/share/SynoDLNAtrakt/.git $(STAGING_DIR)/share/SynoDLNAtrakt/.gitignore
