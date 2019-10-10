#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.19

source _ci_vars.sh

NUMBER_OF_PARALLEL_LOG_ENTRIES=$(cat "${CI_PARALLEL_LOG_FILENAME}" | wc -l)
NUMBER_OF_PARALLEL_LOG_ENTRIES=$((NUMBER_OF_PARALLEL_LOG_ENTRIES - 1))
NUMBER_OF_SCENARIO_FILES=$(cat ${CI_SCENARIOS_LIST_FILENAME} | wc -l)
NUMBER_OF_ERRORS=$(cat "${CI_PARALLEL_LOG_FILENAME}" | tail -n "$NUMBER_OF_SCENARIO_FILES" | awk '{print $7}' | grep '1' | wc -l)

echo
echo "Number of parallel log entries: " $NUMBER_OF_PARALLEL_LOG_ENTRIES
echo "Number of scenarios:            " $NUMBER_OF_SCENARIO_FILES
echo "Number of errors:               " $NUMBER_OF_ERRORS
echo

echo "0" > ${CI_FINAL_TEST_RESULT_FILENAME}

if [ "$NUMBER_OF_ERRORS" -gt 0 ]; then
    echo "1" > ${CI_FINAL_TEST_RESULT_FILENAME}
fi

# vim:ts=4:sw=4:et:syn=sh:
