#!/usr/bin/env bash

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

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-11-04

# TODO: Add tests for errors in the the general arguments parsing.

# Usage: Run this script with "bash run_tests.sh".

# Purpose: Test the functionality of the Argparser by running all test
# scripts and comparing their output and errors to expected values.

# Set the locale.
export LC_ALL=en_US.UTF-8

# Define the functions for colorizing and printing the colored output.
function colorize() {
    # Colorize and format the string(s) using ANSI escape sequences.
    # If the last string ends in $'\n', right-pad the merged string to
    # 120 characters using spaces.  If using reverse video ("reverse"
    # style), this means that also the spaces (and thus the entire line)
    # are colored.
    #
    # Arguments:
    # - $1: the colors and/or styles to use as comma-separated list
    # - $@: the string(s) to colorize
    #
    # Output:
    # - the colorized string

    # Define the local variables.
    local IFS
    local request
    local requests
    local string
    local style
    local -A styles

    # Read the arguments.
    requests="$1"
    shift
    IFS=" "
    string="$*"
    unset IFS

    # Define the associative array with colors and styles, and their
    # corresponding Select Graphic Rendition (SGR) ANSI escape sequence
    # codes.
    styles=(
        [black]=30
        [red]=31
        [green]=32
        [yellow]=33
        [blue]=34
        [magenta]=35
        [cyan]=36
        [white]=37
        [normal]=22
        [bold]=1
        [faint]=2
        [italic]=3
        [underline]=4
        [double]=21
        [overline]=53
        [crossed-out]=9
        [blink]=5
        [reverse]=7
    )

    # Split the requested color and/or style on commas and replace it
    # with the corresponding escape sequence.
    style=""
    IFS="," read -r -a requests <<< "${requests}"
    for request in "${requests[@]}"; do
        style+="\e[${styles[${request}]}m"
    done

    # Print the colorized string.  Possibly, right-pad the string.
    # Finally, reset the color/style.

    # shellcheck disable=SC2059  # Escape sequence in variable.
    printf "${style}"
    printf '%s' "${string%$'\n'}"
    if [[ "${string: -1}" == $'\n' ]]; then
        printf '%*s' $(( 120 - ${#string} + 1 )) ""
        printf '\e[m\n'
    else
        printf '\e[m'
    fi
}

function print_single_separator() {
    # Print a line of 120 hyphens acting as visual separator, colored in
    # white.
    local separator
    printf -v separator '%120s' ""
    separator="${separator// /-}"
    colorize "white" "${separator}" $'\n'
}

function print_double_separator() {
    # Print a line of 120 equals signs acting as visual separator,
    # colored in blue.
    local separator
    printf -v separator '%120s' ""
    separator="${separator// /=}"
    colorize "cyan" "${separator}" $'\n'
}

# Define the function for printing the section names.
function print_section() {
    # Print the section name.
    #
    # Arguments:
    # - $1: the section's index
    # - $2: the section name to print
    colorize "yellow,bold,reverse" "$1: Running tests for $2" $'\n'
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

    printf 'Running test %s: ' "${test_number}"
    colorize "bold" "\"${cmd}\""
    printf '...\n'

    diff --side-by-side --suppress-common-lines --color=always --width=120 \
        <(
            if [[ -n "${error}" ]]; then
                printf '%s\n' "${error}"
            fi
            if [[ -n "${output}" ]]; then
                printf '%s\n' "${output}"
            fi
        ) \
        <(eval "${cmd}" 2>&1 3> /dev/null 4> /dev/null) \
        >&2
    exit_code="$?"

    if (( exit_code == 0 )); then
        colorize "green,bold,reverse" \
            "Test ${test_number} succeeded with correct output." $'\n'
        (( succeeded_cmd_count++ ))
    elif (( exit_code == 1 )); then
        print_single_separator
        colorize "red,bold,reverse" \
            "Test ${test_number} failed with diverging output." $'\n'

        failure_reasons+=("${test_type}")
        failed_cmds+=("${cmd}")
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
                --expression='/^BASH_ARGC=/d' \
                --expression='/^BASH_ARGV=/d' \
                --expression='/^BASHOPTS=/d' \
                --expression='/^PPID=/d' \
                --expression='/^_=/d' \
                --expression='/^args=/d') \
        <(eval "${cmd}" 4>&1 >& /dev/null 3> /dev/null \
            | sed \
                --expression='/^BASH_ARGC=/d' \
                --expression='/^BASH_ARGV=/d' \
                --expression='/^BASH_COMPAT=/d' \
                --expression='/^BASHOPTS=/d' \
                --expression='/^BASH_REMATCH=/d' \
                --expression='/^PPID=/d' \
                --expression='/^_=/d' \
                --expression='/^args=/d' \
                --expression='/^pos_.=/d' \
                --expression='/^var_.=/d') \
        >&2
    exit_code="$?"

    if (( exit_code == 0 )); then
        colorize "green,bold,reverse" \
            "Test ${test_number} succeeded with identical environment." $'\n'
    elif (( exit_code == 1 )); then
        print_single_separator
        colorize "red,bold,reverse" \
            "Test ${test_number} failed with diverging environment." $'\n'

        failure_reasons+=("${test_type}")
        failed_cmds+=("${cmd}")
        (( failed_cmd_count++ ))
    fi
    print_double_separator
}

# Define the functions for printing the summary.
function print_summary() {
    # Print a summary giving statistics over the run commands.
    local line

    colorize "yellow,bold,reverse" $'Summary:\n'

    printf -v line ' - %2s tests were run.' \
        $(( succeeded_cmd_count + failed_cmd_count ))
    colorize "yellow,bold,reverse" "${line}" $'\n'

    printf -v line ' - %2s tests succeeded.' "${succeeded_cmd_count}"
    colorize "yellow,bold,reverse" "${line}" $'\n'

    printf -v line ' - %2s tests failed.' "${failed_cmd_count}"
    colorize "yellow,bold,reverse" "${line}" $'\n'
}

function print_failure_reasons() {
    # Print the reasons for failures.
    if (( "${#failure_reasons}" == 0 )); then
        return
    fi
    colorize "yellow,bold,reverse" $'Reasons for failure:\n'

    mapfile -t failure_reasons \
        < <(printf '%s\n' "${failure_reasons[@]}" | sort --unique)
    for reason in "${failure_reasons[@]}"; do
        colorize "yellow,bold,reverse" " - ${reason}" $'\n'
    done
}

function print_failed_commands() {
    # Print the failed commands.
    if (( "${#failure_reasons}" == 0 )); then
        return
    fi
    colorize "yellow,bold,reverse" $'Failed commands:\n'

    mapfile -t failed_cmds \
        < <(printf '%s\n' "${failed_cmds[@]}" | sort --unique)
    for reason in "${failed_cmds[@]}"; do
        colorize "yellow,bold,reverse" " - ${reason}" $'\n'
    done
}

###############################################################################

# Set the variables for the tests.
test_section=0
failed_cmd_count=0
succeeded_cmd_count=0
failed_cmds=( )
failure_reasons=( )

###############################################################################

# 1.    Test the general functionality using test_basic.sh.
(( test_section++ ))
print_section "${test_section}" "general functionality"

# 1.1.  Test the normal output for short option names, using spaces.
test_number="${test_section}.1"
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
test_number="${test_section}.2"
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
test_number="${test_section}.3"
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
test_number="${test_section}.4"
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
test_number="${test_section}.5"
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
test_number="${test_section}.6"
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
test_number="${test_section}.7"
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
test_number="${test_section}.8"
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

# 1.9.  Test the version message using the short option name.
test_number="${test_section}.9"
test_type="version"
cmd="bash test_basic.sh -V"
output="$(cat << EOF
test_basic.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.10. Test the version message using the long option name.
test_number="${test_section}.10"
test_type="version"
cmd="bash test_basic.sh --version"
output="$(cat << EOF
test_basic.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.11. Test the usage using the short option name.
test_number="${test_section}.11"
test_type="usage"
cmd="bash test_basic.sh -u"
output="$(cat << EOF
Usage: test_basic.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.12. Test the usage message using the long option name.
test_number="${test_section}.12"
test_type="usage"
cmd="bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.13. Test the usage message in "row" orientation.
test_number="${test_section}.13"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_ORIENTATION=row bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.14. Test the usage message in "column" orientation.
test_number="${test_section}.14"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h,-? | -u | -V]
                     [-d,-D={A,B,C}]
                     [-e,-E=VAL_5,E]
                     [-f,-F]
                     [-g,-G]
                     -a,-A=VAL_1,A
                     -b,-B=VAL_2,B...
                     -c,-C={A,B}...
                     [{1,2}]
                     pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.15. Test the usage message with preferred short option names.
test_number="${test_section}.15"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_OPTION_TYPE=short bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.16. Test the usage message with preferred long option names.
test_number="${test_section}.16"
test_type="usage"
cmd="ARGPARSER_USAGE_MESSAGE_OPTION_TYPE=long bash test_basic.sh --usage"
output="$(cat << EOF
Usage: test_basic.sh [--help | --usage | --version] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5,VAR_E] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1,VAR_A --var-2,--var-b=VAL_2,VAR_B... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.17. Test the help message using the short option name.
test_number="${test_section}.17"
test_type="help"
cmd="bash test_basic.sh -h"
output="$(cat << EOF
Usage: test_basic.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                              one positional argument with default
                                           and choice (default: 2)
