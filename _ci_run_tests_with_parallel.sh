#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.34

source _ci_vars.sh

___CI_PARALLEL_EXIT_STRATEGY=
if [ "$1" == "--predict" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--predict-divided" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

rm -f ${CI_PARALLEL_LOG_FILENAME}

set -x

time cat ${CI_SCENARIOS_LIST_FILENAME} | parallel ${CI_PARALLEL_NUMBER_OF_THREADS} ${___CI_PARALLEL_EXIT_STRATEGY} --joblog ${CI_PARALLEL_LOG_FILENAME} --gnu ${CI_TEST_RUNNER_COMMAND}

# vim:ts=4:sw=4:et:syn=sh:
