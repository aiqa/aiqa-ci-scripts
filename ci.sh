#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.8

#
# PARAMETERS
#    --full-set  - full set with AIQA system
#    --predict   - prediction by AIQA system
#
# By default: local, full set.
#

source _ci_vars.sh

./_ci_reload.sh

if [ $# -eq 0 ]; then
    ./_ci_find_local_tests.sh
    ./_ci_run_tests_with_parallel.sh
    ./_ci_verify_tests_results.sh
    exit
fi

./_ci_aiqa.sh $1

# vim:ts=4:sw=4:et:syn=sh: