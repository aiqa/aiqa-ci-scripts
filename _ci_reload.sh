#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.54

source _ci_vars.sh

if ! [ -x "$(command -v vagrant)" ]; then
  if [ "vagrant" == "$(whoami)" ]; then
    /app/${CI_BACKEND_DIR}/reload.sh
  fi
  exit
fi

exec vagrant ssh -c "/app/${CI_BACKEND_DIR}/reload.sh"

