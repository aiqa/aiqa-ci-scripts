#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.25

source _ci_vars.sh

CMD_PARAM=
if [ "$1" == "--predict" ]; then
    CMD_PARAM="--predict"
fi
if [ "$1" == "--predict-divided" ]; then
    CMD_PARAM="--predict-divided"
fi

if [ ! "$1" == "--rerun" ]; then
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
else
    echo "==============================================================="
    echo "RERUN: build:failedTests"
    aiqa build:failedTests > ${CI_SCENARIOS_LIST_FILENAME}
fi

echo ""
echo ""
__NUMBER_OF_PREDICTED_TESTS=$(cat ${CI_SCENARIOS_LIST_FILENAME} | wc -l)
echo "NUMBER OF PREDICTED TESTS: ${__NUMBER_OF_PREDICTED_TESTS}"
echo ""
cat ${CI_SCENARIOS_LIST_FILENAME}
echo ""
echo "NUMBER OF PREDICTED TESTS: ${__NUMBER_OF_PREDICTED_TESTS}"
echo "==============================================================="
echo "START: run tests with parallel"
time ./_ci_run_tests_with_parallel.sh ${CMD_PARAM}
echo "==============================================================="
echo "START: verify results"
./_ci_verify_tests_results.sh

CI_FINAL_TEST_RESULT=$?

if [ ! "$1" == "--rerun" ]; then
    echo "==============================================================="
    aiqa build:stop
fi

exit ${CI_FINAL_TEST_RESULT}
# vim:ts=4:sw=4:et:syn=sh: