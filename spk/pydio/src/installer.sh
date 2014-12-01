#!/bin/sh

# Package
PACKAGE="pydio"
DNAME="Pydio"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
WEB_DIR="/var/services/web"
USER="$([ $(grep buildnumber /etc.defaults/VERSION | cut -d"\"" -f2) -ge 4418 ] && echo -n http || echo -n nobody)"
MYSQL="/usr/syno/mysql/bin/mysql"
MYSQL_USER="pydio"
MYSQL_DATABASE="pydio"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"


preinst ()
{

    # Check database
    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        if ! ${MYSQL} -u root -p"${wizard_mysql_password_root}" -e quit > /dev/null 2>&1; then
            echo "Incorrect MySQL root password"
            exit 1
        fi
        if ${MYSQL} -u root -p"${wizard_mysql_password_root}" mysql -e "SELECT User FROM user" | grep ^${MYSQL_USER}$ > /dev/null 2>&1; then
            echo "MySQL user ${MYSQL_USER} already exists"
            exit 1
        fi
        if ${MYSQL} -u root -p"${wizard_mysql_password_root}" -e "SHOW DATABASES" | grep ^${MYSQL_DATABASE}$ > /dev/null 2>&1; then
            echo "MySQL database ${MYSQL_DATABASE} already exists"
            exit 1
        fi

        # Check directory
        if [ ! -d ${wizard_pydio_datadirectory:=/volume1/pydio} ]; then
            echo "Directory does not exist"
            exit 1
        fi

    fi

    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    # Install the web interface
    cp -pR ${INSTALL_DIR}/share/${PACKAGE} ${WEB_DIR}

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        ${MYSQL} -u root -p"${wizard_mysql_password_root}" -e "CREATE DATABASE ${MYSQL_DATABASE}; GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${wizard_mysql_password_pydio}';"
        sed -i "s#AJXP_INSTALL_PATH.\"/data\"#\"${wizard_pydio_datadirectory:=/volume1/pydio}/data\"#g" ${WEB_DIR}/${PACKAGE}/conf/bootstrap_context.php
        sed -i "s#AJXP_INSTALL_PATH.\"/data/cache\"#\"${wizard_pydio_datadirectory:=/volume1/pydio}/data/cache\"#g" ${WEB_DIR}/${PACKAGE}/conf/bootstrap_context.php
        sed -i "s#AJXP_DATA_PATH.\"/cache\"#\"${wizard_pydio_datadirectory:=/volume1/pydio}/cache\"#g" ${WEB_DIR}/${PACKAGE}/conf/bootstrap_context.php
    fi

    #copy data dirs to user selected stuff and create cache dir
    cp -pR ${INSTALL_DIR}/share/${PACKAGE}/data "${wizard_pydio_datadirectory:=/volume1/pydio}"
    mkdir "${wizard_pydio_datadirectory:=/volume1/pydio}"/cache

    #skip installation prompt
    #touch "${wizard_pydio_datadirectory:=/volume1/pydio}"/cache/admin_counted
    #touch "${wizard_pydio_datadirectory:=/volume1/pydio}"/cache/first_run_passed
    #touch "${wizard_pydio_datadirectory:=/volume1/pydio}"/cache/diag_result.php

    # Fix permissions
    chown -R ${USER} ${WEB_DIR}/${PACKAGE}
    chown -R ${USER} "${wizard_pydio_datadirectory:=/volume1/pydio}"

    exit 0
}

preuninst ()
{
    # Check database
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" -a "${wizard_remove_database}" == "true" ] && ! ${MYSQL} -u root -p"${wizard_mysql_password_root}" -e quit > /dev/null 2>&1; then
        echo "Incorrect MySQL root password"
        exit 1
    fi
    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}

    # Remove database
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" -a "${wizard_remove_database}" == "true" ]; then
        ${MYSQL} -u root -p"${wizard_mysql_password_root}" -e "DROP DATABASE ${MYSQL_DATABASE}; DROP USER '${MYSQL_USER}'@'localhost';"
    fi

    # Remove the web interface
    rm -fr ${WEB_DIR}/${PACKAGE}

    exit 0
}

preupgrade ()
{
    #save config and data files
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${WEB_DIR}/${PACKAGE}/conf ${TMP_DIR}/${PACKAGE}/
    mv ${WEB_DIR}/${PACKAGE}/data ${TMP_DIR}/${PACKAGE}/
    exit 0
}

postupgrade ()
{
    #restore config and data files
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}

    #must delete data dir before move it back
    rm -rf ${WEB_DIR}/${PACKAGE}/data/
    mv ${TMP_DIR}/${PACKAGE}/conf ${WEB_DIR}/${PACKAGE}/conf
    mv ${TMP_DIR}/${PACKAGE}/data ${WEB_DIR}/${PACKAGE}/data
    exit 0
}
