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
#     --test-argument-definition-files

# Purpose: Test whether docopts supports argument definition files.

# Parse the arguments.  Since the test runs in a subshell, it is not
# necessary to define "exit" as alias for "return".  Then, the final
# check for the variables sets the test's result as exit code.
help="$(< "$(dirname "$0")/arguments_docopts.txt")"
eval "$(docopts -A ARGS --help="${help}" : "$@" 2> /dev/null)"

if [[ "${ARGS[-v]}" == 1 ]]; then
    exit 2  # Indicate partial support for feature.
fi
exit 1
