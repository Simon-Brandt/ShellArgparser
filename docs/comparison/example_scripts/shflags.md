#### 5.2.3. shFlags

<details open>

<summary>Contents of <code>shflags_wrapper.sh</code></summary>

<!-- <include command="sed '3,10d;/shellcheck/d' ../comparison/shflags_wrapper.sh" lang="bash"> -->
```bash
#!/bin/bash

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-v] -a=AGE -n=NAME -r={u,m,b} source "
    usage+="destination"
    printf '%s\n' "${usage}"
}

# Define the help message.
FLAGS_HELP="$(cat << EOF
Usage: $0 [OPTIONS] ARGUMENTS source destination

Mandatory arguments to long options are mandatory for short options too.

positional arguments:
source:  the template HTML file to fill in
destination:  the output HTML file
EOF
)"
FLAGS_HELP+=$'\n'

# Parse the arguments.
source shflags

DEFINE_string "name" "?" "the name of the homepage's owner" "n"
DEFINE_integer "age" "-1" "the current age of the homepage's owner" "a"
DEFINE_string "role" "?" "the role of the homepage's owner (u: user, m: moderator, b: bot)" "r"
DEFINE_boolean "verbose" false "output verbose information" "v"
DEFINE_boolean "usage" false "display the usage and exit" "u"
DEFINE_boolean "version" false "display the version and exit" "V"

if ! FLAGS "$@"; then
    exit "$?"
fi
eval set -- "${FLAGS_ARGV}"

# Check for the usage and version options.
if [[ "${FLAGS_usage}" == "${FLAGS_TRUE}" ]]; then
    usage
    exit
elif [[ "${FLAGS_version}" == "${FLAGS_TRUE}" ]]; then
    printf '%s v1.0.0\n' "$0"
    exit
fi

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

if [[ "${FLAGS_name}" == "?" ]]; then
    printf '%s: Error: The option -n,--name is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
fi
name="${FLAGS_name}"

if (( "${FLAGS_age}" == -1 )); then
    printf '%s: Error: The option -a,--age is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
fi
age="${FLAGS_age}"

if [[ "${FLAGS_role}" == "?" ]]; then
    printf '%s: Error: The option -r,--role is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
elif [[ "${FLAGS_role}" != [[:print:]] ]]; then
    printf '%s: Error: The option -r,--role must be a single character.\n' "$0"
    usage >&2
    exit 1
fi

case "${FLAGS_role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
    *)
        printf '%s: Error: The option -r,--role must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

if [[ "${FLAGS_verbose}" == "${FLAGS_TRUE}" ]]; then
    verbose=true
else
    verbose=false
fi

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
# Long options.
bash shflags_wrapper.sh --verbose --name="A. R. G. Parser" --age=2 --role=b template.html argparser.html

# Short options.
bash shflags_wrapper.sh -v -n "A. R. G. Parser" -a 2 -r b template.html argparser.html

# Merged short options.
bash shflags_wrapper.sh -vn "A. R. G. Parser" -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash shflags_wrapper.sh -vn "A. R. G. Parser" -a2 -rb -- template.html argparser.html

# Leading positional arguments.
bash shflags_wrapper.sh template.html argparser.html -vn "A. R. G. Parser" -a2 -rb

# Intermixed positional arguments.
bash shflags_wrapper.sh -vn "A. R. G. Parser" template.html -a2 argparser.html -rb

# Help, usage, and version messages.
bash shflags_wrapper.sh --help
bash shflags_wrapper.sh --usage
bash shflags_wrapper.sh --version
```

Notes:

- shFlags uses GNU `getopt` to parse long options, and fails parsing them on other `getopt` implementations.
- Since shFlags is a `gflags` port, it uses a slightly strange and unintuitive syntax, like `DEFINE_string long_option default help short_option`.
- Likewise, options are available in the environment as `FLAGS_option_name`, not by a different identifier.
- Mandatory options aren't supported.  *In lieu* of checking for their existence on the command line, "impossible" default values are set and then checked against.
- The help message is partly auto-generated. In order to comply with the style decisions in shFlags, the manually set header is adapted to them.
- The question mark `?` for the help message is not supported.

[&#129092;&nbsp;5.2.2. `getopt`](getopt.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.2.4. docopts&nbsp;&#129094;](docopts.md)
