#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-05-26

# Usage: Run this script with "bash argparser_wrapper.sh".

# Purpose: Parse the command line using the argparser.

# Parse the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id       | short_opts | long_opts | val_names   | defaults | choices | type | arg_no | arg_group            | notes | help                                                            "
    "in_file  |            |           | source      |          |         | file | 1      | Positional arguments |       | the template HTML file to fill in                               "
    "out_file |            |           | destination |          |         | file | 1      | Positional arguments |       | the output HTML file                                            "
    "name     | n          | name      | NAME        |          |         | str  | 1      | Mandatory options    |       | the name of the homepage's owner                                "
    "age      | a          | age       | AGE         |          |         | uint | 1      | Mandatory options    |       | the current age of the homepage's owner                         "
    "role     | r          | role      | ROLE        |          | u,m,b   | char | 1      | Mandatory options    |       | the role of the homepage's owner (u: user, m: moderator, b: bot)"
    "verbose  | v          | verbose   |             | false    |         | bool | 0      | Optional options     |       | output verbose information                                      "
)
source argparser -- "$@"

# Set the role to its long form.
case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
esac

# Run the HTML processor.
source process_html_template.sh
