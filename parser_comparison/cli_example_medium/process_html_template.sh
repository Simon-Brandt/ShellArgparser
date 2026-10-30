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

# Usage: Source this script with "source process_html_template.sh".

# Purpose: Process the template HTML file to include user-supplied data
# from the command line.

# Set the default values for the parameters to allow running the script
# without sourcing it from a command-line parsing script.
: "${in_file:-/dev/stdin}"
: "${out_file:-/dev/stdout}"
: "${name:-${USER}}"
: "${age:-0}"
: "${role:-user}"
: "${verbose:-false}"

# Copy the template HTML file.
if [[ "${verbose}" == true ]]; then
    printf "Verbose output enabled.\n"
    printf 'Copying HTML template from %s to %s...\n' "${in_file}" \
        "${out_file}"
fi
cp "${in_file}" "${out_file}"

# Replace the name, age, and role in the HTML file.
if [[ "${verbose}" == true ]]; then
    printf 'Replacing name: %s...\n' "${name}"
fi
sed --in-place "s/\$USER/${name}/g" "${out_file}"

if [[ "${verbose}" == true ]]; then
    printf 'Replacing age: %s...\n' "${age}"
fi
sed --in-place "s/\$AGE/${age}/g" "${out_file}"

if [[ "${verbose}" == true ]]; then
    printf 'Replacing role: %s...\n' "${role}"
fi
sed --in-place "s/\$ROLE/${role}/g" "${out_file}"
