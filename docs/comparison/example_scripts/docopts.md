#### 5.2.4. docopts

<details open>

<summary>Contents of <code>docopts_wrapper.sh</code></summary>

<!-- <include command="sed '3,8d;/shellcheck/d' ../comparison/docopts_wrapper.sh" lang="bash"> -->
```bash
#!/bin/bash

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
bash docopts_wrapper.sh --verbose --name="A. R. G. Parser" --age=2 --role=b template.html argparser.html

# Short options.
bash docopts_wrapper.sh -v -a 2 -n "A. R. G. Parser" -r b template.html argparser.html

# Merged short options.
bash docopts_wrapper.sh -va 2 -n "A. R. G. Parser" -r b template.html argparser.html

# Positional arguments delimiter "--".
bash docopts_wrapper.sh --verbose --name="A. R. G. Parser" --age=2 --role=b -- template.html argparser.html

# Leading positional arguments.
bash docopts_wrapper.sh template.html argparser.html --verbose --name="A. R. G. Parser" --age=2 --role=b

# Intermixed positional arguments.
bash docopts_wrapper.sh --verbose --name="A. R. G. Parser" template.html --age=2 argparser.html --role=b

# Help, usage, and version messages.
bash docopts_wrapper.sh --help
bash docopts_wrapper.sh --usage
bash docopts_wrapper.sh --version
```

Notes:

- Instead of defining the arguments and letting the parser create the help message, in docopts, the help message must be manually provided and the arguments definition gets extracted from there.
- Due to the rather complicated grammar, the usage string is likely incorrect, as the arguments to short options are interpreted as positional arguments. This requires some boilerplate code to get the actual values. Moreover, when using short options, they must be given in the order defined in the usage string as their values are normal positional arguments and as such parsed from left to right, irrespective of the preceding short option "flag" (as the parser interprets the definition). Thus, in the example calls, the long options are used, when necessary.
- The question mark `?` for the help message is not supported, but emulated as `--help` by a separate call.

[&#129092;&nbsp;5.2.3. shFlags](shflags.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.2.5. Argparser&nbsp;&#129094;](argparser.md)
