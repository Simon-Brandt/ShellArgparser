#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-03-28

# Usage: Run this script with "bash test_short_options.sh".

# Purpose: Test the functionality of the argparser.

# Source the argparser.  As the arguments have multiple short options,
# override the default column width for the help message.
ARGPARSER_MAX_COL_WIDTH_1=18
ARGPARSER_USE_LONG_OPTIONS=false

# Define the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
    "var_1:a,A:-:VAL_1:-:-:uint:1:Mandatory options:-:one value without default or choice"
    "var_2:b,B:-:VAL_2:-:-:int:+:Mandatory options:-:at least one value without default or choice"
    "var_3:c,C:-:VAL_3:-:A,B:char:+:Mandatory options:-:at least one value with choice"
    "var_4:d,D:-:VAL_4:A:A,B,C:char:1:Optional options:-:one value with default and choice"
    "var_5:e,E:-:VAL_5:E:-:str:1:Optional options:-:one value with default"
    "var_6:f,F:-:VAL_6:false:-:bool:0:Optional options:-:no value (flag) with default"
    "var_7:g,G:-:VAL_7:true:-:bool:0:Optional options:deprecated:no value (flag) with default"
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
