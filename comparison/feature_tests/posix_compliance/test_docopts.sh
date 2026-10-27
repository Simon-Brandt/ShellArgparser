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
# Last Modification: 2026-10-27

# Usage (from wrapper): Run this script from test_features.sh as
# bash test_features.sh \
#     --test-docopts \
#     --test-posix-compliance

# Usage:
#   test_docopts.sh [-a] [<var_c>] [-b] [<var_c>]
#
# Positional arguments:
#   <var_c>  positional argument
#
# Options:
#   -a  flag
#   -b  flag

# Purpose: Test whether docopts is POSIX-compliant.

# Parse the arguments.  In order to be able to both set the arguments to
# variables and to ignore any "exit", define "exit" as alias for
# "return", such that the functions are halted, but the test doesn't
# abort.  Only the final check for the variables sets the test's result
# as exit code.
shopt -s expand_aliases
alias exit=return

POSIXLY_CORRECT=1

source docopts.sh --auto "$@" &> /dev/null || true

unalias exit

if [[ "${ARGS[-a]}" == true \
    && "${ARGS[-b]}" == false \
    && "${ARGS[<var_c>,#]}" == 3 \
    && "${ARGS[<var_c>,0]}" == 1 \
    && "${ARGS[<var_c>,1]}" == "-b" \
    && "${ARGS[<var_c>,2]}" == 2 ]]
then
    exit 0
fi
exit 1