pos_2                                      two positional arguments without
                                           default or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR_A     one value without default or choice
-b, -B,   --var-2=VAL_2...,                at least one value without default
          --var-b=VAR_B...                 or choice
-c, -C,   --var-3={A,B}...,                at least one value with choice
          --var-c={A,B}...

Optional options:
[-d, -D], [--var-4={A,B,C}],               one value with default and choice
          [--var-d={A,B,C}]                (default: "A")
[-e, -E], [--var-5=VAL_5], [--var-e=VAR_E] one value with default (default:
                                           "E")
[-f, -F], [--var-6, --var-f]               no value (flag) with default
                                           (default: false)
[-g, -G], [--var-7, --var-g]               (DEPRECATED) no value (flag) with
                                           default (default: true)

[-h, -?], [--help]                         display this help and exit (default:
                                           false)
[-u],     [--usage]                        display the usage and exit (default:
                                           false)
[-V],     [--version]                      display the version and exit
                                           (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 1.18. Test the help message using the long option name.
test_number="${test_section}.18"
test_type="help"
cmd="bash test_basic.sh --help"
output="$(cat << EOF
Usage: test_basic.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                              one positional argument with default
                                           and choice (default: 2)
pos_2                                      two positional arguments without
                                           default or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR_A     one value without default or choice
-b, -B,   --var-2=VAL_2...,                at least one value without default
          --var-b=VAR_B...                 or choice
-c, -C,   --var-3={A,B}...,                at least one value with choice
          --var-c={A,B}...

Optional options:
[-d, -D], [--var-4={A,B,C}],               one value with default and choice
          [--var-d={A,B,C}]                (default: "A")
[-e, -E], [--var-5=VAL_5], [--var-e=VAR_E] one value with default (default:
                                           "E")
[-f, -F], [--var-6, --var-f]               no value (flag) with default
                                           (default: false)
[-g, -G], [--var-7, --var-g]               (DEPRECATED) no value (flag) with
                                           default (default: true)

[-h, -?], [--help]                         display this help and exit (default:
                                           false)
[-u],     [--usage]                        display the usage and exit (default:
                                           false)
[-V],     [--version]                      display the version and exit
                                           (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 2.    Test the functionality regarding short options.
(( test_section++ ))
print_section "${test_section}" "short options"

# 2.1.  Test the normal output.
test_number="${test_section}.1"
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

# 2.2.  Test the version message using the short option name.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_short_options.sh -V"
output="$(cat << EOF
test_short_options.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.3.  Test the version message using the long option name.
test_number="${test_section}.3"
test_type="version"
cmd="bash test_short_options.sh --version"
output=""
error="$(cat << EOF
test_short_options.sh: Error: The argument "--version" is unknown.

Usage: test_short_options.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 2.4.  Test the usage message using the short option name.
test_number="${test_section}.4"
test_type="usage"
cmd="bash test_short_options.sh -u"
output="$(cat << EOF
Usage: test_short_options.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.5.  Test the usage message using the long option name.
test_number="${test_section}.5"
test_type="usage"
cmd="bash test_short_options.sh --usage"
output=""
error="$(cat << EOF
test_short_options.sh: Error: The argument "--usage" is unknown.

Usage: test_short_options.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 2.6.  Test the help message using the short option name.
test_number="${test_section}.6"
test_type="help"
cmd="bash test_short_options.sh -h"
output="$(cat << EOF
Usage: test_short_options.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]      one positional argument with default and choice (default: 2)
pos_2              two positional arguments without default or choice

Mandatory options:
-a=VAL_1, -A=A     one value without default or choice
-b=VAL_2...,       at least one value without default or choice
-B=B...
-c={A,B}...,       at least one value with choice
-C={A,B}...

Optional options:
[-d={A,B,C}],      one value with default and choice (default: "A")
[-D={A,B,C}]
[-e=VAL_5], [-E=E] one value with default (default: "E")
[-f, -F]           no value (flag) with default (default: false)
[-g, -G]           (DEPRECATED) no value (flag) with default (default: true)

[-h, -?]           display this help and exit (default: false)
[-u]               display the usage and exit (default: false)
[-V]               display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 2.7.  Test the help message using the long option name.
test_number="${test_section}.7"
test_type="help"
cmd="bash test_short_options.sh --help"
output=""
error="$(cat << EOF
test_short_options.sh: Error: The argument "--help" is unknown.

Usage: test_short_options.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5,E] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 3.    Test the functionality regarding long options.
(( test_section++ ))
print_section "${test_section}" "long options"

