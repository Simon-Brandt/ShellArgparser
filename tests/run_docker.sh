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
# Last Modification: 2025-08-20

# Usage: Run this script with "bash run_docker.sh".

# Purpose: Test the functionality of the Argparser by running the test
# suite (run_tests.sh) from within Docker containers of Bash 4.4 through
# 5.3.

# Define the function for colorizing.
function colorize() {
    # Colorize and format the string using ANSI escape sequences.
    #
    # Arguments:
    # - $1: the colors and/or styles to use as comma-separated list
    # - $2: the string to colorize
    # - $3: whether to reset the color and/or style after the string
    #
    # Output:
    # - the colorized string

    # Define the local variables.
    local request
    local requests
    local reset
    local string
    local style
    local -A styles

    # Read the arguments.
    requests="$1"
    string="$2"
    reset="$3"

    # Define the associative array with colors and styles, and their
    # corresponding Select Graphic Rendition (SGR) ANSI escape sequence
    # codes.
    styles=(
        [black]=30
        [red]=31
        [green]=32
        [yellow]=33
        [blue]=34
        [magenta]=35
        [cyan]=36
        [white]=37
        [normal]=22
        [bold]=1
        [faint]=2
        [italic]=3
        [underline]=4
        [double]=21
        [overline]=53
        [crossed-out]=9
        [blink]=5
        [reverse]=7
    )

    # Split the requested color and/or style on commas and replace it
    # with the corresponding escape sequence.
    style=""
    IFS="," read -r -a requests <<< "${requests}"
    for request in "${requests[@]}"; do
        style+="\e[${styles[${request}]}m"
    done

    # Print the colorized string and possibly reset the color/style.

    # shellcheck disable=SC2059  # Escape sequence in variable.
    printf "${style}"
    printf '%s' "${string}"
    if [[ "${reset}" == true ]]; then
        printf '\e[m'
    fi
}

function print_double_separator() {
    # Print a line of 120 equals signs acting as visual separator,
    # colored in blue.
    colorize "cyan" "$(printf '%120s' "" | tr ' ' "=")" true
    printf '\n'
}

# For each Bash version, build a Docker image to run the test suite
# under a given Bash version.
declare -A versions=(
    [4.3]=30a978b  # v4.3.46 (final release)
    [4.4]=b0776d8  # v4.4.19 (final release)
    [5.0]=36f2c40  # v5.0.18 (final release)
    [5.1]=9439ce0  # v5.1.16 (final release)
    [5.2]=c5c97b3  # v5.2.37 (final release)
    [5.3]=a8a1c2f  # v5.3.3  (current release)
)

# Build the Docker images for the given Bash versions.
colorize "yellow,bold,reverse" "Building Docker images..." false
printf '%*s' 95 ""
colorize "" $'\n' true
print_double_separator

for version in "${!versions[@]}"; do
    tag="argparser-bash${version/./}:latest"
    sha1="${versions[${version}]}"

    printf 'Building Docker image for '
    colorize "bold" "Bash v${version}" true
    printf '...\n'

    docker build \
        --build-arg="VERSION=${version}" \
        --build-arg="GIT_SHA1=${sha1}" \
        --build-context="parent=${PWD}/.." \
        --file=argparser.dockerfile \
        --quiet \
        --tag="${tag}" \
        "${PWD}"

    printf 'Finished build.\n'
    print_double_separator
done

# Run the test suite in all images' containers and report whether errors
# occurred.
colorize "yellow,bold,reverse" "Running test suites..." false
printf '%*s' 98 ""
colorize "" $'\n' true
print_double_separator

for version in "${!versions[@]}"; do
    tag="argparser-bash${version/./}:latest"

    printf 'Running test suite for '
    colorize "bold" "Bash v${version}" true
    printf '...\n'

    docker run --rm "${tag}" /opt/argparser/tests/run_tests.sh &> /dev/null
    error_count="$?"
    if (( error_count == 0 )); then
        colorize "green,bold,reverse" \
            "Finished runs for Bash v${version} with no errors." false
        printf '%*s' 77 ""
        colorize "" $'\n' true
    elif (( error_count == 1 )); then
        colorize "red,bold,reverse" \
            "Finished runs for Bash v${version} with 1 error." false
        printf '%*s' 79 ""
        colorize "" $'\n' true
    else
        colorize "red,bold,reverse" \
            "Finished runs for Bash v${version} with ${error_count} errors." \
            false
        printf '%*s' $(( 79 - "${#error_count}" )) ""
        colorize "" $'\n' true
    fi

    if (( error_count > 0 )); then
        printf 'Investigate the failed test(s) by running:\n'

        colorize "blue" "    docker run --interactive --tty --rm ${tag}" false
        printf '%*s' 78 ""
        colorize "" $'\n' true

        printf 'followed by\n'

        colorize "blue" "    bash run_tests.sh" false
        printf '%*s' 103 ""
        colorize "" $'\n' true

        printf 'in the created Docker container.\n'
    fi

    print_double_separator
done
