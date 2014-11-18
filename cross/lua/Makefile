PKG_NAME = lua
PKG_VERS = 5.2.3
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.lua.org/ftp
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS =

HOMEPAGE = http://www.libpng.org/pub/png/libpng.html
COMMENT  = Portable Network Graphics Library

CONFIGURE_TARGET = nope
COMPILE_TARGET = myCompile
INSTALL_TARGET = myInstall

LICENSE  = http://www.libpng.org/pub/png/src/libpng-LICENSE.txt
include ../../mk/spksrc.cross-cc.mk


myCompile:
	$(RUN) make clean &&  make posix CROSS=$(TC_PATH)$(TC_PREFIX)


myInstall:
	$(RUN) make install INSTALL_TOP=$(STAGING_INSTALL_PREFIX)


