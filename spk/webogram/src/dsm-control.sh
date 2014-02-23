#!/bin/sh

# Package
PACKAGE="webogram"
DNAME="webogram"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
NODE_DIR="/usr/local/node"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/env/bin:${NODE_DIR}/bin:/usr/local/bin:/bin:/usr/bin:/usr/syno/bin"
USER="webogram"
NODE="${NODE_DIR}/bin/node"
WEBOGRAM="${INSTALL_DIR}/share/webogram/server.js"

start_daemon ()
{
    su - ${USER} -c "PATH=${PATH} ${NODE} ${WEBOGRAM}"
}

stop_daemon ()
{
    kill `ps | grep "${WEBOGRAM}" | grep -v grep | cut -c2-6`
    wait_for_status 1 20 || kill -9 `ps | grep "${WEBOGRAM}" | grep -v grep | cut -c2-6`
}

daemon_status ()
{
    if  kill -0 `ps | grep "${WEBOGRAM}" | grep -v grep | cut -c2-6` > /dev/null 2>&1; then
        return
    fi
    return 1
}

wait_for_status ()
{
    counter=$2
    while [ ${counter} -gt 0 ]; do
        daemon_status
        [ $? -eq $1 ] && return
        let counter=counter-1
        sleep 1
    done
    return 1
}


case $1 in
    start)
        if daemon_status; then
            echo ${DNAME} is already running
        else
            echo Starting ${DNAME} ...
            start_daemon
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
        else
            echo ${DNAME} is not running
        fi
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    log)
        echo ${LOG_FILE}
        ;;
    *)
        exit 1
        ;;
esac
