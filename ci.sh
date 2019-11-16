#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.29

#
# PARAMETERS
#    --full-set        - full set with AIQA system
#    --predict         - prediction by AIQA system
#    --predict-divided - prediction by AIQA system with division of the case
#    --rerun           - run only the tests that failed in the previous run
#
# By default (i.e. without any parameters): local run, full set.
#

source _ci_vars.sh

CI_CURRENT_RUN=${CI_DEFAULT_RUN}

if [ $# -eq 1 ]; then
    CI_CURRENT_RUN=$1
fi

echo "==============================================================="
echo CURRENT RUN: ${CI_CURRENT_RUN}
echo "==============================================================="

if [ ! -f "aiqa.yml" ]; then
    cp aiqa.yml.dist aiqa.yml
fi

if [ ${CI_CUSTOM_RELOAD} -eq 1 ]; then
    ./_ci_reload.sh
fi

if [ ${CI_CUSTOM_BUILD} -eq 1 ]; then
    ./_ci_build.sh
fi

if [ -z "${CI_CURRENT_RUN}" ]; then
    ./_ci_find_local_tests.sh
    ./_ci_run_tests_with_parallel.sh
    ./_ci_verify_tests_results.sh
    exit
fi

./_ci_aiqa.sh ${CI_CURRENT_RUN}

echo "==============================================================="
echo CURRENT RUN: ${CI_CURRENT_RUN}
echo "==============================================================="

exit $?

# vim:ts=4:sw=4:et:syn=sh: