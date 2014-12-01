PKG_NAME = nano
PKG_VERS = 2.2.6
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.nano-editor.org/dist/v2.2
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/ncurses

HOMEPAGE = http://www.nano-editor.org/
COMMENT  = GNU nano is designed to be a free replacement for the Pico text editor, part of the Pine email suite from The University of Washington.
LICENSE  =

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --enable-utf8 --disable-nls --enable-color --enable-extra --enable-multibuffer --enable-nanorc

include ../../mk/spksrc.cross-cc.mk

