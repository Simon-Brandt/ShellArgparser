#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-01-13

# Usage: Run this script with "bash test_long_options.sh".

# Purpose: Test the functionality of the argparser.

# Source the argparser.  As the arguments have multiple short and long
# options, override the default column widths for the help message.
export ARGPARSER_MAX_COL_WIDTH_1=9
export ARGPARSER_MAX_COL_WIDTH_2=33
export ARGPARSER_MAX_COL_WIDTH_3=35

# Define the arguments.
args=(
    "var_1:-:var-1,var-a:-:-:1:Mandatory options:one value without default or choice"
    "var_2:-:var-2,var-b:-:-:+:Mandatory options:at least one value without default or choice"
    "var_3:-:var-3,var-c:-:A,B:+:Mandatory options:at least one value with choice"
    "var_4:-:var-4,var-d:A:A,B,C:1:Optional options:one value with default and choice"
    "var_5:-:var-5,var-e:E:-:1:Optional options:one value with default"
    "var_6:-:var-6,var-f:false:-:0:Optional options:no value (flag) with default"
    "var_7:-:var-7,var-g:true:-:0:Optional options:no value (flag) with default"
)

source argparser

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment.  If positional arguments were given, they are set to $@.
for arg in "${!args[@]}"; do
    printf "The keyword argument \"%s\" equals \"%s\".\n" \
        "${arg}" "${args[${arg}]}"
done | sort

(( i = 1 ))
for arg in "$@"; do
    printf "The positional argument on index \"%s\" equals \"%s\".\n" \
        "${i}" "${arg}"
    (( i++ ))
done
