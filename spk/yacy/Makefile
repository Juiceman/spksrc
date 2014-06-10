SPK_NAME = yacy
SPK_VERS = v1.72
SPK_REV = 1
SPK_ICON = src/yacy.png
DSM_UI_DIR = app
BETA = 1

DEPENDS  =
SPK_DEPENDS = "JavaManager"

MAINTAINER = SynoCommunity
DESCRIPTION = YaCy is a free search engine that anyone can use to build a search portal for their intranet or to help search the public internet. When contributing to the world-wide peer network, the scale of YaCy is limited only by the number of users in the world and can index billions of web pages.
RELOAD_UI = yes
DISPLAY_NAME = YaCy
HOMEPAGE   = http://yacy.net/
LICENSE    = GPL


INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

COPY_TARGET = nop
POST_STRIP_TARGET = yacy_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: yacy_extra_install
yacy_extra_install: $(STAGING_DIR)/share/yacy
	install -m 755 -d $(STAGING_DIR)/app
	install -m 755 -d $(STAGING_DIR)/var
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		$(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/yacy:
	install -m 755 -d $(STAGING_DIR)/share
	wget http://yacy.net/release/yacy_v1.72_20140506_9000.tar.gz && tar xfz yacy_v1.72_20140506_9000.tar.gz
	mv yacy/* $(STAGING_DIR)/share
	rm -rf yacy yacy_v1.72_20140506_9000.tar.gz