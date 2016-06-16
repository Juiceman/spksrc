PKG_NAME = nzedb
PKG_VERS = 0.5.4
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_FILE = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/nZEDb/nZEDb/archive
PKG_DIR = nZEDb-$(PKG_VERS)

HOMEPAGE = https://github.com/nZEDb/nZEDb
COMMENT  = nZEDb automatically scans usenet, similar to the way google search bots scan the internet.
LICENSE  = GPLv3

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = myInstall

include ../../mk/spksrc.cross-cc.mk

myInstall:
	mkdir -p $(STAGING_INSTALL_PREFIX)/share/nzedb
	tar -cf - -C $(WORK_DIR)/$(PKG_DIR) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/share/nzedb
