PKG_NAME = gogs
PKG_VERS = 0.5.13
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/gogits/gogs/archive
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = native/go

HOMEPAGE = http://gogs.io/
COMMENT  = Gogs(Go Git Service) is a painless self-hosted Git Service written in Go
LICENSE  =

CONFIGURE_TARGET = myConf
COMPILE_TARGET = myComp
INSTALL_TARGET = myInstall

GOOS = linux
# set this to 1 to create static linked binaries
STATIC_BINARIES = 1

# Define GOARCH (todo: optimize flags for armv7 etc)
ifeq ($(findstring $(ARCH),88f5281 88f6281),$(ARCH))
GOARCH = arm
endif
ifeq ($(findstring $(ARCH),armada370 armadaxp),$(ARCH))
GOARCH = arm
endif
ifeq ($(findstring $(ARCH),evansport),$(ARCH))
GOARCH = 386
endif
ifeq ($(findstring $(ARCH),x86 cedarview bromolow),$(ARCH))
GOARCH = amd64
endif
ifeq ($(GOARCH),)
$(error Unsupported ARCH $(ARCH))
endif


include ../../mk/spksrc.cross-cc.mk

ENV += GOPATH=$(WORK_DIR)/../../../native/go/work-native/go/
ENV += PATH=$(WORK_DIR)/../../../native/go/work-native/go/bin/:$$PATH

#Build with sqlite and certificate support
CONF_ARGS = -v -tags "sqlite cert"

ifeq ($(strip $(STATIC_BINARIES)),1)
ENV += CGO_ENABLED=1
endif

ENV += GOOS=$(GOOS) GOARCH=$(GOARCH)

myConf:
	#go is particular about file locations so we have to link it to the native directory to work!
	rm -f $(WORK_DIR)/../../../native/go/work-native/go/src/github.com/gogits/gogs
	mkdir -p $(WORK_DIR)/../../../native/go/work-native/go/src/github.com/gogits/
	ln -sf $(WORK_DIR)/$(PKG_DIR) $(WORK_DIR)/../../../native/go/work-native/go/src/github.com/gogits/gogs


myComp:
	$(RUN) go get github.com/mattn/go-sqlite3
	$(RUN) go build $(CONF_ARGS)

myInstall:
	mkdir -p $(STAGING_INSTALL_PREFIX)/bin
	install -m 755 $(WORK_DIR)/$(PKG_DIR)/$(PKG_NAME)-$(PKG_VERS) $(STAGING_INSTALL_PREFIX)/bin/$(PKG_NAME)
	#Copy needed stuff to bin dir (gogs loads templates releative to binary)
	cp -r $(WORK_DIR)/$(PKG_DIR)/conf $(STAGING_INSTALL_PREFIX)/bin/conf
	cp -r $(WORK_DIR)/$(PKG_DIR)/templates $(STAGING_INSTALL_PREFIX)/bin/templates
	cp -r $(WORK_DIR)/$(PKG_DIR)/public $(STAGING_INSTALL_PREFIX)/bin/public


