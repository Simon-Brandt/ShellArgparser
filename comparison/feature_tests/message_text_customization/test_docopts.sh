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
#     --test-message-text-customization

# Usage:
#   test_docopts.sh -v VAL
#
# There is one required option to set:
#   -v VAL  short option
#
# You can request the help message by:
#   -h, --help  display this help and exit

# Purpose: Test whether docopts supports customizing the message text.

# Parse the arguments.  Since the test runs in a subshell, it is not
# necessary to define "exit" as alias for "return".  Then, the final
# check for the variables sets the test's result as exit code.
actual_output="$(source docopts.sh --auto "$@" 2> /dev/null)"

expected_output="$(cat << EOF
Usage:
  test_docopts.sh -v VAL

There is one required option to set:
  -v VAL  short option

You can request the help message by:
  -h, --help  display this help and exit
EOF
)"

if [[ "${actual_output}" == "${expected_output}" ]]; then
    exit 0
fi
exit 1
