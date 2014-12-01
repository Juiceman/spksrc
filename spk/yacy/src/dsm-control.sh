#!/bin/sh

# Package
PACKAGE="yacy"
DNAME="YaCy"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:/var/packages/JavaManager/target/Java/bin/:${PATH}"
USER="yacy"
YACY_DIR="${INSTALL_DIR}/share/"


start_daemon ()
{
    ${YACY_DIR}/startYACY.sh > /dev/null 2>&1 &
    #start-stop-daemon -b -o -c ${USER} -S -u ${USER} -x ${SYNCTHING} -- --home ${CONFIG_DIR}
    #su - ${USER} -c "PATH=${PATH} ${SYNCTHING} --home ${CONFIG_DIR}"
}

stop_daemon ()
{
    # Kill the application
    #kill `ps w | grep ${PACKAGE} | grep -v -E 'stop|grep' | awk '{print $1}'`
    #start-stop-daemon -o -c ${USER} -K -u ${USER} -x ${SYNCTHING} -- --home ${CONFIG_DIR}
    ${YACY_DIR}/stopYACY.sh > /dev/null 2>&1 &
}

daemon_status ()
{
   if [ -e ${YACY_DIR}/DATA/yacy.running ]; then
                return 0
        else
                return 1
        fi
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
        exit 1
        ;;
    *)
        exit 1
        ;;
esac
