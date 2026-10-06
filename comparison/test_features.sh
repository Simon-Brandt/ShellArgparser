#!/usr/bin/env bash

###############################################################################
#                                                                             #
# Copyright 2026 Simon Brandt                                                 #
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
# Last Modification: 2026-10-06

# Usage: Run this script with
# "bash test_features.sh [--test-<feature>...]" or
# "bash test_features.sh [--test-all]".

# Purpose: Test the presence or absence of specific or all features of
# the command-line parsers (the Argparser, getopts, getopt, shFlags, and
# docopts).

shopt -s extglob

# Define the function for colorizing.
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
    local colorized_string
    local -A colors_and_styles
    local IFS
    local string
    local style
    local style_request
    local style_requests

    # Read the arguments.
    style_requests="$1"
    shift
    IFS=" "
    string="$*"
    unset IFS

    # Define the associative array with colors and styles, and their
    # corresponding Select Graphic Rendition (SGR) ANSI escape sequence
    # codes.
    colors_and_styles=(
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
    IFS="," read -r -a style_requests <<< "${style_requests}"
    for style_request in "${style_requests[@]}"; do
        style+=$'\e'"[${colors_and_styles[${style_request}]}m"
    done

    # Print the colorized string.  Possibly, right-pad the string.
    # Finally, reset the color/style.
    colorized_string="${style}${string}"
    printf '%s' "${colorized_string%$'\n'}"
    if [[ "${string: -1}" == $'\n' ]]; then
        printf '%*s' $(( 120 - ${#string} + 1 )) ""
        printf '\e[m\n'
    else
        printf '\e[m'
    fi
}

# Define the function for testing.
function test_feature() {
    # Test which parser supports the given feature.
    #
    # Argument:
    # - $1: the feature test's directory name
    # - $2: the feature's name and description
    # - $3: the expected test result for the Shell Argparser
    #       ("✓"/"*"/"✗")
    # - $4: the expected test result for getopts ("✓"/"*"/"✗")
    # - $5: the expected test result for getopt ("✓"/"*"/"✗")
    # - $6: the expected test result for shFlags ("✓"/"*"/"✗")
    # - $7: the expected test result for docopts ("✓"/"*"/"✗")
    # - $@: the command line arguments to pass to the parsers

    local actual_result
    local command_line
    local directory
    local expected_result
    local feature_description
    local parser
    local -a parsers
    local -A results
    local -a result_markers
    local script

    directory="$1"
    feature_description="$2"
    results=(
        [argparser]="$3"
        [getopts]="$4"
        [getopt]="$5"
        [shflags]="$6"
        [docopts]="$7"
    )
    shift 7
    command_line=("$@")

    parsers=(
        argparser
        getopts
        getopt
        shflags
        docopts
    )

    # Run each parser's test script.  Its exit code serves as indicator
    # whether the feature is supported or not---which may require
    # additional checks in the respective script to ensure correctness.
    # Ignore possible error and warning messages.
    result_markers=( )
    for parser in "${parsers[@]}"; do
        script="feature_tests/${directory}/test_${parser}.sh"
        if "${script}" "${command_line[@]}"; then
            actual_result="✓"
        else
            actual_result="✗"
        fi

        expected_result="${results[${parser}]}"
        if [[ "${actual_result}" == "${expected_result}" ]]; then
            result_markers+=("$(colorize "green" "${actual_result}")")
        else
            result_markers+=("$(colorize "red" "${actual_result}")")
        fi
    done

    # Write the results as new row to the result table.  Note that
    # specifying the padding using printf wouldn't work as the result
    # markers are colorized and thus longer than the one character
    # that's actually printed.
    printf '\u2502 %-44s \u2502 %s         \u2502 %s         \u2502 %s         \u2502 %s         \u2502 %s         \u2502\n' \
        "${feature_description}" "${result_markers[@]}"
}

# Parse the arguments.
ARGPARSER_MAX_COL_WIDTH_2=42
ARGPARSER_MAX_WIDTH=99
ARGPARSER_USE_SHORT_OPTIONS=false

declare test_all

# shellcheck disable=SC2190  # Indexed, not associative array.
args=(
    "id                                     | long_opts                              | defaults | type | arg_no | arg_group | help                                                                   "
    "test_all                               | test-all                               | false    | bool | 0      | Tests     | test the presence/absence of all features in the parsers               "
    "test_alternative_option_prefixes       | test-alternative-option-prefixes       | false    | bool | 0      | Tests     | test which parser supports alternative option prefixes (\"+\" or \"/\")"
    "test_argument_definition_files         | test-argument-definition-files         | false    | bool | 0      | Tests     | test which parser supports argument definition files                   "
    "test_argument_groups                   | test-argument-groups                   | false    | bool | 0      | Tests     | test which parser supports argument groups                             "
    "test_argument_intermixing              | test-argument-intermixing              | false    | bool | 0      | Tests     | test which parser supports intermixed positional and keyword arguments "
    "test_auto_set_variables                | test-auto-set-variables                | false    | bool | 0      | Tests     | test which parser supports the auto-setting of arguments to variables  "
    "test_choice_values                     | test-choice-values                     | false    | bool | 0      | Tests     | test which parser supports choice values                               "
    "test_configurable_parsing              | test-configurable-parsing              | false    | bool | 0      | Tests     | test which parser supports the configuration of the parsing            "
    "test_debug_mode                        | test-debug-mode                        | false    | bool | 0      | Tests     | test which parser contains a debug mode                                "
    "test_default_values                    | test-default-values                    | false    | bool | 0      | Tests     | test which parser supports default values                              "
    "test_deprecation_notes                 | test-deprecation-notes                 | false    | bool | 0      | Tests     | test which parser supports deprecation notes                           "
    "test_error_warning_silencing           | test-error-warning-silencing           | false    | bool | 0      | Tests     | test which parser supports the silencing of error and warning messages "
    "test_exit_codes_customization          | test-exit-codes-customization          | false    | bool | 0      | Tests     | test which parser supports customizing the exit codes                  "
    "test_flag_counting                     | test-flag-counting                     | false    | bool | 0      | Tests     | test which parser supports flag counting (\"-a -a\")                   "
    "test_flag_inversion                    | test-flag-inversion                    | false    | bool | 0      | Tests     | test which parser supports flag inversion (\"+a\"/\"++arg\")           "
    "test_flag_negation                     | test-flag-negation                     | false    | bool | 0      | Tests     | test which parser supports flag negation (\"--no-arg\")                "
    "test_flags                             | test-flags                             | false    | bool | 0      | Tests     | test which parser supports flags (Boolean options)                     "
    "test_help_message                      | test-help-message                      | false    | bool | 0      | Tests     | test which parser creates a help message                               "
    "test_help_options_customization        | test-help-options-customization        | false    | bool | 0      | Tests     | test which parser supports customizing the help options                "
    "test_internationalization_localization | test-internationalization-localization | false    | bool | 0      | Tests     | test which parser supports internationalization/localization           "
    "test_long_options                      | test-long-options                      | false    | bool | 0      | Tests     | test which parser supports long options                                "
    "test_mandatory_options                 | test-mandatory-options                 | false    | bool | 0      | Tests     | test which parser supports mandatory options                           "
    "test_message_stylization               | test-message-stylization               | false    | bool | 0      | Tests     | test which parser supports message stylization                         "
    "test_message_text_customization        | test-message-text-customization        | false    | bool | 0      | Tests     | test which parser supports customizing the message text                "
    "test_metavariables                     | test-metavariables                     | false    | bool | 0      | Tests     | test which parser supports metavariables (value names)                 "
    "test_mutually_exclusive_arguments      | test-mutually-exclusive-arguments      | false    | bool | 0      | Tests     | test which parser supports mutually exclusive arguments                "
    "test_option_abbreviation               | test-option-abbreviation               | false    | bool | 0      | Tests     | test which parser supports option abbreviation (\"--ar\")              "
    "test_option_aliases                    | test-option-aliases                    | false    | bool | 0      | Tests     | test which parser supports option aliases (\"-a\"/\"-A\")              "
    "test_option_merging                    | test-option-merging                    | false    | bool | 0      | Tests     | test which parser supports option merging (\"-ab\")                    "
    "test_positional_arguments              | test-positional-arguments              | false    | bool | 0      | Tests     | test which parser supports positional arguments                        "
    "test_positional_delimiter_hyphens      | test-positional-delimiter-hyphens      | false    | bool | 0      | Tests     | test which parser supports the positional arguments delimiter \"--\"   "
    "test_positional_delimiter_plus_signs   | test-positional-delimiter-plus-signs   | false    | bool | 0      | Tests     | test which parser supports the positional arguments delimiter \"++\"   "
    "test_posix_compliance                  | test-posix-compliance                  | false    | bool | 0      | Tests     | test which parser is POSIX-compliant                                   "
    "test_shell_independence                | test-shell-independence                | false    | bool | 0      | Tests     | test which parser is shell-independent                                 "
    "test_short_options                     | test-short-options                     | false    | bool | 0      | Tests     | test which parser supports short options                               "
    "test_single_hyphen_long_options        | test-single-hyphen-long-options        | false    | bool | 0      | Tests     | test which parser supports single-hyphen long options (\"-arg\")       "
    "test_type_checking                     | test-type-checking                     | false    | bool | 0      | Tests     | test which parser supports data type checking                          "
    "test_usage_message                     | test-usage-message                     | false    | bool | 0      | Tests     | test which parser creates a usage message                              "
    "test_variadic_arguments                | test-variadic-arguments                | false    | bool | 0      | Tests     | test which parser supports any argument number (multi-value arguments) "
    "test_version_message                   | test-version-message                   | false    | bool | 0      | Tests     | test which parser creates a version message                            "
)
source argparser -- "$@"

# Run the tests.
tests=(
    "Test name                              | Feature description                          | Command line    | argparser | getopts | getopt | shflags | docopts"
    "test_alternative_option_prefixes       | Alternative option prefixes (\"+\" or \"/\") | /v 1            | ✗         | ✗       | ✗      | ✗       | ✗      "
    "test_argument_definition_files         | Argument definition files                    |                 | ✓         | *       | *      | *       | *      "
    "test_argument_groups                   | Argument groups                              | -h              | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_argument_intermixing              | Intermixed positional and keyword arguments  | -v 1            | ✓         | ✗       | ✓      | ✗       | ✓      "
    "test_auto_set_variables                | Auto-setting of arguments to variables       |                 | ✓         | ✗       | ✗      | ✓       | ✓      "
    "test_choice_values                     | Choice values                                |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_configurable_parsing              | Configurable parsing                         |                 | ✓         | ✗       | ✓      | ✗       | ✗      "
    "test_debug_mode                        | Debug mode                                   |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_default_values                    | Default values                               |                 | ✓         | ✗       | ✗      | ✓       | ✓      "
    "test_deprecation_notes                 | Deprecation notes                            |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_error_warning_silencing           | Error/warning silencing                      |                 | ✓         | ✓       | ✓      | ✗       | ✗      "
    "test_exit_codes_customization          | Customizable exit codes                      |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_flag_counting                     | Flag counting (\"-a -a\")                    | -v -v           | ✓         | ✗       | ✗      | ✗       | *      "
    "test_flag_inversion                    | Flag inversion (\"+a\"/\"++arg\")            | +v              | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_flag_negation                     | Flag negation (\"--no-arg\")                 | ++var           | ✓         | ✗       | ✗      | ✓       | ✗      "
    "test_flags                             | Flags (Boolean options)                      | -v              | ✓         | ✓       | ✓      | ✓       | ✓      "
    "test_help_message                      | Help message                                 |                 | ✓         | ✗       | ✗      | ✓       | ✓      "
    "test_help_options_customization        | Customizable help options                    |                 | ✓         | *       | ✓      | ✗       | *      "
    "test_internationalization_localization | Internationalization / localization          |                 | ✓         | ✓       | ✓      | ✗       | ✗      "
    "test_long_options                      | Long options                                 | --var 1         | ✓         | ✗       | ✓      | ✓       | ✓      "
    "test_mandatory_options                 | Mandatory options                            |                 | ✓         | ✗       | ✗      | ✗       | ✓      "
    "test_message_stylization               | Message stylization                          |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_message_text_customization        | Customizable message text                    |                 | ✓         | *       | *      | ✓       | ✗      "
    "test_metavariables                     | Metavariables (value names)                  |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_mutually_exclusive_arguments      | Mutually exclusive arguments                 | -a -b           | ✗         | ✗       | ✗      | ✗       | ✓      "
    "test_option_abbreviation               | Option abbreviation (\"--ar\")               | --va 1          | ✓         | ✗       | ✓      | ✓       | ✓      "
    "test_option_aliases                    | Option aliases (\"-a\"/\"-A\")               | -v 1 -V 2       | ✓         | *       | *      | ✗       | ✓      "
    "test_option_merging                    | Option merging (\"-ab\")                     | -ab1            | ✓         | ✓       | ✓      | ✓       | ✓      "
    "test_positional_arguments              | Positional arguments                         | 1               | ✓         | *       | *      | *       | ✓      "
    "test_positional_delimiter_hyphens      | Positional arguments delimiter \"--\"        | -b 2 -- -a 1    | ✓         | ✓       | ✓      | ✓       | ✓      "
    "test_positional_delimiter_plus_signs   | Positional arguments delimiter \"++\"        | -- -a 1 ++ -b 2 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_posix_compliance                  | POSIX compliance                             |                 | ✗         | ✓       | *      | ✗       | ✗      "
    "test_shell_independence                | Shell independence (Bash, Dash, ksh93...)    |                 | ✓         | *       | ✓      | ✓       | ✓      "
    "test_short_options                     | Short options                                | -v 1            | ✓         | ✓       | ✓      | ✓       | ✓      "
    "test_single_hyphen_long_options        | Single-hyphen long options (\"-arg\")        | -var 1          | ✗         | ✗       | ✓      | ✗       | ✗      "
    "test_type_checking                     | Data type checking                           |                 | ✓         | ✗       | ✗      | ✓       | ✗      "
    "test_usage_message                     | Usage message                                |                 | ✓         | ✗       | ✗      | ✗       | ✗      "
    "test_variadic_arguments                | Any argument number (multi-value arguments)  |                 | ✓         | ✗       | ✗      | ✗       | ✓      "
    "test_version_message                   | Version message                              |                 | ✓         | ✗       | ✗      | ✗       | ✓      "
)

# Irrespective of how many tests have been requested, if all tests shall
# be run, enable them all, such that they are run exactly once, and not
# once by request of their command-line flag and once by request of the
# "--test-all" flag.
if [[ "${test_all}" == true ]]; then
    for test in "${tests[@]:1}"; do
        IFS="|" read -r -a test_definition <<< "${test}"

        test_name="${test_definition[0]}"
        test_name="${test_name%%+( )}"

        declare "${test_name}"=true
    done
fi

# Run all requested feature tests.  These are identified by parameter
# indirection of the given command-line arguments against all defined
# tests.  Compare the actual test result with the expected one and
# output a table indicating whether they're identical.  Check marks
# ("✓") indicate a feature's presence, asterisks ("*") its partial
# presence, and crosses ("✗") its absence.  Green marks show tests where
# the actual and expected results match, red those where the results
# don't match.
# First, print the table's header.
if (( "${#args[@]}" > 0 )); then
    printf -v top_rule '\u250C%46s\u252C%11s\u252C%11s\u252C%11s\u252C%11s\u252C%11s\u2510' \
        "" "" "" "" "" ""
    top_rule="${top_rule// /$'\u2500'}"
    printf "%s\n" "${top_rule}"

    printf '\u2502 %-44s \u2502 %-9s \u2502 %-9s \u2502 %-9s \u2502 %-9s \u2502 %-9s \u2502\n' \
        "Feature description" "argparser" "getopts" "getopt" "shflags" \
        "docopts"

    printf -v mid_rule '\u251C%46s\u253C%11s\u253C%11s\u253C%11s\u253C%11s\u253C%11s\u2524' \
        "" "" "" "" "" ""
    mid_rule="${mid_rule// /$'\u2500'}"
    printf "%s\n" "${mid_rule}"
fi

# Run each test and print a table row each.
for test in "${tests[@]:1}"; do
    IFS="|" read -r -a test_definition <<< "${test}"

    test_name="${test_definition[0]}"
    test_name="${test_name%%+( )}"

    feature_description="${test_definition[1]}"
    feature_description="${feature_description##+( )}"
    feature_description="${feature_description%%+( )}"

    IFS=" " read -r -a command_line <<< "${test_definition[2]}"

    result_argparser="${test_definition[3]}"
    result_argparser="${result_argparser##+( )}"
    result_argparser="${result_argparser%%+( )}"

    result_getopts="${test_definition[4]}"
    result_getopts="${result_getopts##+( )}"
    result_getopts="${result_getopts%%+( )}"

    result_getopt="${test_definition[5]}"
    result_getopt="${result_getopt##+( )}"
    result_getopt="${result_getopt%%+( )}"

    result_shflags="${test_definition[6]}"
    result_shflags="${result_shflags##+( )}"
    result_shflags="${result_shflags%%+( )}"

    result_docopts="${test_definition[7]}"
    result_docopts="${result_docopts##+( )}"
    result_docopts="${result_docopts%%+( )}"

    if [[ "${!test_name}" == true ]]; then
        test_feature "${test_name#test_}" "${feature_description}" \
            "${result_argparser}" "${result_getopts}" "${result_getopt}" \
            "${result_shflags}" "${result_docopts}" "${command_line[@]}" 
    fi
done

# Print the table's footer and legend.
if (( "${#args[@]}" > 0 )); then
    printf -v bottom_rule '\u2514%46s\u2534%11s\u2534%11s\u2534%11s\u2534%11s\u2534%11s\u2518' \
        "" "" "" "" "" ""
    bottom_rule="${bottom_rule// /$'\u2500'}"
    printf "%s\n" "${bottom_rule}"

    printf '\n%s\n' "$(colorize "bold" "Legend")"
    printf '%s: Test succeeded: Feature is present.\n' \
        "$(colorize "green" "✓")"
    printf '%s: Test succeeded: Feature is absent.\n' "$(colorize "green" "✗")"
    printf '%s: Test failed:    Feature is present.\n' "$(colorize "red" "✓")"
    printf '%s: Test failed:    Feature is absent.\n' "$(colorize "red" "✗")"
fi
