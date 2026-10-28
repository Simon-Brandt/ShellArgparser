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
#     --test-parsing-configuration

# Purpose: Test whether getopt supports the configuration of the
# parsing (with a test that uses getopt's compatibility mode).

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
export GETOPT_COMPATIBLE=1

set -- "-v" "1 2"
if ! args="$(getopt "v:" "$@" 2> /dev/null)"; then
    exit 1
fi
eval set -- "${args}"

while true; do
    case "$1" in
        "-v")
            var="$2 $3"
            shift 3
            ;;
        "--")
            shift
            break
            ;;
        *) exit 1 ;;
    esac
done

if [[ "${var}" == "1 2" ]]; then
    exit 2  # Indicate partial support for feature.
fi
exit 1
