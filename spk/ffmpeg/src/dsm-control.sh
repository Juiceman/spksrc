#!/bin/sh

# Package
PACKAGE="ffmpeg"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}/bin/"
LINK_TARGET="/usr/bin/${PACKAGE}"

FFPROBE_TARGET="/usr/bin/ffprobe"

start_daemon ()
{
    if [ ! -e "${LINK_TARGET}" ]; then
        ln -s ${INSTALL_DIR}/ffmpeg ${LINK_TARGET}
    fi
    if [ ! -e "${FFPROBE_TARGET}" ]; then
        ln -s ${INSTALL_DIR}/ffprobe ${FFPROBE_TARGET}
    fi
}

stop_daemon ()
{
    rm -f ${LINK_TARGET}
    rm -f ${FFPROBE_TARGET}
}


case $1 in
    start)
        start_daemon
        exit 0
    ;;
    stop)
        stop_daemon
        exit 0
    ;;
    status)
    if [ -e ${LINK_TARGET} ]; then
        exit 0
    else
        exit 1
    fi
    ;;
    log)
        exit 0
    ;;
esac
