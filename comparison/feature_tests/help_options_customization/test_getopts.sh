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
#     --test-help-options-customization

# Purpose: Test whether getopts supports customizing the help options.

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
while getopts "v:H" arg "$@" &> /dev/null; do
    # shellcheck disable=SC2034  # Intentionally unused variable.
    case "${arg}" in
        "v") var="${OPTARG}" ;;
        "H") output="Usage: test_getopts.sh [-H] -v=VAL" ;;
        *) exit 1 ;;
    esac
done

shift "$(( OPTIND - 1 ))"

if [[ "${output}" == "Usage: test_getopts.sh [-H] -v=VAL" ]]; then
    exit 2  # Indicate partial support for feature.
fi
exit 1
