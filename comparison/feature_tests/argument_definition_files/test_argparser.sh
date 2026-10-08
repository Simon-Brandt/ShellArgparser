#!/usr/bin/env bash

###############################################################################
#                                                                             #
# Copyright 2026 Simon Brandt                                                 #
#                                                                             #
# Licensed under the Apache License, Version 2.0 (the "License");             #
# you may not use this file except in compliance with the License.            #
# You may obtain a copy of the License at                                     #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
# Unless required by applicable law or agreed to in writing, software         #
# distributed under the License is distributed on an "AS IS" BASIS,           #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    #
# See the License for the specific language governing permissions and         #
# limitations under the License.                                              #
#                                                                             #
###############################################################################

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2026-10-08

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-argparser \
#     --test-argument-definition-files

# Purpose: Test whether the Argparser supports argument definition
# files.

# Parse the arguments.  In order to be able to both set the arguments to
# variables and to ignore any "exit", define "exit" as alias for
# "return", such that the functions are halted, but the test doesn't
# abort.  Only the final check for the variables sets the test's result
# as exit code.
shopt -s expand_aliases
alias exit=return

ARGPARSER_ARG_DEF_FILE="$(dirname "$0")/arguments.csv"

# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    id
    var
)
source argparser -- "$@" &> /dev/null

unalias exit

if [[ "${var}" == 1 ]]; then
    exit 0
fi
exit 1
