PKG_NAME = LuaJIT
PKG_VERS = 2.0.3
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://luajit.org/download
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = native/lua

HOMEPAGE = http://www.libpng.org/pub/png/libpng.html
COMMENT  = Portable Network Graphics Library

CONFIGURE_TARGET = nope
COMPILE_TARGET = myCompile
INSTALL_TARGET = myInstall

LICENSE  = http://www.libpng.org/pub/png/src/libpng-LICENSE.txt
include ../../mk/spksrc.cross-cc.mk


myCompile:
	$(RUN) make clean && make CROSS=$(TC_PATH)$(TC_PREFIX) LDFLAGS="-Wl,-export-dynamic" CFLAGS= CC="gcc -m32"


myInstall:
	$(RUN) make install DPREFIX=$(STAGING_INSTALL_PREFIX)


