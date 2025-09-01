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

# Usage: Run this script with "bash argparser_wrapper.sh".

# Purpose: Parse the command line using the Argparser.

# Parse the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id       | short_opts | long_opts | val_names   | defaults | choices | type | arg_no | arg_group            | help                                                            "
    "in_file  |            |           | source      |          |         | file | 1      | Positional arguments | the template HTML file to fill in                               "
    "out_file |            |           | destination |          |         | file | 1      | Positional arguments | the output HTML file                                            "
    "name     | n          | name      | NAME        |          |         | str  | 1      | Mandatory options    | the name of the homepage's owner                                "
    "age      | a          | age       | AGE         |          |         | uint | 1      | Mandatory options    | the current age of the homepage's owner                         "
    "role     | r          | role      | ROLE        |          | u,m,b   | char | 1      | Mandatory options    | the role of the homepage's owner (u: user, m: moderator, b: bot)"
    "verbose  | v          | verbose   |             | false    |         | bool | 0      | Optional options     | output verbose information                                      "
    "exit     | e          | exit      |             | false    |         | bool | 0      | Optional options     | exit directly after parsing, for runtime assessment             "
)
source argparser -- "$@"

# Set the role to its long form.
case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
esac

# Possibly, exit prematurely.
[[ "${exit}" == true ]] && exit

# Run the HTML processor.
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
