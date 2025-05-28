#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-05-28

# Purpose: Parse the command line using docopts.

# Usage:
#   docopts_wrapper.sh [-v | --verbose] (-a AGE | --age=AGE) (-n NAME | --name=NAME) (-r ROLE | --role=ROLE) [--] <source> <destination>
#   docopts_wrapper.sh -h | -? | --help
#   docopts_wrapper.sh -u | --usage
#   docopts_wrapper.sh -V | --version
#
# Mandatory arguments to long options are mandatory for short options too.
#
# Positional arguments:
# <source>              the template HTML file to fill in
# <destination>         the output HTML file
#
# Mandatory options:
# -a AGE,  --age=AGE    the current age of the homepage's owner
# -n NAME, --name=NAME  the name of the homepage's owner
# -r ROLE, --role=ROLE  the role of the homepage's owner (u: user, m:
#                       moderator, b: bot)
#
# Optional options:
# -v,     --verbose     output verbose information
#
# -h, -?, --help        display this help and exit
# -u,     --usage       display the usage and exit
# -V,     --version     display the version and exit

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-v] -a=AGE -n=NAME -r={u,m,b} source "
    usage+="destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
source docopts.sh --auto "$@"

# Set the arguments to variables.
in_file="${ARGS[<source>]}"
out_file="${ARGS[<destination>]}"

if [[ "${ARGS[-a]}" == true ]]; then
    age="${ARGS[AGE]}"
else
    age="${ARGS[--age]}"
fi

if [[ "${ARGS[-n]}" == true ]]; then
    name="${ARGS[NAME]}"
else
    name="${ARGS[--name]}"
fi

if [[ "${ARGS[-r]}" == true ]]; then
    role="${ARGS[ROLE]}"
else
    role="${ARGS[--role]}"
fi

if [[ "${ARGS[-v]}" == true  || "${ARGS[--verbose]}" == true ]]; then
    verbose=true
fi

if [[ "${ARGS[-?]}" == true ]]; then
    help=true
fi

if [[ "${ARGS[-u]}" == true || "${ARGS[--usage]}" == true ]]; then
    usage=true
fi

if [[ "${ARGS[-V]}" == true || "${ARGS[--version]}" == true ]]; then
    version=true
fi

# Check for the help, usage, and version options.
if [[ "${help}" == true ]]; then
    bash "$0" --help
    exit
elif [[ "${usage}" == true ]]; then
    usage
    exit
elif [[ "${version}" == true ]]; then
    printf '%s v1.0.0\n' "$0"
    exit
fi

# Check the arguments' values.
if [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a,--age must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

if [[ "${role}" != [[:print:]] ]]; then
    printf '%s: Error: The option -r,--role must be a single character.\n' "$0"
    usage >&2
    exit 1
fi

case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
    *)
        printf '%s: Error: The option -r,--role must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

# Run the HTML processor.
source process_html_template.sh
