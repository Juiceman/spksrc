SPK_NAME = webogram
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 6
SPK_ICON = src/webogram.png
DSM_UI_DIR = app

DEPENDS  = cross/screen
SPK_DEPENDS = "node"

MAINTAINER = SynoCommunity
DESCRIPTION = UNOFFICIAL Telegram Web App
ADMIN_PORT = 8000
RELOAD_UI = yes
DISPLAY_NAME = Webogram

HOMEPAGE   = https://github.com/zhukov/webogram
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = webogram_extra_install


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
	rm -fr $(STAGING_DIR)/share/webogram/.git $(STAGING_DIR)/share/webogram/.gitignore
