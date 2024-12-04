#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2024-12-04

# Usage: Run this script with "bash test_help_message.sh".

# Purpose: Test the functionality of the argparser.

# Source the argparser, reading the help message from a file.
export ARGPARSER_HELP_FILE="help_message.txt"

# Define the arguments.
args=(
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
)

declare -A args_definition
args_definition=(
    [var_1]="a:var_1:-:-:1:Arguments:one value without default or choice"
    [var_2]="b:var_2:-:-:+:Arguments:at least one value without default or choice"
    [var_3]="c:var_3:-:A,B:+:Arguments:at least one value with choice"
    [var_4]="d:-:A:A,B,C:1:Options:one value with default and choice"
    [var_5]="-:var_5:E:-:1:Options:one value with default"
    [var_6]="f:var_6:false:-:0:Options:no value (flag) with default"
)

source argparser.sh

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
