#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-02-19

# Usage: Run this script with "bash test_help_message.sh".

# Purpose: Demonstrate the functionality of the argparser regarding the
# localization.

# Set the argparser, reading the arguments definition, help message, and
# translation from a file.
ARGPARSER_ARG_DEF_FILE="${0%/*}/../resources/arguments_${LANG::2}.csv"
ARGPARSER_ARG_DEF_FILE_HAS_HEADER=false
ARGPARSER_HELP_FILE="${0%/*}/../resources/help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="${0%/*}/../resources/translation.yaml"

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
