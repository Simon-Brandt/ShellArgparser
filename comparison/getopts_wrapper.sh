#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-05-23

# Usage: Run this script with "bash getopts_wrapper.sh".

# Purpose: Parse the command line using getopts.

function help() {
    # Define the help message.
    cat << EOF | sed 's/^    //'
    Usage: $0 [OPTIONS] source destination

    Positional arguments:
    source       the template HTML file to fill in
    destination  the output HTML file

    Mandatory options:
    -n NAME      the name of the homepage's owner
    -a AGE       the current age of the homepage's owner
    -r {u,m,b}   the role of the homepage's owner (u: user, m: moderator, b:
                 bot)

    Optional options:
    [-v]         output verbose information

    [-h]         display this help and exit
    [-u]         display the usage and exit
    [-V]         display the version and exit
EOF
}

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h | -u | -V] [-v] -n=NAME -a=AGE -r={u,m,b} source "
    usage+="destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
verbose=false
while getopts "n:a:r:vhuV" arg; do
    case "${arg}" in
        n) name="${OPTARG}" ;;
        a) age="${OPTARG}" ;;
        r) role="${OPTARG}" ;;
        v) verbose=true ;;
        h)
            help
            exit
            ;;
        u)
            usage
            exit
            ;;
        V)
            printf '%s v1.0.0\n' "$0"
            exit
            ;;
        *)
            usage >&2
            exit 1
            ;;
    esac
done

shift "$(( OPTIND - 1 ))"

# Check the arguments' values.
if (( "$#" == 1 )); then
    printf '%s: Error: 2 positional arguments are required, but 1 is given.\n' \
        "$0"
    usage >&2
    exit 1
elif (( "$#" != 2 )); then
    printf '%s: Error: 2 positional arguments are required, but %s are given.\n' \
        "$0" "$#"
    usage >&2
    exit 1
fi

if [[ -z "${name}" ]]; then
    printf '%s: Error: The option -n is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
fi

if [[ -z "${age}" ]]; then
    printf '%s: Error: The option -a is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
elif [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

if [[ -z "${role}" ]]; then
    printf '%s: Error: The option -r is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
elif [[ "${role}" != [[:print:]] ]]; then
    printf '%s: Error: The option -r must be a single character.\n' "$0"
    usage >&2
    exit 1
fi

case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
    *)
        printf '%s: Error: The option -r must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

# Set the positional arguments to variables.
in_file="$1"
out_file="$2"

# Run the HTML processor.
source process_html_template.sh
