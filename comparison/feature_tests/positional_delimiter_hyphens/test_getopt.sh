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
#     --test-getopt \
#     --test-positional-delimiter-hyphens

# Purpose: Test whether getopt supports the positional arguments
# delimiter "--".

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
if ! args="$(getopt --options="b:" -- "$@" 2> /dev/null)"; then
    exit 1
fi
eval set -- "${args}"

while true; do
    case "$1" in
        "-b")
            var_b="$2"
            shift 2
            ;;
        "--")
            shift
            break
            ;;
        *) exit 1 ;;
    esac
done

var_a=("$@")

if [[ "${#var_a[@]}" == 2 \
    && "${var_a[0]}" == "-a" \
    && "${var_a[1]}" == 1 \
    && "${var_b}" == 2 ]]
then
    exit 0
fi
exit 1
