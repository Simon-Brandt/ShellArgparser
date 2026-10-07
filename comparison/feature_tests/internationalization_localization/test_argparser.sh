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
# Last Modification: 2026-10-07

# Usage: Run this script from test_features.sh as
# "bash test_features.sh --test-internationalization-localization".

# Purpose: Test whether the Argparser supports internationalization/
# localization.

# Parse the arguments.  Since the test runs in a subshell, it is not
# necessary to define "exit" as alias for "return".  Then, the final
# check for the variables sets the test's result as exit code.
ARGPARSER_ARG_DEF_FILE="$(dirname "$0")/arguments.csv"
ARGPARSER_LANGUAGE="de"
ARGPARSER_TRANSLATION_FILE="$(dirname "$0")/translations.yaml"

# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    id
    var
)
actual_output="$(source argparser -- "$@" 2> /dev/null)"

expected_output="$(cat << EOF
Aufruf: test_argparser.sh ARGUMENTE

Kommandozeilenprogramm.

Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich.

+- Optionen ---------------------------------------------------------------+
| -v=VAL                kurze Option                                       |
+--------------------------------------------------------------------------+

+- Hilfsoptionen ----------------------------------------------------------+
| [-h, -?], [--help]    diese Hilfe anzeigen und beenden (Vorgabe: falsch) |
| [-u],     [--usage]   den Aufruf anzeigen und beenden (Vorgabe: falsch)  |
| [-V],     [--version] die Version anzeigen und beenden (Vorgabe: falsch) |
+--------------------------------------------------------------------------+
EOF
)"

if [[ "${actual_output}" == "${expected_output}" ]]; then
    exit 0
fi
exit 1
