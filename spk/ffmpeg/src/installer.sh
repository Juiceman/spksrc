#!/bin/sh

# Package
PACKAGE="ffmpeg"

LINK_TARGET="/usr/bin/${PACKAGE}"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"

FFPROBE_TARGET="/usr/bin/ffprobe"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}
    if [ ! -e "$LINK_TARGET" ]; then
            ln -s ${INSTALL_DIR}/bin/ffmpeg ${LINK_TARGET}
            ln -s ${INSTALL_DIR}/bin/ffprobe ${FFPROBE_TARGET}
    fi
    exit 0
}

preuninst ()
{
    rm -f ${LINK_TARGET}
    rm -f ${FFPROBE_TARGET}
    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}

    exit 0
}

preupgrade ()
{
    exit 0
}

postupgrade ()
{
    exit 0
}

