#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.54

source _ci_vars.sh


CMD_PARAM=
if [ "$1" == "--full-set" ]; then
    CMD_PARAM="--strategy=full-set"
fi
if [ "$1" == "--all" ]; then
    CMD_PARAM="--strategy=all"
fi
if [ "$1" == "--rerun" ]; then
    CMD_PARAM="--strategy=rerun"
fi
if [ "$1" == "--none" ]; then
    CMD_PARAM="--strategy=none"
fi
if [ "$1" == "--one" ]; then
    CMD_PARAM="--strategy=one"
fi
if [ "$1" == "--random1" ]; then
    CMD_PARAM="--strategy=random1"
fi
if [ "$1" == "--random3" ]; then
    CMD_PARAM="--strategy=random3"
fi
if [ "$1" == "--predict" ]; then
    CMD_PARAM="--strategy=predict"
fi
if [ "$1" == "--predict-divided" ]; then
    CMD_PARAM="--strategy=predict-divided"
fi
if [ "$1" == "--smoke" ]; then
    CMD_PARAM="--strategy=smoke"
fi
if [ "$1" == "--knn" ]; then
    CMD_PARAM="--strategy=knn"
fi
if [ "$1" == "--srcTags" ]; then
    CMD_PARAM="--strategy=srcTags"
fi
if [ "$1" == "--predict-tags" ]; then
    CMD_PARAM="--strategy=predict-tags"
fi
if [ "$1" == "--knn-tags" ]; then
    CMD_PARAM="--strategy=knn-tags"
fi
if [ "$1" == "--history" ]; then
    CMD_PARAM="--strategy=history"
fi
if [ "$1" == "--map" ]; then
    CMD_PARAM="--strategy=map"
fi
if [ "$1" == "--sinceLastDump" ]; then
    CMD_PARAM="--strategy=sinceLastDump"
fi
if [ "$1" == "--recommendation" ]; then
    CMD_PARAM="--strategy=recommendation"
fi

if [ "$1" == "--local" ]; then
    ./_ci_find_local_tests.sh
    ./_ci_run_tests_with_parallel.sh
    ./_ci_verify_tests_results.sh
    exit
fi

aiqa build:start ${CMD_PARAM}
echo "==============================================================="
echo "START: initialize:tests"
aiqa initialize:tests

CI_FINAL_TEST_RESULT=$?
#echo "CI_FINAL_TEST_RESULT[_ci_aiqa.sh][AFTER aiqa initialize:tests] = ${CI_FINAL_TEST_RESULT}"
if [ "${CI_FINAL_TEST_RESULT}" -gt 0 ]; then
    exit ${CI_FINAL_TEST_RESULT}
fi

echo "==============================================================="
echo "START: initialize:src"
aiqa initialize:src

CI_FINAL_TEST_RESULT=$?
#echo "CI_FINAL_TEST_RESULT[_ci_aiqa.sh][AFTER aiqa initialize:src] = ${CI_FINAL_TEST_RESULT}"
if [ "${CI_FINAL_TEST_RESULT}" -gt 0 ]; then
    exit ${CI_FINAL_TEST_RESULT}
fi

echo "==============================================================="
echo "====> PREDICTION"
echo "build:testsToRun ${CMD_PARAM}"

if [ ! "$1" == "--rerun" ]; then
    aiqa build:testsToRun ${CMD_PARAM} > ${CI_SCENARIOS_LIST_FILENAME}
else
    echo "==============================================================="
    echo "RERUN: build:failedTests"
    aiqa build:failedTests > ${CI_SCENARIOS_LIST_FILENAME}
fi

if [ "${CMD_PARAM}" == "--strategy=map" ]; then
    echo "build:testsToRun --strategy=sinceLastDump"
    aiqa build:testsToRun --strategy=sinceLastDump >> ${CI_SCENARIOS_LIST_FILENAME}

    cat ${CI_SCENARIOS_LIST_FILENAME} | sort | uniq > __ci_tmp_file.txt
    cat __ci_tmp_file.txt > ${CI_SCENARIOS_LIST_FILENAME}
    rm __ci_tmp_file.txt
fi

CI_FINAL_TEST_RESULT=$?
#echo "CI_FINAL_TEST_RESULT[_ci_aiqa.sh][AFTER build:testsToRun] = ${CI_FINAL_TEST_RESULT}"
if [ "${CI_FINAL_TEST_RESULT}" -gt 0 ]; then
    exit ${CI_FINAL_TEST_RESULT}
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

#echo "CI_FINAL_TEST_RESULT[_ci_aiqa.sh] = ${CI_FINAL_TEST_RESULT}"

echo "==============================================================="
aiqa build:stop

exit ${CI_FINAL_TEST_RESULT}
# vim:ts=4:sw=4:et:syn=sh: