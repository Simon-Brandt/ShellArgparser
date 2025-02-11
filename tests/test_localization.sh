#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-02-11

# Usage: Run this script with "bash test_help_message.sh".

# Purpose: Test the functionality of the argparser.

# Set the argparser, reading the arguments definition, help message, and
# translation from a file.
ARGPARSER_ARG_DEF_FILE="arguments_${LANG::2}.csv"
ARGPARSER_ARG_DEF_FILE_HAS_HEADER=false
ARGPARSER_HELP_FILE="help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="translation.csv"

# Set the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    pos_1
    pos_2
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
    var_7
)

source argparser

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
