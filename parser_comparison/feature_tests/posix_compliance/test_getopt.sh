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
# Last Modification: 2026-10-28

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-getopt \
#     --test-posix-compliance

# Purpose: Test whether getopt is POSIX-compliant.

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
export POSIXLY_CORRECT=1

if ! args="$(getopt --options="ab" -- "$@" 2> /dev/null)"; then
    exit 1
fi
eval set -- "${args}"

var_a=false
var_b=false

while true; do
    case "$1" in
        "-a")
            var_a=true
            shift
            ;;
        "-b")
            var_b=true
            shift
            ;;
        "--")
            shift
            break
            ;;
        *) exit 1 ;;
    esac
done

var_c=("$@")

if [[ "${var_a}" == true \
    && "${var_b}" == false \
    && "${#var_c[@]}" == 3 \
    && "${var_c[0]}" == 1 \
    && "${var_c[1]}" == "-b" \
    && "${var_c[2]}" == 2 ]]
then
    exit 2  # Indicate partial support for feature.
fi
exit 1
