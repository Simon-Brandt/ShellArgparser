#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-03-06

# TODO: Add tests for the general arguments parsing.
# TODO: Write test files for keyword-only and positional-only arguments.

# Usage: Run this script with "bash run_tests.sh".

# Purpose: Test the functionality of the argparser by running all test
# scripts and comparing their output to expected values.

# Define the functions for printing the colored output.
function print_separator() {
    # Print a colored line of 120 characters acting as visual separator.
    #
    # Arguments:
    # - $1: the character to use as separator
    # - $2: the ANSI SGR escape sequence for colorization

    printf '\e[%s;1m' "$2"
    printf '%120s' "" | tr ' ' "$1"
    printf '\e[0m\n'
}

function print_single_separator() {
    # Print a line of 120 hyphens acting as visual separator, colored in
    # white.
    print_separator "-" 37
}

function print_double_separator() {
    # Print a line of 120 equals signs acting as visual separator,
    # colored in blue.
    print_separator "=" 36
}

# Define the function for printing the section names.
function print_section() {
    # Print the section name.
    #
    # Arguments:
    # - $1: the section name to print
    printf '\e[33;1;7mRunning tests for %s...' "$1"
    printf '%*s' $(( 99 - "${#1}" )) ""
    printf '\e[0m\n'
    print_double_separator
}

# Define the function for printing the diff of commands.
function print_diff() {
    # Print the difference between the command's output and the expected
    # output.
    #
    # Arguments:
    # - $1: the command line to run
    # - $2: the expected output
    # - $3: the expected error

    local cmd
    local error
    local exit_code
    local output

    cmd="$1"
    output="$2"
    error="$3"

    printf 'Running test %s: "\e[1m%s\e[0m"...\n' "${test_number}" "${cmd}"

    diff --side-by-side --suppress-common-lines --color=always --width=120 \
        <(eval "${cmd}" 2>&1 3> /dev/null 4> /dev/null) \
        <(if [[ -n "${error}" ]]; then printf '%s\n' "${error}"; fi; \
            printf '%s\n' "${output}") \
        >&2
    exit_code="$?"

    if (( exit_code == 0 )); then
        printf '\e[32;1;7mTest %s succeeded with correct output.' \
            "${test_number}"
        printf '%*s' $(( 84 - "${#test_number}" )) ""
        printf '\e[0m\n'
        (( succeeded_cmd_count++ ))
    elif (( exit_code == 1 )); then
        print_single_separator
        printf '\e[31;1;7mTest %s failed with diverging output.' \
            "${test_number}"
        printf '%*s' $(( 85 - "${#test_number}" )) ""
        printf '\e[0m\n'
        failure_reasons+=("${test_type}")
        (( failed_cmd_count++ ))
    fi
    print_double_separator
}

# Define the function for printing the diff of file descriptors.
function print_fd_diff() {
    # Print the difference between the file descriptors holding content
    # created before and after command execution.

    local exit_code

    # Run the command and compare the output of file descriptor 3 and 4,
    # while ignoring all others.  Remove lines that are allowed to
    # differ.
    diff --side-by-side --suppress-common-lines --color=always --width=120 \
        <(eval "${cmd}" 3>&1 >& /dev/null 4> /dev/null \
            | sed \
                --expression='/^BASH_ARG.=/d' \
                --expression='/^PPID=/d' \
                --expression='/^_=/d' \
                --expression='/^args=/d') \
        <(eval "${cmd}" 4>&1 >& /dev/null 3> /dev/null \
            | sed \
                --expression='/^BASH_ARG.=/d' \
                --expression='/^PPID=/d' \
                --expression='/^_=/d' \
                --expression='/^args=/d' \
                --expression='/^pos_.=/d' \
                --expression='/^var_.=/d') \
        >&2
    exit_code="$?"

    if (( exit_code == 0 )); then
        printf '\e[32;1;7mTest %s succeeded with identical environment.' \
            "${test_number}"
        printf '%*s' $(( 77 - "${#test_number}" )) ""
        printf '\e[0m\n'
    elif (( exit_code == 1 )); then
        print_single_separator
        printf '\e[31;1;7mTest %s failed with diverging environment.' \
            "${test_number}"
        printf '%*s' $(( 80 - "${#test_number}" )) ""
        printf '\e[0m\n'
        failure_reasons+=("${test_type}")
    fi
    print_double_separator
}

