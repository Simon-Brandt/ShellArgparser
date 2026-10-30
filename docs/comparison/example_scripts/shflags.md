<!--
###############################################################################
#                                                                             #
# Copyright 2025-2026 Simon Brandt                                            #
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

#### 6.2.3. shFlags

<details open>

<summary>Contents of <code>test_shflags.sh</code></summary>

<!-- <include command="sed '3,28d;/shellcheck/d' ../parser_comparison/cli_example_medium/test_shflags.sh" lang="bash"> -->
```bash
#!/usr/bin/env bash

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-e] [-v] -a=AGE -n=NAME -r={u,m,b} "
    usage+="source destination"
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
DEFINE_boolean "verbose" "${FLAGS_FALSE}" "output verbose information" "v"
DEFINE_boolean "exit" "${FLAGS_FALSE}" "exit directly after parsing, for runtime assessment" "e"
DEFINE_boolean "usage" "${FLAGS_FALSE}" "display the usage and exit" "u"
DEFINE_boolean "version" "${FLAGS_FALSE}" "display the version and exit" "V"

if ! FLAGS "$@"; then
    exit "$?"
fi
eval set -- "${FLAGS_ARGV}"

# Check for the usage and version options.  The help option is handled
# by shflags.
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

name="${FLAGS_name}"
if [[ "${name}" == "?" ]]; then
    printf '%s: Error: The option -n,--name is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
fi

age="${FLAGS_age}"
if (( "${age}" == -1 )); then
    printf '%s: Error: The option -a,--age is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
fi

role="${FLAGS_role}"
if [[ "${role}" == "?" ]]; then
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
    "u") role="User" ;;
    "m") role="Moderator" ;;
    "b") role="Bot" ;;
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

# Possibly, exit prematurely.
[[ "${FLAGS_exit}" == "${FLAGS_TRUE}" ]] && exit

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
bash test_shflags.sh --verbose --name="A. R. G. Parser" --age=2 --role=b template.html argparser.html

# Short options.
bash test_shflags.sh -v -n "A. R. G. Parser" -a 2 -r b template.html argparser.html

# Merged short options.
bash test_shflags.sh -vn "A. R. G. Parser" -a2 -rb template.html argparser.html

# Leading positional arguments.
bash test_shflags.sh template.html argparser.html -vn "A. R. G. Parser" -a2 -rb

# Positional arguments delimiter "--".
bash test_shflags.sh -vn "A. R. G. Parser" -a2 -rb -- template.html argparser.html

# Intermixed positional arguments.
bash test_shflags.sh -vn "A. R. G. Parser" template.html -a2 argparser.html -rb

# Help, usage, and version messages.
bash test_shflags.sh --help
bash test_shflags.sh --usage
bash test_shflags.sh --version
```

Notes:

- shFlags uses GNU [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)") to parse long options, and fails parsing them on other `getopt` implementations.
- Since shFlags is a [`gflags`](https://gflags.github.io/gflags/ "github.io &rightarrow; gflags") port, it uses a slightly strange and unintuitive syntax, like `DEFINE_string long_option default help short_option`.
- Likewise, options are available in the environment as `FLAGS_option_name`, not by a different identifier.
- Mandatory options aren't supported.  *In lieu* of checking for their existence on the command line, "impossible" default values are set and then checked against.
- The help message is partly auto-generated. In order to comply with the style decisions in shFlags, the manually set header is adapted to them.
- The question mark `?` for the help message is not supported.

[&#129092;&nbsp;6.2.2. `getopt`](getopt.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.2.4. docopts&nbsp;&#129094;](docopts.md)
