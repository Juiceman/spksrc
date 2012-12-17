SPK_NAME = sickbeard-german
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 4
SPK_ICON = src/sickbeard.png
DSM_UI_DIR = app

DEPENDS  =
SPK_DEPENDS = "python>=2.7.3-1"

MAINTAINER = cytec
DESCRIPTION = Deutsche Version von SickBeard, sprache kann bei der Erstellung von Serien ausgewaehlt werden.
ADMIN_PORT = 8081
RELOAD_UI = yes
DISPLAY_NAME = SickBeard German

HOMEPAGE   = http://cytec.us/forum/
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = sickbeard_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: sickbeard_extra_install
sickbeard_extra_install: $(STAGING_DIR)/share/SickBeard
	install -m 755 -d $(STAGING_DIR)/var
	install -m 600 src/config.ini $(STAGING_DIR)/var/config.ini
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 src/app/sickbeard.cgi.py $(STAGING_DIR)/app/sickbeard.cgi
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/SickBeard:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone https://github.com/cytec/Sick-Beard.git SickBeard
	rm -fr $(STAGING_DIR)/share/SickBeard/.git $(STAGING_DIR)/share/SickBeard/.gitignore
	chmod 777 $(STAGING_DIR)/share/SickBeard/autoProcessTV
	install -m 600 $(STAGING_DIR)/share/SickBeard/autoProcessTV/autoProcessTV.cfg.sample $(STAGING_DIR)/share/SickBeard/autoProcessTV/autoProcessTV.cfg

