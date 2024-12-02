#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2024-11-29

# Usage: Run this script with "bash argparser_test.sh".

# Purpose: Test the functionality of the argparser.

# 1.    Source the argparser without reading the arguments from a file.
#       As the arguments have multiple short and long options, override
#       the default column widths for the help message.
export ARGPARSER_ARG_DEF_FILE=""
export ARGPARSER_MAX_COL_WIDTH_1=9
export ARGPARSER_MAX_COL_WIDTH_2=33
export ARGPARSER_MAX_COL_WIDTH_3=35

# 2.    Define the arguments.
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
    [var_1]="a,A:var_1,var_A:-:-:1:Arguments:one value without default or choice"
    [var_2]="b,B:var_2,var_B:-:-:+:Arguments:at least one value without default or choice"
    [var_3]="c,C:var_3,var_C:-:A,B:+:Arguments:at least one value with choice"
    [var_4]="d,D:-:A:A,B,C:1:Options:one value with default and choice"
    [var_5]="-:var_5,var_E:E:-:1:Options:one value with default"
    [var_6]="f,F:var_6,var_F:false:-:0:Options:no value (flag) with default"
)
set -o nounset
(set -o posix; set) > 1.txt
source argparser.sh --read -- "$@"
source argparser.sh --set -- "$@"
(set -o posix; set) > 2.txt
# diff --side-by-side --suppress-common-lines 1.txt 2.txt

# 3.    The arguments can now be accessed as keys and values of the
#       associative array "args".  Further, they are set as variables
#       to the environment.  If positional arguments were given, they
#       are set to $@.
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
