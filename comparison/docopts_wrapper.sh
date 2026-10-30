#!/usr/bin/env bash

###############################################################################
#                                                                             #
# Copyright 2025-2026 Simon Brandt                                            #
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
# Last Modification: 2026-10-30

# Purpose: Parse the command line using docopts.

# Usage:
#   docopts_wrapper.sh [--verbose] [--exit] --age=AGE --name=NAME --role=ROLE [--] <source> <destination>
#   docopts_wrapper.sh --help
#   docopts_wrapper.sh --usage
#   docopts_wrapper.sh --version
#
# Mandatory arguments to long options are mandatory for short options too.
#
# Positional arguments:
#   <source>              the template HTML file to fill in
#   <destination>         the output HTML file
#
# Mandatory options:
#   -a AGE, --age=AGE     the current age of the homepage's owner
#   -n NAME, --name=NAME  the name of the homepage's owner
#   -r ROLE, --role=ROLE  the role of the homepage's owner (u: user, m:
#                         moderator, b: bot)
#
# Optional options:
#   -e, --exit            exit directly after parsing, for runtime assessment
#   -v, --verbose         output verbose information
#
# Help options:
#   -h, -?, --help        display this help and exit
#   -u, --usage           display the usage and exit
#   -V, --version         display the version and exit

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-e] [-v] -a=AGE -n=NAME -r={u,m,b} "
    usage+="source destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
source docopts.sh --auto "$@"

# Check for the usage and version options.  The help option is handled
# by docopts.sh.
if [[ "${ARGS[--usage]}" == true ]]; then
    usage
    exit
elif [[ "${ARGS[--version]}" == true ]]; then
    printf '%s v1.0.0\n' "$0"
    exit
fi

# Check the arguments' values.
name="${ARGS[--name]}"

age="${ARGS[--age]}"
if [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a,--age must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

role="${ARGS[--role]}"
if [[ "${role}" != [[:print:]] ]]; then
    printf '%s: Error: The option -r,--role must be a single character.\n' "$0"
    usage >&2
    exit 1
fi

case "${role}" in
    "u") role="User" ;;
    "m") role="Moderator" ;;
    "b") role="Bot" ;;
    *)
        printf '%s: Error: The option -r,--role must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

verbose="${ARGS[--verbose]}"

# Set the positional arguments to variables.
in_file="${ARGS[<source>]}"
out_file="${ARGS[<destination>]}"

# Possibly, exit prematurely.
[[ "${ARGS[--exit]}" == true ]] && exit

# Run the HTML processor.
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