# Define the function for printing the summary.
function print_summary() {
    # Print a summary giving statistics over the run commands.
    local line

    printf '\e[33;1;7mSummary:'
    printf '%112s' ""
    printf '\n'

    line="$(printf ' - %2s tests were run.' \
        $(( succeeded_cmd_count + failed_cmd_count )))"
    printf '%s' "${line}"
    printf '%*s' $(( 120 - "${#line}" )) ""
    printf '\n'

    line="$(printf ' - %2s tests succeeded.' "${succeeded_cmd_count}")"
    printf '%s' "${line}"
    printf '%*s' $(( 120 - "${#line}" )) ""
    printf '\n'

    line="$(printf ' - %2s tests failed.' "${failed_cmd_count}")"
    printf '%s' "${line}"
    printf '%*s' $(( 120 - "${#line}" )) ""
    printf '\n'

    printf '\e[0m'
}

# Define the function for printing the reasons for failures.
function print_failure_reasons() {
    # Print the reasons for failures.
    if (( "${#failure_reasons}" == 0 )); then
        return
    fi
    printf '\e[33;1;7mReasons for failure:'
    printf '%100s' ""
    printf '\n'

    mapfile -t failure_reasons \
        < <(printf '%s\n' "${failure_reasons[@]}" | sort --unique)
    for reason in "${failure_reasons[@]}"; do
        printf ' - %s' "${reason}"
        printf '%*s' $(( 117 - "${#reason}" )) ""
        printf '\n'
    done
    printf '\e[0m'
}

# Run the tests.
failed_cmd_count=0
succeeded_cmd_count=0
failure_reasons=( )

# 1.    Test the general functionality using test_basic.sh.
print_section "general functionality"

# 1.1.  Test the normal output for short option names, using spaces.
test_number="1.1"
test_type="output"
cmd="bash test_basic.sh 1 2 -a 1 -b 2 -c A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.2.  Test the normal output for long option names, using spaces.
test_number="1.2"
test_type="output"
cmd="bash test_basic.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.3.  Test the normal output for short option names, using equals
#       signs.
test_number="1.3"
test_type="output"
cmd="bash test_basic.sh 1 2 -a=1 -b=2 -c=A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.4.  Test the normal output for long option names, using equals
#       signs.
test_number="1.4"
test_type="output"
cmd="bash test_basic.sh 1 2 --var-1=1 --var-2=2 --var-3=A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.5.  Test the normal output with the double hyphen as positional
#       arguments delimiter.
test_number="1.5"
test_type="output"
cmd="bash test_basic.sh --var-1=1 --var-2=2 --var-3=A -- 1 2"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.6.  Test the normal output with the doubled plus sign as positional
#       arguments delimiter.
test_number="1.6"
test_type="output"
cmd="bash test_basic.sh --var-1=1 --var-2=2 -- 1 2 ++ --var-3=A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.7.  Test the normal output with the positional argument with default
#       value being given.
test_number="1.7"
test_type="output"
cmd="bash test_basic.sh --var-1=1 --var-2=2 --var-3=A -- 1 2 3"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "1".
The positional argument "pos_2" on index 2 is set to "2,3".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.8.  Test the normal output with flags, including the deprecated one.
test_number="1.8"
test_type="output"
cmd="bash test_basic.sh 1 2 --var-1=1 --var-2=2 --var-3=A --var-6 ++var-7"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "true".
The keyword argument "var_7" is set to "false".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error="test_basic.sh: Warning: The argument \"-g,-G,--var-7,--var-g\" is deprecated and will be removed in the future."
print_diff "${cmd}" "${output}" "${error}"

# 1.9.  Test the usage message in "row" orientation.
test_number="1.9"
test_type="usage"
cmd="bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.10.  Test the usage message in "column" orientation.
test_number="1.10"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h | -u | -V]
                     [-d,-D={A,B,C}]
                     [-e,-E=VAL_5]
                     [-f,-F]
                     [-g,-G]
                     -a,-A=VAL_1
                     -b,-B=VAL_2...
                     -c,-C={A,B}...
                     [{1,2}]
                     pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.11.  Test the help message.
