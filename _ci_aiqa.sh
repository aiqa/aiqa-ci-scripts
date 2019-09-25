#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.13

#
# PARAMETERS
#    --full-set  - full set with AIQA system
#    --predict   - prediction by AIQA system
#
# By default: local, full set.
#

source _ci_vars.sh

CMD_PARAM=
if [ "$1" == "--predict" ]; then
    CMD_PARAM="--predict"
fi

aiqa build:start ${CMD_PARAM}
echo "==============================================================="
echo "START: initialize:tests"
time aiqa initialize:tests
echo "==============================================================="
echo "START: initialize:src"
time aiqa initialize:src
echo "==============================================================="
echo "START: build:testsToRun"
aiqa build:testsToRun ${CMD_PARAM} > ${CI_SCENARIOS_LIST_FILENAME}
echo "==============================================================="
echo "START: run tests with parallel"
time ./_ci_run_tests_with_parallel.sh ${CMD_PARAM}
echo "==============================================================="
echo "START: verify results"
./_ci_verify_tests_results.sh
echo "==============================================================="
aiqa build:stop

# vim:ts=4:sw=4:et:syn=sh: