SPK_NAME = plexivity
SPK_VERS = 0.9.2-1
SPK_REV = 5
SPK_ICON = src/plexivity.png
DSM_UI_DIR = app
BETA = 1
DEPENDS  = 
SPK_DEPENDS = "python>2.7.3-3"


MAINTAINER = cytec
DESCRIPTION = plexivity is a simple alternative for plexWatch. It connects with your Plex Media Server and is able to notify you on activity.
ADMIN_PORT = 6060
RELOAD_UI = yes
DISPLAY_NAME = plexivity

HOMEPAGE   = http://raphaelmutschler.de/plexivity/
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)
COPY_TARGET = nop

POST_STRIP_TARGET = plexivity_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: plexivity_extra_install
plexivity_extra_install: $(STAGING_DIR)/share/plexivity
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/app
	install -m 600 src/settings.conf $(STAGING_DIR)/var/config.ini
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/plexivity:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone https://bitbucket.org/raphaelmutschler/plexivity.git plexivity 
	cd $(STAGING_DIR)/share/plexivity && git checkout 0.9.2-1
	cd $(STAGING_DIR)/share/plexivity && rm -rf .git && rm .gitignore
	@$(MSG) "Bundling requirements"
	@cd $(WORK_DIR) && $(PIP) bundle --no-use-wheel -r $(STAGING_DIR)/share/plexivity/requirements.txt $(STAGING_DIR)/share/requirements.pybundle
