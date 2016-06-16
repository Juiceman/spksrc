#!/bin/sh

set -e

PHP="php -d open_basedir= -d include_path=/usr/local/nzedb/share/pear -d memory_limit=256M"
SCRIPTS_PATH="/var/services/web/nzedb/misc/update"
CONFIG_PATH="/var/services/web/nzedb/nzedb/config/settings.php"
TEST_PATH="/var/services/web/nzedb/misc/testing"
SLEEP_TIME="60"
LASTOPTIMIZE=`date +%s`
LASTOPTIMIZE1=`date +%s`

# Wait for the config.php to be created
while [ ! -f ${CONFIG_PATH} ]; do
  echo "Waiting for the configuration file to be created"
  sleep 10
done

# Main loop
while true; do
  CURRTIME=`date +%s`
  cd ${SCRIPTS_PATH}

  ${PHP} ${SCRIPTS_PATH}/nntpproxy.php

  # Update
  ${PHP} ${SCRIPTS_PATH}/update_binaries.php
  ${PHP} ${SCRIPTS_PATH}/update_releases.php 1 true

  # Optimize

  cd ${TEST_PATH}
  DIFF=$(($CURRTIME-$LASTOPTIMIZE))
  if [ "$DIFF" -gt 900 ] || [ "$DIFF" -lt 1 ]; then
    LASTOPTIMIZE=`date +%s`
    echo "Cleaning DB..."
    $PHP ${TEST_PATH}/Release/fixReleaseNames.php 1 true all yes
    $PHP ${TEST_PATH}/Release/fixReleaseNames.php 3 true other yes
    $PHP ${TEST_PATH}/Release/fixReleaseNames.php 5 true other yes
    $PHP ${TEST_PATH}/Release/removeCrapReleases.php true 2
  fi

  cd ${NZEDB_PATH}
  DIFF=$(($CURRTIME-$LASTOPTIMIZE1))
  if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]; then
    LASTOPTIMIZE1=`date +%s`
    echo "Optimizing DB..."
    $PHP ${SCRIPTS_PATH}/optimise_db.php space
    $PHP ${SCRIPTS_PATH}/update_tvschedule.php
    $PHP ${SCRIPTS_PATH}/update_theaters.php
  fi


  # Wait
  echo "Waiting ${SLEEP_TIME} seconds..."
  sleep ${SLEEP_TIME}
done