test_number="1.11"
test_type="help"
cmd="bash test_basic.sh --help"
output="$(cat << EOF
Usage: test_basic.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                              one positional argument with default
                                           and choice (default: 2)
pos_2                                      two positional arguments without
                                           default or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR-A     one value without default or choice
-b, -B,   --var-2=VAL_2, --var-b=VAR-B     at least one value without default
                                           or choice
-c, -C,   --var-3={A,B}, --var-c={A,B}     at least one value with choice

Optional options:
-d, -D,   [--var-4={A,B,C}],               one value with default and choice
          [--var-d={A,B,C}]                (default: A)
-e, -E,   [--var-5=VAL_5], [--var-e=VAR-E] one value with default (default: E)
[-f, -F], [--var-6, --var-f]               no value (flag) with default
                                           (default: false)
[-g, -G], [--var-7, --var-g]               (DEPRECATED) no value (flag) with
                                           default (default: true)

-h,       --help                           display this help and exit
-u,       --usage                          display the usage and exit
-V,       --version                        display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.    Test the functionality regarding short options.
print_section "short options"

# 2.1.  Test the normal output.
test_number="2.1"
test_type="output"
cmd="bash test_short_options.sh 1 2 -a 1 -b 2 -c A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.2.  Test the usage message in "row" orientation.
test_number="2.2"
test_type="usage"
cmd="bash test_short_options.sh -u"
output="$(cat << EOF
Usage: test_short_options.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.3.  Test the usage message in "column" orientation.
test_number="2.3"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash test_short_options.sh -u"
output="$(cat << EOF
Usage: test_short_options.sh [-h | -u | -V]
                             [-d,-D={A,B,C}]
                             [-e,-E=VAL_5]
                             [-f,-F]
                             [-g,-G]
                             -a,-A=VAL_1
                             -b,-B=VAL_2...
                             -c,-C={A,B}...
                             [{1,2}]
                             pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.4.  Test the help message.
test_number="2.4"
test_type="help"
cmd="bash test_short_options.sh -h"
output="$(cat << EOF
Usage: test_short_options.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]      one positional argument with default and choice (default:
                    2)
pos_2              two positional arguments without default or choice

Mandatory options:
-a=VAL_1,-A=A      one value without default or choice
-b=VAL_2,-B=B      at least one value without default or choice
-c={A,B},-C={A,B}  at least one value with choice

Optional options:
[-d={A,B,C}],      one value with default and choice (default: A)
[-D={A,B,C}]
[-e=VAL_5], [-E=E] one value with default (default: E)
[-f, -F]           no value (flag) with default (default: false)
[-g, -G]           (DEPRECATED) no value (flag) with default (default: true)

-h                 display this help and exit
-u                 display the usage and exit
-V                 display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.    Test the functionality regarding long options.
print_section "long options"

# 3.1.  Test the normal output.
test_number="3.1"
test_type="output"
cmd="bash test_long_options.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.2.  Test the usage message in "row" orientation.
test_number="3.2"
test_type="usage"
cmd="bash test_long_options.sh --usage"
output="$(cat << EOF
Usage: test_long_options.sh [-h | -u | -V] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1 --var-2,--var-b=VAL_2... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.3.  Test the usage message in "column" orientation.
test_number="3.3"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash test_long_options.sh --usage"
output="$(cat << EOF
Usage: test_long_options.sh [-h | -u | -V]
                            [--var-4,--var-d={A,B,C}]
                            [--var-5,--var-e=VAL_5]
                            [--var-6,--var-f]
                            [--var-7,--var-g]
                            --var-1,--var-a=VAL_1
                            --var-2,--var-b=VAL_2...
                            --var-3,--var-c={A,B}...
                            [{1,2}]
                            pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.4.  Test the help message.
test_number="3.4"
test_type="help"
cmd="bash test_long_options.sh --help"
output="$(cat << EOF
Usage: test_long_options.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                    one positional argument with default and
                                 choice (default: 2)
