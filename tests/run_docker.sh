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
# Last Modification: 2025-08-15

# Usage: Run this script with "bash run_docker.sh".

# Purpose: Test the functionality of the Argparser by running the test
# suite (run_tests.sh) from within Docker containers of Bash 4.0 through
# 5.3.

# For each Bash version, build a Docker image to run the test suite
# under a given Bash version.
versions=(
    4.0
    4.1
    4.2
    4.3
    4.4
    5.0
    5.1
    5.2
    5.3
)
for version in "${versions[@]}"; do
    # Build the Docker image for the given Bash version.
    tag="argparser-bash${version/./}:latest"
    printf 'Building Docker image for Bash v%s...\n' "${version}"
    docker build \
        --build-arg="VERSION=${version}" \
        --build-context="parent=${PWD}/.." \
        --file=argparser.dockerfile \
        --quiet \
        --tag="${tag}" \
        "${PWD}"
    printf 'Finished build.\n'

    # Run the test suite in the image's container and report whether
    # errors occurred.
    printf 'Running test suite for Bash v%s...\n' "${version}"
    docker run --rm "${tag}" /opt/argparser/tests/run_tests.sh &> /dev/null
    error_count="$?"
    if (( error_count == 0 )); then
        printf 'Finished runs for Bash v%s with no errors.\n' "${version}"
    elif (( error_count == 1 )); then
        printf 'Finished runs for Bash v%s with 1 error.\n' "${version}"
    else
        printf 'Finished runs for Bash v%s with %s errors.\n' "${version}" \
        "${error_count}"
    fi

    if (( error_count > 0 )); then
        printf '    Investigate the failed test(s) by running:\n'
        printf '        docker run --interactive --tty %s\n' "${tag}"
        printf '    followed by\n'
        printf '        bash run_tests.sh\n'
        printf '    in the created Docker container.\n'
    fi
done
