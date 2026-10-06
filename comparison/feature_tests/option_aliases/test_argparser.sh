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
# Last Modification: 2026-10-06

# Usage: Run this script from test_features.sh as
# "bash test_features.sh --test-option-aliases".

# Purpose: Test whether the Argparser supports option aliases
# ("-a"/"-A").

# Parse the arguments.
ARGPARSER_ADD_VERSION=false
ARGPARSER_SET_ARRAYS=false

# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id  | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group | notes | help        "
    "var | v,V        |           | VAL       |          |         | str  | 2      | Options   |       | short option"
)
source argparser -- "$@"

if [[ "${var}" == "1,2" ]]; then
    exit 0
fi
exit 1
