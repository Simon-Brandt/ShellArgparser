#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-05-22

# Usage: Source this script with "source process_html_template.sh".

# Purpose: Process the template HTML file to include user-supplied data
# from the command line.

# Set the default values for the parameters to allow running the script
# without sourcing it from a command-line parsing script.
: "${in_file:-/dev/stdin}"
: "${out_file:-/dev/stdout}"
: "${verbose:-false}"
: "${name:-${USER}}"
: "${age:-2}"
: "${role:-user}"

# Copy the template HTML file.
if [[ "${verbose}" == true ]]; then
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
