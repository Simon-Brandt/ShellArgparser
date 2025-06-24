### 5.2. Example scripts

#### 5.2.1. `getopts`

<details open>

<summary>Contents of <code>getopts_wrapper.sh</code></summary>

<!-- <include command="sed '3,10d;/shellcheck/d' ../comparison/getopts_wrapper.sh" lang="bash"> -->
```bash
#!/bin/bash

function help() {
    # Define the help message.
    cat << EOF | sed 's/^    //'
    Usage: $0 [OPTIONS] ARGUMENTS source destination

    Positional arguments:
    source       the template HTML file to fill in
    destination  the output HTML file

    Mandatory options:
    -a AGE       the current age of the homepage's owner
    -n NAME      the name of the homepage's owner
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
    usage="Usage: $0 [-h | -u | -V] [-v] -a=AGE -n=NAME -r={u,m,b} source "
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
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
```
<!-- </include> -->

</details>

Example calls:

```bash
# Short options.
bash getopts_wrapper.sh -v -n "A. R. G. Parser" -a 2 -r b template.html argparser.html

# Merged short options.
bash getopts_wrapper.sh -vn "A. R. G. Parser" -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash getopts_wrapper.sh -vn "A. R. G. Parser" -a2 -rb -- template.html argparser.html

# Help, usage, and version messages.
bash getopts_wrapper.sh -h
bash getopts_wrapper.sh -u
bash getopts_wrapper.sh -V
```

Notes:

- Long options aren't supported, so no attempt is made to still parse them.
- The question mark `?` is used as sign for an invalid option name on the command line, thus preventing its use for invoking the help message.

[&#129092;&nbsp;`../feature_comparison.md`](../feature_comparison.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`getopt.md`&nbsp;&#129094;](getopt.md)
