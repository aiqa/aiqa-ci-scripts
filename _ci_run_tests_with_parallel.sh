#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.8

source _ci_vars.sh

___CMD_PARAM=
if [ "$1" == "--predict" ]; then
    # max: 5 failures
    ___CMD_PARAM="--halt soon,fail=5"

    # max:10% failures
    #___CMD_PARAM="--halt soon,fail=10%"
fi

rm -f ${CI_PARALLEL_LOG_FILENAME}

time cat ${CI_SCENARIOS_LIST_FILENAME} | parallel ${CI_PARALLEL_NUMBER_OF_THREADS} ${___CMD_PARAM} --joblog ${CI_PARALLEL_LOG_FILENAME} --gnu ${CI_TEST_RUNNER_COMMAND}

# vim:ts=4:sw=4:et:syn=sh:
