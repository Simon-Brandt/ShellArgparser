#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-03-26

# Usage: Run this script with "bash test_positional_arguments.sh".

# Purpose: Test the functionality of the argparser.

# Define the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
