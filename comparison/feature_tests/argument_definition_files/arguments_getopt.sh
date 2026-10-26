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
# Last Modification: 2026-10-26

# Usage: Source this argument definition file from test_getopt.sh.

# Purpose: Define the arguments for the argument definition file test.

args=("$@")
while (( "${#args[@]}" > 0 )); do
    case "$1" in
        "-v")
            # shellcheck disable=SC2034  # Variable used in sourcing script.
            var="$2"
            shift 2
            ;;
        "--") break ;;
        *) continue ;;
    esac
done
