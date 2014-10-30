PKG_NAME = go
PKG_VERS = 1.3.3
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)$(PKG_VERS).src.$(PKG_EXT)
PKG_DIST_SITE = https://storage.googleapis.com/golang
PKG_DIR = $(PKG_NAME)

DEPENDS =

HOMEPAGE   = http://www.python.org/
COMMENT    = Python Programming Language
LICENSE    =

GNU_CONFIGURE = 1
CONFIGURE_TARGET = nop
COMPILE_TARGET = myComp
INSTALL_TARGET = nop

include ../../mk/spksrc.native-cc.mk

myComp:
	@$(MSG) "Building Go"
	cd $(WORK_DIR)/$(PKG_NAME)/src && export CGO_ENABLED=0 && ./make.bash
	@$(MSG) "Building Go for arm"
	cd $(WORK_DIR)/$(PKG_NAME)/src && export GOARCH=arm && export CGO_ENABLED=0 && ./make.bash --no-clean
	@$(MSG) "Building Go amd64"
	cd $(WORK_DIR)/$(PKG_NAME)/src && export GOARCH=amd64 && export CGO_ENABLED=0 && ./make.bash --no-clean
