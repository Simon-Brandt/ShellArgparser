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

# Usage: Source this argument definition file from test_getopts.sh.

# Purpose: Define the arguments for the argument definition file test.

args=( )
while getopts ":a:" arg "$@" &> /dev/null; do
    # shellcheck disable=SC2034  # Variable used in sourcing script.
    case "${arg}" in
        "a") var_a="${OPTARG}" ;;
        *) args+=("-${OPTARG}") ;;
    esac
done

set -- "${args[@]}" "${@:OPTIND}"
OPTIND=1
