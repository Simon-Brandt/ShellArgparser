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
#     --test-help-message

# Purpose: Test whether shFlags creates a help message.

# Parse the arguments.  Since the test runs in a subshell, it is not
# necessary to define "exit" as alias for "return".  Then, the final
# check for the variables sets the test's result as exit code.
{
    source shflags

    # shellcheck disable=SC2034  # Intentionally unused variable.
    DEFINE_string "v" "" "short option" "v"
} &> /dev/null

actual_output="$(FLAGS "$@" 2>&1 > /dev/null)"

expected_output="$(cat << EOF
USAGE: $0 [flags] args
flags:
  -v,--v:  short option (default: '')
  -h,--help:  show this help (default: false)
EOF
)"

if [[ "${actual_output}" == "${expected_output}" ]]; then
    exit 0
fi
exit 1