# 3.1.  Test the normal output.
test_number="${test_section}.1"
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

# 3.2.  Test the version message using the short option name.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_long_options.sh -V"
output=""
error="$(cat << EOF
test_long_options.sh: Error: The argument "-V" is unknown.

Usage: test_long_options.sh [--help | --usage | --version] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5,VAR_E] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1,VAR_A --var-2,--var-b=VAL_2,VAR_B... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 3.3.  Test the version message using the long option name.
test_number="${test_section}.3"
test_type="version"
cmd="bash test_long_options.sh --version"
output="$(cat << EOF
test_long_options.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.4.  Test the usage message using the short option name.
test_number="${test_section}.4"
test_type="usage"
cmd="bash test_long_options.sh -u"
output=""
error="$(cat << EOF
test_long_options.sh: Error: The argument "-u" is unknown.

Usage: test_long_options.sh [--help | --usage | --version] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5,VAR_E] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1,VAR_A --var-2,--var-b=VAL_2,VAR_B... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 3.5.  Test the usage message using the long option name.
test_number="${test_section}.5"
test_type="usage"
cmd="bash test_long_options.sh --usage"
output="$(cat << EOF
Usage: test_long_options.sh [--help | --usage | --version] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5,VAR_E] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1,VAR_A --var-2,--var-b=VAL_2,VAR_B... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 3.6.  Test the help message using the short option name.
test_number="${test_section}.6"
test_type="help"
cmd="bash test_long_options.sh -h"
output=""
error="$(cat << EOF
test_long_options.sh: Error: The argument "-h" is unknown.

