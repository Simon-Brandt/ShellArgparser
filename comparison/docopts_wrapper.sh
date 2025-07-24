#!/bin/bash

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
# Last Modification: 2025-07-24

# Purpose: Parse the command line using docopts.

# Usage:
#   docopts_wrapper.sh [-v | --verbose] [-e | --exit] (-a AGE | --age=AGE) (-n NAME | --name=NAME) (-r ROLE | --role=ROLE) [--] <source> <destination>
#   docopts_wrapper.sh -h | -? | --help
#   docopts_wrapper.sh -u | --usage
#   docopts_wrapper.sh -V | --version
#
# Mandatory arguments to long options are mandatory for short options too.
#
# Positional arguments:
# <source>              the template HTML file to fill in
# <destination>         the output HTML file
#
# Mandatory options:
# -a AGE,  --age=AGE    the current age of the homepage's owner
# -n NAME, --name=NAME  the name of the homepage's owner
# -r ROLE, --role=ROLE  the role of the homepage's owner (u: user, m:
#                       moderator, b: bot)
#
# Optional options:
# -e,     --exit        exit directly after parsing, for runtime assessment
# -v,     --verbose     output verbose information
#
# -h, -?, --help        display this help and exit
# -u,     --usage       display the usage and exit
# -V,     --version     display the version and exit

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-e] [-v] -a=AGE -n=NAME -r={u,m,b} "
    usage+="source destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
source docopts.sh --auto "$@"

# Set the arguments to variables.
in_file="${ARGS[<source>]}"
out_file="${ARGS[<destination>]}"

if [[ "${ARGS[-a]}" == true ]]; then
    age="${ARGS[AGE]}"
else
    age="${ARGS[--age]}"
fi

if [[ "${ARGS[-n]}" == true ]]; then
    name="${ARGS[NAME]}"
else
    name="${ARGS[--name]}"
fi

if [[ "${ARGS[-r]}" == true ]]; then
    role="${ARGS[ROLE]}"
else
    role="${ARGS[--role]}"
fi

if [[ "${ARGS[-v]}" == true  || "${ARGS[--verbose]}" == true ]]; then
    verbose=true
fi

if [[ "${ARGS[-e]}" == true  || "${ARGS[--exit]}" == true ]]; then
    exit=true
fi

if [[ "${ARGS[-?]}" == true ]]; then
    help=true
fi

if [[ "${ARGS[-u]}" == true || "${ARGS[--usage]}" == true ]]; then
    usage=true
fi

if [[ "${ARGS[-V]}" == true || "${ARGS[--version]}" == true ]]; then
    version=true
fi

# Check for the help, usage, and version options.
if [[ "${help}" == true ]]; then
    bash "$0" --help
    exit
elif [[ "${usage}" == true ]]; then
    usage
    exit
elif [[ "${version}" == true ]]; then
    printf '%s v1.0.0\n' "$0"
    exit
fi

# Check the arguments' values.
if [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a,--age must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

if [[ "${role}" != [[:print:]] ]]; then
    printf '%s: Error: The option -r,--role must be a single character.\n' "$0"
    usage >&2
    exit 1
fi

case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
    *)
        printf '%s: Error: The option -r,--role must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

# Possibly, exit prematurely.
[[ "${exit}" == true ]] && exit

# Run the HTML processor.
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
