#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.54

source _ci_vars.sh

___CI_PARALLEL_EXIT_STRATEGY=
if [ "$1" == "--strategy=predict" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=knn" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=predict-divided" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=predict-tags" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=knn-tags" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=history" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

if [ "$1" == "--strategy=recommendation" ]; then
    ___CI_PARALLEL_EXIT_STRATEGY=${CI_PARALLEL_EXIT_STRATEGY}
fi

rm -f ${CI_PARALLEL_LOG_FILENAME}

set -x

time cat ${CI_SCENARIOS_LIST_FILENAME} | sort | uniq | parallel --shuf ${CI_PARALLEL_NUMBER_OF_THREADS} ${___CI_PARALLEL_EXIT_STRATEGY} --joblog ${CI_PARALLEL_LOG_FILENAME} --gnu ${CI_TEST_RUNNER_COMMAND}

# vim:ts=4:sw=4:et:syn=sh:
