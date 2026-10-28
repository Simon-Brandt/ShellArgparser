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
#     --test-getopts \
#     --test-choice-values

# Purpose: Test whether getopts supports choice values.

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.

# shellcheck disable=SC2034  # Intentionally unused variable.
error="$(getopts "v:" arg "$@" 2>&1 > /dev/null)"

if [[ "${error}" == *"test_getopts.sh:"* ]]; then
    exit 0
fi
exit 1