pos_2                            two positional arguments without default or
                                 choice

Mandatory options:
--var-1=VAL_1, --var-a=VAR-A     one value without default or choice
--var-2=VAL_2, --var-b=VAR-B     at least one value without default
                                 or choice
--var-3={A,B}, --var-c={A,B}     at least one value with choice

Optional options:
[--var-4={A,B,C}],               one value with default and choice
[--var-d={A,B,C}]                (default: A)
[--var-5=VAL_5], [--var-e=VAR-E] one value with default (default: E)
[--var-6, --var-f]               no value (flag) with default (default: false)
[--var-7, --var-g]               (DEPRECATED) no value (flag) with default
                                 (default: true)

--help                           display this help and exit
--usage                          display the usage and exit
--version                        display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 4.    Test the functionality regarding the environment.
print_section "environment"
exec 3>&1 4>&2

# 4.1.  Test the normal output.
test_number="4.1"
test_type="output"
cmd="bash test_environment.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 4.2.  Test the environment.
test_number="4.2"
test_type="environment"
print_fd_diff

exec 3>&- 4>&-

# 5.    Test the functionality regarding configuration files.
print_section "configuration files"

# 5.1.  Test the normal output.
test_number="5.1"
test_type="output"
cmd="bash test_config_file.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 5.2.  Test the usage message.
test_number="5.2"
test_type="usage"
cmd="bash test_config_file.sh --usage"
output="$(cat << EOF
Usage: test_config_file.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 5.3.  Test the help message.
test_number="5.3"
test_type="help"
cmd="bash test_config_file.sh --help"
output="$(cat << EOF
Usage: test_config_file.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]         one positional argument with default and choice (default:
                      2)
pos_2                 two positional arguments without default or choice

Mandatory options:
-a,   --var-1=VAL_1   one value without default or choice
-b,   --var-2=VAL_2   at least one value without default or choice
-c,   --var-3={A,B}   at least one value with choice

Optional options:
[-d={A,B,C}]          one value with default and choice (default: A)
      [--var-5=VAL_5] one value with default (default: E)
[-f], [--var-6]       no value (flag) with default (default: false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with default (default: true)

-h,   --help          display this help and exit
-u,   --usage         display the usage and exit
-V,   --version       display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 6.    Test the functionality regarding arguments definition files.
print_section "arguments definition files"

# 6.1.  Test the normal output.
test_number="6.1"
test_type="output"
cmd="bash test_arg_def_file.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 6.2.  Test the usage message.
test_number="6.2"
test_type="usage"
cmd="bash test_arg_def_file.sh --usage"
output="$(cat << EOF
Usage: test_arg_def_file.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 6.3.  Test the help message.
test_number="6.3"
test_type="help"
cmd="bash test_arg_def_file.sh --help"
output="$(cat << EOF
Usage: test_arg_def_file.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]         one positional argument with default and choice (default:
                      2)
pos_2                 two positional arguments without default or choice

Mandatory options:
-a,   --var-1=VAL_1   one value without default or choice
-b,   --var-2=VAL_2   at least one value without default or choice
-c,   --var-3={A,B}   at least one value with choice

Optional options:
[-d={A,B,C}]          one value with default and choice (default: A)
      [--var-5=VAL_5] one value with default (default: E)
