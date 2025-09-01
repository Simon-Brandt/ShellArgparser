<!--
###############################################################################
#                                                                             #
# Copyright 2025 Simon Brandt                                                 #
#                                                                             #
# Licensed under the Apache License, Version 2.0 (the "License");             #
# you may not use this file except in compliance with the License.            #
# You may obtain a copy of the License at                                     #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
# Unless required by applicable law or agreed to in writing, software         #
# distributed under the License is distributed on an "AS IS" BASIS,           #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    #
# See the License for the specific language governing permissions and         #
# limitations under the License.                                              #
#                                                                             #
###############################################################################
-->

#### 6.2.2. `getopt`

<details open>

<summary>Contents of <code>getopt_wrapper.sh</code></summary>

<!-- <include command="sed '3,28d;/shellcheck/d' ../comparison/getopt_wrapper.sh" lang="bash"> -->
```bash
#!/usr/bin/env bash

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
    [-e],     [--exit]       exit directly after parsing, for runtime
                             assessment
    [-v],     [--verbose]    output verbose information

    [-h, -?], [--help]       display this help and exit
    [-u],     [--usage]      display the usage and exit
    [-V],     [--version]    display the version and exit
EOF
}

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-e] [-v] -a=AGE -n=NAME -r={u,m,b} "
    usage+="source destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
if ! args="$(getopt --options="n:a:r:veh?uV" \
    --longoptions="name:,age:,role:,verbose,exit,help,usage,version" -- "$@")"
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
        -e|--exit)
            exit=true
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

# Possibly, exit prematurely.
[[ "${exit}" == true ]] && exit

# Run the HTML processor.
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
```
<!-- </include> -->

</details>

Example calls:

```bash
# Long options.
bash getopt_wrapper.sh --verbose --name="A. R. G. Parser" --age=2 --role=b template.html argparser.html

# Short options.
bash getopt_wrapper.sh -v -n "A. R. G. Parser" -a 2 -r b template.html argparser.html

# Merged short options.
bash getopt_wrapper.sh -vn "A. R. G. Parser" -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash getopt_wrapper.sh -vn "A. R. G. Parser" -a2 -rb -- template.html argparser.html

# Leading positional arguments.
bash getopt_wrapper.sh template.html argparser.html -vn "A. R. G. Parser" -a2 -rb

# Intermixed positional arguments.
bash getopt_wrapper.sh -vn "A. R. G. Parser" template.html -a2 argparser.html -rb

# Help, usage, and version messages.
bash getopt_wrapper.sh --help
bash getopt_wrapper.sh --usage
bash getopt_wrapper.sh --version
```

Notes:

- Using whitespace between options with optional arguments (*i.e.*, an argument number of zero or higher) and their values is disallowed.

[&#129092;&nbsp;6.2.1. `getopts`](getopts.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.2.3. shFlags&nbsp;&#129094;](shflags.md)
