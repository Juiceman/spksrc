SPK_NAME = webogram
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 6
SPK_ICON = src/webogram.png
DSM_UI_DIR = app

DEPENDS  =

MAINTAINER = cytec
DESCRIPTION = UNOFFICIAL Telegram Web App
ADMIN_URL = /webogram/
RELOAD_UI = yes
STARTABLE = no
DISPLAY_NAME = Webogram

HOMEPAGE   = https://github.com/zhukov/webogram
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_DEP_SERVICES = apache-web

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = webogram_extra_install

# Pure HMTL package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: webogram_extra_install
webogram_extra_install: $(STAGING_DIR)/share/webogram
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/webogram:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone https://github.com/zhukov/webogram.git webogram
	cd $(STAGING_DIR)/share/webogram && make package && mv package_dist ../ && rm -rf * && mv ../package_dist/* ./ && rm -fr ../package_dist
	rm -fr $(STAGING_DIR)/share/webogram/.git $(STAGING_DIR)/share/webogram/.gitignore
