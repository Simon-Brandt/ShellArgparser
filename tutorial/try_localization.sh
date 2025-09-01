#!/usr/bin/env bash

###############################################################################
#                                                                             #
# Copyright 2025 Simon Brandt                                                 #
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
# Last Modification: 2025-09-01

# Usage: Run this script with "bash try_localization.sh".

# Purpose: Demonstrate the functionality of the Argparser regarding the
# localization.

# Source the Argparser, reading the arguments definition, help message,
# and translation from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_ARG_DEF_FILE="${dir}/arguments_${LANG::2}.csv"
ARGPARSER_HELP_FILE="${dir}/help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="${dir}/translations.yaml"

# Set the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    id
    pos_1
    pos_2
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
    var_7
)
source argparser -- "$@"
