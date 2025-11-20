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
# Last Modification: 2025-11-04

# Usage: Run this script with "bash run_docker.sh [--purge]".

# Purpose: Test the functionality of the Argparser by running the test
# suite (run_tests.sh) from within Docker containers of Bash 4.4 through
# 5.3.

# Define the function for colorizing.
function colorize() {
    # Colorize and format the string(s) using ANSI escape sequences.
    # If the last string ends in $'\n', right-pad the merged string to
    # 120 characters using spaces.  If using reverse video ("reverse"
    # style), this means that also the spaces (and thus the entire line)
    # are colored.
    #
    # Arguments:
    # - $1: the colors and/or styles to use as comma-separated list
    # - $@: the string(s) to colorize
    #
    # Output:
    # - the colorized string

    # Define the local variables.
    local colorized_string
    local -A colors_and_styles
    local IFS
    local string
    local style
    local style_request
    local style_requests

    # Read the arguments.
    style_requests="$1"
    shift
    IFS=" "
    string="$*"
    unset IFS

    # Define the associative array with colors and styles, and their
    # corresponding Select Graphic Rendition (SGR) ANSI escape sequence
    # codes.
    colors_and_styles=(
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
    IFS="," read -r -a style_requests <<< "${style_requests}"
    for style_request in "${style_requests[@]}"; do
        style+=$'\e'"[${colors_and_styles[${style_request}]}m"
    done

    # Print the colorized string.  Possibly, right-pad the string.
    # Finally, reset the color/style.
    colorized_string="${style}${string}"
    printf '%s' "${colorized_string%$'\n'}"
    if [[ "${string: -1}" == $'\n' ]]; then
        printf '%*s' $(( 120 - ${#string} + 1 )) ""
        printf '\e[m\n'
    else
        printf '\e[m'
    fi
}

function print_double_separator() {
    # Print a line of 120 equals signs acting as visual separator,
    # colored in blue.
    local separator
    printf -v separator '%120s' ""
    separator="${separator// /=}"
    colorize "cyan" "${separator}" $'\n'
}

# Possibly, remove all existing Docker images.
if [[ "$1" == "--purge" ]]; then
    docker system prune --all
fi

# For each Bash version, build a Docker image to run the test suite
# under a given Bash version.
versions=(
    4.3
    4.4
    5.0
    5.1
    5.2
    5.3
)
declare -A sha1_hashes=(
    [4.3]=30a978b  # v4.3.46 (final release)
    [4.4]=b0776d8  # v4.4.19 (final release)
    [5.0]=36f2c40  # v5.0.18 (final release)
    [5.1]=9439ce0  # v5.1.16 (final release)
    [5.2]=c5c97b3  # v5.2.37 (final release)
    [5.3]=a8a1c2f  # v5.3.3  (current release)
)

# Build the Docker images for the given Bash versions.
colorize "yellow,bold,reverse" $'Building Docker images...\n'
print_double_separator

for version in "${versions[@]}"; do
    tag="argparser-bash${version/./}:latest"
    sha1_hash="${sha1_hashes[${version}]}"

    printf 'Building Docker image for '
    colorize "bold" "Bash v${version}"
    printf '...\n'

    docker build \
        --build-arg="VERSION=${version}" \
        --build-arg="GIT_SHA1=${sha1_hash}" \
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
colorize "yellow,bold,reverse" $'Running test suites...\n'
print_double_separator

for version in "${versions[@]}"; do
    tag="argparser-bash${version/./}:latest"

    printf 'Running test suite for '
    colorize "bold" "Bash v${version}"
    printf '...\n'

    docker run --rm "${tag}" /opt/argparser/tests/run_tests.sh &> /dev/null
    error_count="$?"
    if (( error_count == 0 )); then
        colorize "green,bold,reverse" \
            "Finished runs for Bash v${version} with no errors." $'\n'
    elif (( error_count == 1 )); then
        colorize "red,bold,reverse" \
            "Finished runs for Bash v${version} with 1 error." $'\n'
    else
        colorize "red,bold,reverse" \
            "Finished runs for Bash v${version} with ${error_count} errors." \
            $'\n'
    fi

    if (( error_count > 0 )); then
        printf 'Investigate the failed test(s) by running:\n'
        colorize "blue" "    docker run --interactive --tty --rm ${tag}" $'\n'
        printf 'followed by\n'
        colorize "blue" $'    bash run_tests.sh\n'
        printf 'in the created Docker container.\n'
    fi

    print_double_separator
done
