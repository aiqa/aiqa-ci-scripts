#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.54

source _ci_vars.sh

NUMBER_OF_PARALLEL_LOG_ENTRIES=$(cat "${CI_PARALLEL_LOG_FILENAME}" | wc -l)
NUMBER_OF_PARALLEL_LOG_ENTRIES=$((NUMBER_OF_PARALLEL_LOG_ENTRIES - 1))
NUMBER_OF_SCENARIO_FILES=$(cat ${CI_SCENARIOS_LIST_FILENAME} | wc -l)
NUMBER_OF_ERRORS=$(cat "${CI_PARALLEL_LOG_FILENAME}" | tail -n "$NUMBER_OF_SCENARIO_FILES" | awk '{print $7}' | grep '1' | wc -l)

echo
echo "Number of predicted tests:      " $NUMBER_OF_SCENARIO_FILES
echo "Number of executed tests:       " $NUMBER_OF_PARALLEL_LOG_ENTRIES
echo "Number of errors:               " $NUMBER_OF_ERRORS
echo

CI_FINAL_TEST_RESULT=0

if [ "$NUMBER_OF_ERRORS" -gt 0 ]; then
    CI_FINAL_TEST_RESULT=1
fi

#echo "CI_FINAL_TEST_RESULT[_ci_verify_tests_results.sh] = ${CI_FINAL_TEST_RESULT}"

exit ${CI_FINAL_TEST_RESULT}

# vim:ts=4:sw=4:et:syn=sh:
