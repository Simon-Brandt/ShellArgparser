#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-05-23

# Usage: Run this script with "bash getopt_wrapper.sh".

# Purpose: Parse the command line using getopt.

function help() {
    # Define the help message.
    cat << EOF | sed 's/^    //'
    Usage: $0 [OPTIONS] ARGUMENTS source destination

    Mandatory arguments to long options are mandatory for short options too.

    Positional arguments:
    source                   the template HTML file to fill in
    destination              the output HTML file

    Mandatory options:
    -a,       --age=AGE      the current age of the homepage's owner
    -n,       --name=NAME    the name of the homepage's owner
    -r,       --role={u,m,b} the role of the homepage's owner (u: user, m:
                             moderator, b: bot)

    Optional options:
    [-v],     [--verbose]    output verbose information

    [-h, -?], [--help]       display this help and exit
    [-u],     [--usage]      display the usage and exit
    [-V],     [--version]    display the version and exit
EOF
}

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-v] -a=AGE -n=NAME -r={u,m,b} source "
    usage+="destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
if ! args="$(getopt --options="n:a:r:vh?uV" \
    --longoptions="name:,age:,role:,verbose,help,usage,version" -- "$@")"
then
    exit 1
fi
eval set -- "${args}"

verbose=false
while true; do
    case "$1" in
        -n|--name)
            name="$2"
            shift 2
            ;;
        -a|--age)
            age="$2"
            shift 2
            ;;
        -r|--role)
            role="$2"
            shift 2
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -h|--help)
            help
            exit
            ;;
        -u|--usage)
            usage
            exit
            ;;
        -V|--version)
            printf '%s v1.0.0\n' "$0"
            exit
            ;;
        --)
            shift
            break
            ;;
        *)
            usage >&2
            exit 1
            ;;
    esac
done

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
    printf '%s: Error: The option -n,--name is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
fi

if [[ -z "${age}" ]]; then
    printf '%s: Error: The option -a,--age is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
elif [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a,--age must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

if [[ -z "${role}" ]]; then
    printf '%s: Error: The option -r,--role is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
elif [[ "${role}" != [[:print:]] ]]; then
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

# Set the positional arguments to variables.
in_file="$1"
out_file="$2"

# Run the HTML processor.
source process_html_template.sh
