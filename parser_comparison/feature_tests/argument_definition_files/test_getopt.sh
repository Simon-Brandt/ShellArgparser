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
#     --test-argument-definition-files

# Purpose: Test whether getopt supports argument definition files.

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
if ! args="$(getopt --options="a:b" -- "$@" 2> /dev/null)"; then
    exit 1
fi
eval set -- "${args}"

source "$(dirname "$0")/arguments_getopt.sh"

var_b=false

while true; do
    case "$1" in
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

if [[ "${var_a}" == 1 \
    && "${var_b}" == true \
    && "${#var_c[@]}" == 2 \
    && "${var_c[0]}" == 2 \
    && "${var_c[1]}" == 3 ]]
then
    exit 2  # Indicate partial support for feature.
fi
exit 1