Usage: test_long_options.sh [--help | --usage | --version] [--var-4,--var-d={A,B,C}] [--var-5,--var-e=VAL_5,VAR_E] [--var-6,--var-f] [--var-7,--var-g] --var-1,--var-a=VAL_1,VAR_A --var-2,--var-b=VAL_2,VAR_B... --var-3,--var-c={A,B}... [{1,2}] pos_2
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 3.7.  Test the help message using the long option name.
test_number="${test_section}.7"
test_type="help"
cmd="bash test_long_options.sh --help"
output="$(cat << EOF
Usage: test_long_options.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                    one positional argument with default and
                                 choice (default: 2)
pos_2                            two positional arguments without default or
                                 choice

Mandatory options:
--var-1=VAL_1, --var-a=VAR_A     one value without default or choice
--var-2=VAL_2...,                at least one value without default or choice
--var-b=VAR_B...
--var-3={A,B}...,                at least one value with choice
--var-c={A,B}...

Optional options:
[--var-4={A,B,C}],               one value with default and choice (default:
[--var-d={A,B,C}]                "A")
[--var-5=VAL_5], [--var-e=VAR_E] one value with default (default: "E")
[--var-6, --var-f]               no value (flag) with default (default: false)
[--var-7, --var-g]               (DEPRECATED) no value (flag) with default
                                 (default: true)

[--help]                         display this help and exit (default: false)
[--usage]                        display the usage and exit (default: false)
[--version]                      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 4.    Test the functionality regarding keyword arguments.
(( test_section++ ))
print_section "${test_section}" "keyword arguments"

# 4.1.  Test the normal output.
test_number="${test_section}.1"
test_type="output"
cmd="bash test_keyword_arguments.sh --var-1 1 --var-2 2 --var-3 A"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 4.2.  Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_keyword_arguments.sh --version"
output="$(cat << EOF
test_keyword_arguments.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 4.3.  Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_keyword_arguments.sh --usage"
output="$(cat << EOF
Usage: test_keyword_arguments.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}...
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 4.4.  Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_keyword_arguments.sh --help"
output="$(cat << EOF
Usage: test_keyword_arguments.sh [OPTIONS] ARGUMENTS

Mandatory arguments to long options are mandatory for short options too.

Mandatory options:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

Optional options:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 5.    Test the functionality regarding positional arguments.
(( test_section++ ))
print_section "${test_section}" "positional arguments"

