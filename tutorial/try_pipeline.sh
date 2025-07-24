#!/bin/sh

###############################################################################
#                                                                             #
# Copyright 2025 Simon Brandt                                                 #
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
# Last Modification: 2025-07-24

# Usage: Run this script with "sh test_pipeline.sh".

# Purpose: Demonstrate the functionality of the Argparser regarding the
# standalone mode as part of a pipeline.

# Run the Argparser in standalone mode from POSIX sh, reading from and
# writing to a pipe.
export ARGPARSER_SCRIPT_NAME="${0##*/}"
export ARGPARSER_WRITE_ARGS=true

# Define the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args='
    id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help
    pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice
    pos_2 |            |           | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice
    var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice
    var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice
    var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice
    var_4 | d          |           | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice
    var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default
    var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default
    var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default
'

if [ "$1" = "--help" ] \
    || [ "$1" = "-h" ] \
    || [ "$1" = "--usage" ] \
    || [ "$1" = "-u" ] \
    || [ "$1" = "--version" ] \
    || [ "$1" = "-V" ]
then
    printf '%s' "${args}" | argparser -- "$@"
else
    eval "$(printf '%s' "${args}" | argparser -- "$@" | tee /dev/stderr)"
fi

# The arguments can now be accessed as variables from the environment.
# In case of errors, eval hasn't been able to set them, thus the tested
# expansion ${var_1+set} will be empty, so nothing would get printed.

# shellcheck disable=SC2154  # Implicitly set variables through eval.
if [ -n "${var_1+set}" ]; then
    printf 'The keyword argument "var_1" is set to "%s".\n' "${var_1}"
    printf 'The keyword argument "var_2" is set to "%s".\n' "${var_2}"
    printf 'The keyword argument "var_3" is set to "%s".\n' "${var_3}"
    printf 'The keyword argument "var_4" is set to "%s".\n' "${var_4}"
    printf 'The keyword argument "var_5" is set to "%s".\n' "${var_5}"
    printf 'The keyword argument "var_6" is set to "%s".\n' "${var_6}"
    printf 'The keyword argument "var_7" is set to "%s".\n' "${var_7}"

    printf 'The positional argument "pos_1" on index 1 is set to "%s".\n' \
        "${pos_1}"
    printf 'The positional argument "pos_2" on index 2 is set to "%s".\n' \
        "${pos_2}"
fi | sort
