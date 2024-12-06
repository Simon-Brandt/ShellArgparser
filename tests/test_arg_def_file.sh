#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2024-12-04

# Usage: Run this script with "bash test_arg_def_file.sh".

# Purpose: Test the functionality of the argparser.

# Set the argparser, reading the arguments definition from a file.
export ARGPARSER_ARG_DEF_FILE="arguments.lst"

# Set the arguments.
args=(
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
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
