#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-02-28

# Usage: Run this script with "bash test_help_file.sh".

# Purpose: Test the functionality of the argparser.

# Source the argparser, reading the help message from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_HELP_FILE="${dir}/help_message.txt"

# Define the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
    "var_1:a:var-1:VAL_1:-:-:uint:1:Mandatory options:-:one value without default or choice"
    "var_2:b:var-2:VAL_2:-:-:int:+:Mandatory options:-:at least one value without default or choice"
    "var_3:c:var-3:VAL_3:-:A,B:char:+:Mandatory options:-:at least one value with choice"
    "var_4:d:-:VAL_4:A:A,B,C:char:1:Optional options:-:one value with default and choice"
    "var_5:-:var-5:VAL_5:E:-:str:1:Optional options:-:one value with default"
    "var_6:f:var-6:VAL_6:false:-:bool:0:Optional options:-:no value (flag) with default"
    "var_7:g:var-7:VAL_7:true:-:bool:0:Optional options:deprecated:no value (flag) with default"
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
