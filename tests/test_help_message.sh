#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-01-20

# Usage: Run this script with "bash test_help_message.sh".

# Purpose: Test the functionality of the argparser.

# Source the argparser, reading the help message from a file.
ARGPARSER_HELP_FILE="help_message.txt"

# Define the arguments.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:help"
    "var_1:a:var-1:VAL_1:-:-:uint:1:Mandatory options:one value without default or choice"
    "var_2:b:var-2:VAL_2:-:-:int:+:Mandatory options:at least one value without default or choice"
    "var_3:c:var-3:VAL_3:-:A,B:char:+:Mandatory options:at least one value with choice"
    "var_4:d:-:VAL_4:A:A,B,C:char:1:Optional options:one value with default and choice"
    "var_5:-:var-5:VAL_5:E:-:str:1:Optional options:one value with default"
    "var_6:f:var-6:VAL_6:false:-:bool:0:Optional options:no value (flag) with default"
    "var_7:g:var-7:VAL_7:true:-:bool:0:Optional options:no value (flag) with default"
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
