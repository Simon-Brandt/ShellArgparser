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
# Last Modification: 2026-10-07

# Usage: Run this script from test_features.sh as
# "bash test_features.sh --test-help-message".

# Purpose: Test whether the Argparser creates a help message.

# Parse the arguments.  Since the test runs in a subshell, it is not
# necessary to define "exit" as alias for "return".  Then, the final
# check for the variables sets the test's result as exit code.

# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id  | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group | notes | help        "
    "var | v          |           | VAL       |          |         | str  | 1      | Options   |       | short option"
)
actual_output="$(source argparser -- "$@" 2> /dev/null)"

expected_output="$(cat << EOF
Usage: test_argparser.sh ARGUMENTS

Mandatory arguments to long options are mandatory for short options too.

+- Options -----------------------------------------------------------+
| -v=VAL                short option                                  |
+---------------------------------------------------------------------+

+- Help options ------------------------------------------------------+
| [-h, -?], [--help]    display this help and exit (default: false)   |
| [-u],     [--usage]   display the usage and exit (default: false)   |
| [-V],     [--version] display the version and exit (default: false) |
+---------------------------------------------------------------------+
EOF
)"

if [[ "${actual_output}" == "${expected_output}" ]]; then
    exit 0
fi
exit 1
