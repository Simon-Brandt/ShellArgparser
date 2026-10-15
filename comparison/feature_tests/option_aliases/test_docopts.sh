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
# Last Modification: 2026-10-15

# Usage (from wrapper): Run this script from test_features.sh as
# bash test_features.sh \
#     --test-docopts \
#     --test-option-aliases

# Usage:
#   test_docopts.sh -v VAL --var=VAL
#
# Options:
#   -v VAL, --var=VAL  short/long option

# Purpose: Test whether docopts supports option aliases
# ("-a"/"-A"/"--arg").

# Parse the arguments.  Replace the short option name "-V" by the long
# option name "--var", since docopts fails parsing short option aliases,
# while still allowing aliases with long option names.  In order to be
# able to both set the arguments to variables and to ignore any "exit",
# define "exit" as alias for "return", such that the functions are
# halted, but the test doesn't abort.  Only the final check for the
# variables sets the test's result as exit code.
shopt -s expand_aliases
alias exit=return

set -- "${@/-V/--var}"

source docopts.sh --auto "$@" &> /dev/null || true

unalias exit

if [[ "${ARGS[--var,#]}" == 2 \
    && "${ARGS[--var,0]}" == 1 \
    && "${ARGS[--var,1]}" == 2 ]]
then
    exit 2  # Indicate partial support for feature.
fi
exit 1