# 5.1.  Test the normal output.
test_number="${test_section}.1"
test_type="output"
cmd="bash test_positional_arguments.sh 1 2"
output="$(cat << EOF
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 5.2.  Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_positional_arguments.sh --version"
output="$(cat << EOF
test_positional_arguments.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 5.3.  Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_positional_arguments.sh --usage"
output="$(cat << EOF
Usage: test_positional_arguments.sh [-h,-? | -u | -V] [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 5.4.  Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_positional_arguments.sh --help"
output="$(cat << EOF
Usage: test_positional_arguments.sh [pos_1] pos_2

Positional arguments:
[pos_1={1,2}]         one positional argument with default and choice (default:
                      2)
pos_2                 two positional arguments without default or choice

[-h, -?], [--help]    display this help and exit (default: false)
[-u],     [--usage]   display the usage and exit (default: false)
[-V],     [--version] display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 6.    Test the functionality regarding the environment.
(( test_section++ ))
print_section "${test_section}" "environment"
exec 3>&1 4>&2

# 6.1.  Test the normal output.
test_number="${test_section}.1"
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

# 6.2.  Test the environment.
test_number="${test_section}.2"
test_type="environment"
print_fd_diff

exec 3>&- 4>&-

###############################################################################

# 7.    Test the functionality regarding the variable argument number.
(( test_section++ ))
print_section "${test_section}" "argument number"

# 7.1.  Test the normal output.
test_number="${test_section}.1"
test_type="output"
cmd="bash test_arg_number.sh 1 2 --var-1 1 --var-2 2 --var-3 A B A --var-4 B --var-5"
output="$(cat << EOF
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A,B,A".
The keyword argument "var_4" is set to "B".
The keyword argument "var_5" is set to "true".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.2.  Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_arg_number.sh --version"
output="$(cat << EOF
test_arg_number.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.3.  Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_arg_number.sh --usage"
output="$(cat << EOF
Usage: test_arg_number.sh [-h,-? | -u | -V] [-d,-D[={A,B,C}...]] [-e,-E[=VAL_5,E]] [-f,-F] [-g,-G] -a,-A=VAL_1,A -b,-B=VAL_2,B... -c,-C={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 7.4.  Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_arg_number.sh --help"
output="$(cat << EOF
Usage: test_arg_number.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                          one positional argument with default and
                                       choice (default: 2)
pos_2                                  two positional arguments without default
                                       or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR_A one value without default or choice
-b, -B,   --var-2=VAL_2...,            at least one value without default or
          --var-b=VAR_B...             choice
-c, -C,   --var-3={A,B}...,            at least one value with choice
          --var-c={A,B}...

Optional options:
[-d, -D], [--var-4[={A,B,C}...]],      arbitrarily many values with default and
          [--var-d[={A,B,C}...]]       choice (default: "false")
[-e, -E], [--var-5[=VAL_5]],           one optional value with default
          [--var-e[=VAR_E]]            (default: "true")
[-f, -F], [--var-6, --var-f]           no value (flag) with default (default:
                                       false)
[-g, -G], [--var-7, --var-g]           (DEPRECATED) no value (flag) with
                                       default (default: true)

[-h, -?], [--help]                     display this help and exit (default:
                                       false)
[-u],     [--usage]                    display the usage and exit (default:
                                       false)
[-V],     [--version]                  display the version and exit (default:
                                       false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 8.    Test the functionality regarding configuration files.
(( test_section++ ))
print_section "${test_section}" "configuration files"

# 8.1.  Test the normal output.
test_number="${test_section}.1"
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

# 8.2.  Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_config_file.sh --version"
output="$(cat << EOF
test_config_file.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.3.  Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_config_file.sh --usage"
output="$(cat << EOF
Usage: test_config_file.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 8.4.  Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_config_file.sh --help"
output="$(cat << EOF
Usage: test_config_file.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]              one positional argument with default and choice
                           (default: 2)
pos_2                      two positional arguments without default or choice

Mandatory options:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

Optional options:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 9.    Test the functionality regarding arguments definition files.
(( test_section++ ))
print_section "${test_section}" "arguments definition files"

# 9.1.  Test the normal output.
test_number="${test_section}.1"
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

# 9.2.  Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_arg_def_file.sh --version"
output="$(cat << EOF
test_arg_def_file.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 9.3.  Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_arg_def_file.sh --usage"
output="$(cat << EOF
Usage: test_arg_def_file.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 9.4.  Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_arg_def_file.sh --help"
output="$(cat << EOF
Usage: test_arg_def_file.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]              one positional argument with default and choice
                           (default: 2)
pos_2                      two positional arguments without default or choice

Mandatory options:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

Optional options:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 10.   Test the functionality regarding help files.
(( test_section++ ))
print_section "${test_section}" "help files"

# 10.1. Test the normal output.
test_number="${test_section}.1"
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

# 10.2. Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash test_help_file.sh --version"
output="$(cat << EOF
test_help_file.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 10.3. Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash test_help_file.sh --usage"
output="$(cat << EOF
Usage: test_help_file.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 10.4. Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash test_help_file.sh --help"
output="$(cat << EOF
A brief header summarizes the way how to interpret the help message.
Usage: test_help_file.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

The following arguments are positional:
[pos_1={1,2}]              one positional argument with default and choice
                           (default: 2)
pos_2                      two positional arguments without default or choice

The following options have no default value:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

The following options have a default value:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

There are always three options for the help messages:
[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 11.   Test the functionality regarding the localization.
(( test_section++ ))
print_section "${test_section}" "localization"

# 11.1. Test the normal output for the American locale.
test_number="${test_section}.1"
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

# 11.2. Test the normal output for the German locale.
test_number="${test_section}.2"
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

# 11.3. Test the version message for the American locale.
test_number="${test_section}.3"
test_type="version"
cmd="LANG=en_US.UTF-8 bash test_localization.sh --version"
output="$(cat << EOF
test_localization.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 11.4. Test the version message for the German locale.
test_number="${test_section}.4"
test_type="version"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh --version"
output="$(cat << EOF
test_localization.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 11.5. Test the usage message for the American locale.
test_number="${test_section}.5"
test_type="usage"
cmd="LANG=en_US.UTF-8 bash test_localization.sh --usage"
output="$(cat << EOF
Usage: test_localization.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 11.6. Test the usage message for the German locale.
test_number="${test_section}.6"
test_type="usage"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh --usage"
output="$(cat << EOF
Aufruf: test_localization.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 11.7. Test the help message for the American locale.
test_number="${test_section}.7"
test_type="help"
cmd="LANG=en_US.UTF-8 bash test_localization.sh --help"
output="$(cat << EOF
A brief header summarizes the way how to interpret the help message.
Usage: test_localization.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

The following arguments are positional:
[pos_1={1,2}]              one positional argument with default and choice
                           (default: 2)
pos_2                      two positional arguments without default or choice

The following options have no default value:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

The following options have a default value:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

There are always three options for the help messages:
[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 11.8. Test the help message for the German locale.
test_number="${test_section}.8"
test_type="help"
cmd="LANG=de_DE.UTF-8 bash test_localization.sh --help"
output="$(cat << EOF
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
Aufruf: test_localization.sh [OPTIONEN] ARGUMENTE -- [pos_1] pos_2

Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich.

Die folgenden Argumente sind positional:
[pos_1={1,2}]              ein positionales Argument mit Vorgabe und Auswahl
                           (Vorgabe: 2)
pos_2                      zwei positionale Argumente ohne Vorgabe oder Auswahl

Die folgenden Optionen haben keinen Vorgabewert:
-a,       --var-1=VAL_1    ein Wert ohne Vorgabe oder Auswahl
-b,       --var-2=VAL_2... mindestens ein Wert ohne Vorgabe oder Auswahl
-c,       --var-3={A,B}... mindestens ein Wert mit Auswahl

Die folgenden Optionen haben einen Vorgabewert:
[-d={A,B,C}]               ein Wert mit Vorgabe und Auswahl (Vorgabe: "A")
          [--var-5=VAL_5]  ein Wert mit Vorgabe (Vorgabe: "E")
[-f],     [--var-6]        kein Wert (Flag) mit Vorgabe (Vorgabe: falsch)
[-g],     [--var-7]        (VERALTET) kein Wert (Flag) mit Vorgabe (Vorgabe:
                           wahr)

Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen:
[-h, -?], [--help]         diese Hilfe anzeigen und beenden (Vorgabe: falsch)
[-u],     [--usage]        den Aufruf anzeigen und beenden (Vorgabe: falsch)
[-V],     [--version]      die Version anzeigen und beenden (Vorgabe: falsch)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 12.   Test the functionality regarding the standalone mode in a
#       pipeline.
(( test_section++ ))
print_section "${test_section}" "pipeline"

# 12.1. Test the normal output.
test_number="${test_section}.1"
test_type="output"
cmd="dash test_pipeline.sh 1 2 --var-1 1 --var-2 2 --var-3 A"
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
error="$(cat << EOF
pos_1=2
pos_2=1,2
var_1=1
var_2=2
var_3=A
var_4=A
var_5=E
var_6=false
var_7=true
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 12.2. Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="dash test_pipeline.sh --version"
output="$(cat << EOF
test_pipeline.sh v1.0.0
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 12.3. Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="dash test_pipeline.sh --usage"
output="$(cat << EOF
Usage: test_pipeline.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 12.4. Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="dash test_pipeline.sh --help"
output="$(cat << EOF
Usage: test_pipeline.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]              one positional argument with default and choice
                           (default: 2)
pos_2                      two positional arguments without default or choice

Mandatory options:
-a,       --var-1=VAL_1    one value without default or choice
-b,       --var-2=VAL_2... at least one value without default or choice
-c,       --var-3={A,B}... at least one value with choice

Optional options:
[-d={A,B,C}]               one value with default and choice (default: "A")
          [--var-5=VAL_5]  one value with default (default: "E")
[-f],     [--var-6]        no value (flag) with default (default: false)
[-g],     [--var-7]        (DEPRECATED) no value (flag) with default (default:
                           true)

[-h, -?], [--help]         display this help and exit (default: false)
[-u],     [--usage]        display the usage and exit (default: false)
[-V],     [--version]      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# 13.   Test the functionality regarding the standalone usage.
(( test_section++ ))
print_section "${test_section}" "standalone usage"

# 13.1. Test the normal output.
test_number="${test_section}.1"
test_type="output"
cmd="bash ../argparser"
output=""
error="$(cat << EOF
argparser: Error: Calling (instead of sourcing) the Argparser requires the arguments definition to be provided through STDIN, separated by newlines.  Either pipe to the Argparser or use process substitution to give input.  Alternatively, try "argparser --help" to get a help message with further information.
EOF
)"
print_diff "${cmd}" "${output}" "${error}"

# 13.2. Test the version message.
test_number="${test_section}.2"
test_type="version"
cmd="bash ../argparser --version"
output="$(cat << EOF
argparser v1.2.0 "Callospermophilus lateralis"
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 13.3. Test the usage message.
test_number="${test_section}.3"
test_type="usage"
cmd="bash ../argparser --usage"
output="$(cat << EOF
Usage: argparser [--help | --usage | --version]
                 [--add-help]
                 [--add-usage]
                 [--add-version]
                 [--allow-arg-intermixing]
                 [--allow-flag-inversion]
                 [--allow-flag-negation]
                 [--allow-option-abbreviation]
                 [--allow-option-merging]
                 [--arg-array-name=NAME]
                 [--arg-def-file=FILE]
                 [--arg-delimiter-1=CHAR]
                 [--arg-delimiter-2=CHAR]
                 [--check-arg-def]
                 [--check-env-vars]
                 [--config-file=FILE]
                 [--count-flags]
                 [--create-arg-def]
                 [--debug]
                 [--error-exit-code=INT]
                 [--error-style=STYLE...]
                 [--help-arg-group=NAME]
                 [--help-description=TEXT]
                 [--help-exit-code=INT]
                 [--help-file=FILE]
                 [--help-file-include-char=CHAR]
                 [--help-file-keep-comments]
                 [--help-options=CHAR...]
                 [--help-style=STYLE...]
                 [--language=LANG]
                 [--max-col-width-1=INT]
                 [--max-col-width-2=INT]
                 [--max-col-width-3=INT]
                 [--max-width=INT]
                 [--positional-arg-group=NAME]
                 [--read-args]
                 [--script-name=NAME]
                 [--set-args]
                 [--set-arrays]
                 [--silence-errors]
                 [--silence-warnings]
                 [--style-file=FILE]
                 [--translation-file=FILE]
                 [--unset-args]
                 [--unset-env-vars]
                 [--unset-functions]
                 [--usage-exit-code=INT]
                 [--usage-file=FILE]
                 [--usage-file-include-char=CHAR]
                 [--usage-file-keep-comments]
                 [--usage-message-option-type={long,short}]
                 [--usage-message-orientation={row,column}]
                 [--usage-options=CHAR...]
                 [--usage-style=STYLE...]
                 [--use-long-options]
                 [--use-short-options]
                 [--use-styles={always,never,file,tty}]
                 [--use-styles-in-files]
                 [--version-exit-code=INT]
                 [--version-number=VERSION]
                 [--version-options=CHAR...]
                 [--version-style=STYLE...]
                 [--warning-style=STYLE...]
                 [--write-args]
                 command_line...
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

# 13.4. Test the help message.
test_number="${test_section}.4"
test_type="help"
cmd="bash ../argparser --help"
output="$(cat << EOF
Usage: argparser [OPTIONS] [--] command_line

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
command_line...                  the indexed array in which the Argparser
                                 stores the script's command line upon parsing
                                 its own arguments

Options:
[--add-help]                     add ARGPARSER_HELP_OPTIONS and --help as flags
                                 to call the help message (default: true)
[--add-usage]                    add ARGPARSER_USAGE_OPTIONS and --usage as
                                 flags to call the usage message (default:
                                 true)
[--add-version]                  add ARGPARSER_VERSION_OPTIONS and --version as
                                 flags to call the version message (default:
                                 true)
[--allow-arg-intermixing]        allow the user to intermix positional and
                                 keyword arguments (default: true)
[--allow-flag-inversion]         allow the user to invert flags by prefixing
                                 them with "+" (short options) or "++" (long
                                 options) (default: true)
[--allow-flag-negation]          allow the user to negate long-option flags by
                                 prefixing them with "no-" (default: true)
[--allow-option-abbreviation]    allow the user to give long option names in
                                 abbreviated form (default: false)
[--allow-option-merging]         allow the user to give short option names in
                                 merged (concatenated) form (default: false)
[--arg-array-name=NAME]          the indexed array for the raw arguments and
                                 the associative array for the parsed arguments
                                 (default: "args")
[--arg-def-file=FILE]            the path to a file holding the definition of
                                 the arguments (default: "''")
[--arg-delimiter-1=CHAR]         the primary delimiter that separates the
                                 fields in the arguments definition (default:
                                 "|")
[--arg-delimiter-2=CHAR]         the secondary delimiter that separates the
                                 elements of sequences in the arguments
                                 definition (default: ",")
[--check-arg-def]                check if the arguments definition is
                                 consistent (default: false)
[--check-env-vars]               check if the Argparser environment variables
                                 accord to their definition (default: false)
[--config-file=FILE]             the path to a file holding the Argparser
                                 configuration (default: "''")
[--count-flags]                  count flags instead of setting them to "true"
                                 or "false" based on the last prefix used on
                                 the command line (default: false)
[--create-arg-def]               create the arguments definition for a script
                                 (default: false)
[--debug]                        (EXPERT OPTION) run the Argparser in debug
                                 mode, writing the stack trace for each command
                                 to STDERR (default: false)
[--error-exit-code=INT]          the exit code when errors occurred upon
                                 parsing (default: 1)
[--error-style=STYLE...]         (DEPRECATED) the color and style specification
                                 for error messages, deprecated in favor of
                                 "--style-file=FILE" (default:
                                 "red","bold","reverse")
[--help-arg-group=NAME]          the name of the argument group holding all
                                 help options, i.e., --help, --usage, and
                                 --version (default: "Help options")
[--help-description=TEXT]        the script's description (purpose) to show in
                                 help message (default: "''")
[--help-exit-code=INT]           the exit code for help messages (default: 0)
[--help-file=FILE]               the path to a file holding the extended help
                                 message (default: "''")
[--help-file-include-char=CHAR]  the character that introduces an include
                                 directive in an ARGPARSER_HELP_FILE (default:
                                 "@")
[--help-file-keep-comments]      keep commented lines in the help file
                                 (default: false)
[--help-options=CHAR...]         the short (single-character) option names to
                                 invoke the help message (default: "h","?")
[--help-style=STYLE...]          (DEPRECATED) the color and style specification
                                 for help messages, deprecated in favor of
                                 "--style-file=FILE" (default: "italic")
[--language=LANG]                the language in which to localize the help and
                                 usage messages (default: "en")
[--max-col-width-1=INT]          the maximum column width of the first column
                                 in the help message (default: 9)
[--max-col-width-2=INT]          the maximum column width of the second column
                                 in the help message (default: 33)
[--max-col-width-3=INT]          the maximum column width of the third column
                                 in the help message (default: 0)
[--max-width=INT]                the maximum width of the help message
                                 (default: 79)
[--positional-arg-group=NAME]    the name of the argument group holding all
                                 positional arguments (default: "Positional
                                 arguments")
[--read-args]                    read the arguments and parse them to
                                 ARGPARSER_ARG_ARRAY_NAME (default: true)
[--script-name=NAME]             the script's name for the help, usage,
                                 version, error, and warning messages (default:
                                 "''")
[--set-args]                     set the arguments from
                                 ARGPARSER_ARG_ARRAY_NAME as variables in the
                                 script's scope (default: true)
[--set-arrays]                   set arguments intended to have multiple values
                                 as indexed array (default: true)
[--silence-errors]               silence the emission (output) of error
                                 messages (default: false)
[--silence-warnings]             silence the emission (output) of warning
                                 messages (default: false)
[--style-file=FILE]              the path to a file holding the style
                                 definitions for the messages (default: "''")
[--translation-file=FILE]        the path to a simplified YAML file holding the
                                 translation to ARGPARSER_LANGUAGE (default:
                                 "''")
[--unset-args]                   unset (remove) all command-line arguments
                                 given to the script (default: true)
[--unset-env-vars]               unset (remove) the Argparser environment
                                 variables from the environment (default: true)
[--unset-functions]              unset (remove) the Argparser functions from
                                 the environment (default: true)
[--usage-exit-code=INT]          the exit code for usage messages (default: 0)
[--usage-file=FILE]              the path to a file holding the extended usage
                                 message (default: "''")
[--usage-file-include-char=CHAR] the character that introduces an include
                                 directive in an ARGPARSER_USAGE_FILE (default:
                                 "@")
[--usage-file-keep-comments]     keep commented lines in the usage file
                                 (default: false)
[--usage-message-option-type={long,short}]
                                 use short or long option names in usage
                                 messages (default: "short")
[--usage-message-orientation={row,column}]
                                 output the positional and keyword arguments in
                                 usage messages in a row or in a column
                                 (default: "row")
[--usage-options=CHAR...]        the short (single-character) option names to
                                 invoke the usage message (default: "u")
[--usage-style=STYLE...]         (DEPRECATED) the color and style specification
                                 for usage messages, deprecated in favor of
                                 "--style-file=FILE" (default: "italic")
[--use-long-options]             use the long option names for parsing
                                 (default: true)
[--use-short-options]            use the short option names for parsing
                                 (default: true)
[--use-styles={always,never,file,tty}]
                                 use the colors and styles "always", "never",
                                 or only when STDOUT/STDERR is ("tty") or is
                                 not ("file") a terminal (default: "tty")
[--use-styles-in-files]          (DEPRECATED) use the colors and styles when
                                 STDOUT/STDERR is not a terminal, deprecated in
                                 favor of "--use-styles=always" (default:
                                 false)
[--version-exit-code=INT]        the exit code for version messages (default:
                                 0)
[--version-number=VERSION]       the script's version number for the version
                                 message (default: "1.0.0")
[--version-options=CHAR...]      the short (single-character) option names to
                                 invoke the version message (default: "V")
[--version-style=STYLE...]       (DEPRECATED) the color and style specification
                                 for version messages, deprecated in favor of
                                 "--style-file=FILE" (default: "bold")
[--warning-style=STYLE...]       (DEPRECATED) the color and style specification
                                 for warning messages, deprecated in favor of
                                 "--style-file=FILE" (default: "red","bold")
[--write-args]                   write the arguments from
                                 ARGPARSER_ARG_ARRAY_NAME to STDOUT (default:
                                 false)

[--help]                         display this help and exit (default: false)
[--usage]                        display the usage and exit (default: false)
[--version]                      display the version and exit (default: false)
EOF
)"
error=""
print_diff "${cmd}" "${output}" "${error}"

###############################################################################

# Print the summary and the reasons for the failures.
print_summary

if (( failed_cmd_count > 0 )); then
    colorize "yellow,bold,reverse" $'\n'
    print_failure_reasons
    colorize "yellow,bold,reverse" $'\n'
    print_failed_commands
fi

# Exit with the number of failed commands as exit code.
exit "${failed_cmd_count}"
