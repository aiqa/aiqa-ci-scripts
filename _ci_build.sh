#!/usr/bin/env bash

# AIQA CI SCRIPTS
# https://aiqa.tech
#
# (c)2019 AIQA Technologies
#
# ver. 0.1.54

source _ci_vars.sh

echo "========================>CUSTOM BUILD/START<========================"
cd ../frontend
yarn
yarn build
cd ../cypress

yarn

echo "========================>CUSTOM BUILD/STOP<========================"