[-f], [--var-6]       no value (flag) with default (default: false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with default (default: true)

-h,   --help          display this help and exit
-u,   --usage         display the usage and exit
-V,   --version       display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.    Test the functionality regarding help files.
print_section "help files"

# 7.1.  Test the normal output.
test_number="7.1"
test_type="output"
cmd="bash test_help_file.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.2.  Test the usage message.
test_number="7.2"
test_type="usage"
cmd="bash test_help_file.sh --usage"
output="$(cat << EOF
Usage: test_help_file.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.3.  Test the help message.
test_number="7.3"
test_type="help"
cmd="bash test_help_file.sh --help"
output="$(cat << EOF
A brief header summarizes the way how to interpret the help message.
Usage: test_help_file.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

The following arguments are positional.
Positional arguments:
[pos_1={1,2}]         one positional argument with default and choice (default:
                      2)
pos_2                 two positional arguments without default or choice

The following options have no default value.
Mandatory options:
-a,   --var-1=VAL_1   one value without default or choice
-b,   --var-2=VAL_2   at least one value without default or choice
-c,   --var-3={A,B}   at least one value with choice

The following options have a default value.
Optional options:
[-d={A,B,C}]          one value with default and choice (default: A)
      [--var-5=VAL_5] one value with default (default: E)
[-f], [--var-6]       no value (flag) with default (default: false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with default (default: true)

There are always three options for the help messages.
-h,   --help          display this help and exit
-u,   --usage         display the usage and exit
-V,   --version       display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.    Test the functionality regarding the localization.
print_section "localization"

# 8.1.  Test the normal output for the American locale.
test_number="8.1"
test_type="output"
cmd="LANG=en_US.UTF-8 bash test_localization.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.2.  Test the normal output for the German locale.
test_number="8.2"
test_type="output"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.3.  Test the usage message for the American locale.
test_number="8.3"
test_type="usage"
cmd="LANG=en_US.UTF-8 bash test_localization.sh --usage"
output="$(cat << EOF
Usage: test_localization.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.4.  Test the usage message for the German locale.
test_number="8.4"
test_type="usage"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh --usage"
output="$(cat << EOF
Aufruf: test_localization.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.5.  Test the help message for the American locale.
test_number="8.5"
test_type="help"
cmd="LANG=en_US.UTF-8 bash test_localization.sh --help"
output="$(cat << EOF
A brief header summarizes the way how to interpret the help message.
Usage: test_localization.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

The following arguments are positional.
Positional arguments:
[pos_1={1,2}]         one positional argument with default and choice
                      (default: 2)
pos_2                 two positional arguments without default or choice

The following options have no default value.
Mandatory options:
-a,   --var-1=VAL_1   one value without default or choice
-b,   --var-2=VAL_2   at least one value without default or choice
-c,   --var-3={A,B}   at least one value with choice

The following options have a default value.
Optional options:
[-d={A,B,C}]          one value with default and choice (default: A)
      [--var-5=VAL_5] one value with default (default: E)
[-f], [--var-6]       no value (flag) with default (default: false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with default (default: true)

There are always three options for the help messages.
-h,   --help          display this help and exit
-u,   --usage         display the usage and exit
-V,   --version       display the version and exit
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.6.  Test the help message for the German locale.
test_number="8.6"
test_type="help"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh --help"
output="$(cat << EOF
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
Aufruf: test_localization.sh [OPTIONEN] ARGUMENTE [--] [pos_1] pos_2

Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich.

Die folgenden Argumente sind positional.
Positionale Argumente:
[pos_1={1,2}]         ein positionales Argument mit Vorgabe und Auswahl
                      (Vorgabe: 2)
pos_2                 zwei positionale Argumente ohne Vorgabe oder Auswahl

Die folgenden Optionen haben keinen Vorgabewert.
Erforderliche Optionen:
-a,   --var-1=VAL_1   ein Wert ohne Vorgabe oder Auswahl
-b,   --var-2=VAL_2   mindestens ein Wert ohne Vorgabe oder Auswahl
-c,   --var-3={A,B}   mindestens ein Wert mit Auswahl

Die folgenden Optionen haben einen Vorgabewert.
Optionale Optionen:
[-d={A,B,C}]          ein Wert mit Vorgabe und Auswahl (Vorgabe: A)
      [--var-5=VAL_5] ein Wert mit Vorgabe (Vorgabe: E)
[-f], [--var-6]       kein Wert (Flag) mit Vorgabe (Vorgabe: falsch)
[-g], [--var-7]       (VERALTET) kein Wert (Flag) mit Vorgabe (Vorgabe: wahr)

Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
-h,   --help          diese Hilfe anzeigen und beenden
-u,   --usage         den Aufruf anzeigen und beenden
-V,   --version       die Version anzeigen und beenden
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# Print the summary and the reasons for the failures.
print_summary
printf '\e[33;1;7m%120s\n\e[0m' ""
print_failure_reasons

# Exit with the number of failed commands as exit code.
exit "${failed_cmd_count}"
