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
# Last Modification: 2026-10-22

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-shflags \
#     --test-option-aliases

# Purpose: Test whether shFlags supports option aliases
# ("-a"/"-A"/"--arg").

# Parse the arguments.  In order to be able to both set the arguments to
# variables and to ignore any "exit", define "exit" as alias for
# "return", such that the functions are halted, but the test doesn't
# abort.  Only the final check for the variables sets the test's result
# as exit code.
shopt -s expand_aliases
alias exit=return

{
    source shflags

    DEFINE_string "v" "" "short option" "v"
    DEFINE_string "v" "" "short option" "V"

    FLAGS "$@"
    eval set -- "${FLAGS_ARGV}"
} &> /dev/null

unalias exit

if [[ "${#FLAGS_v[@]}" == 2 && "${FLAGS_v[0]}" == 1 && "${FLAGS_v[1]}" == 2 ]]
then
    exit 0
fi
exit 1
