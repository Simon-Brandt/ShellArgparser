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
# Last Modification: 2026-10-02

# Usage: Run this script with
# "bash test_features.sh [--test-<feature>...]" or
# "bash test_features.sh [--test-all]".

# Purpose: Test the presence or absence of specific or all features of
# the command-line parsers (getopts, getopt, shFlags, docopts, Shell
# Argparser).

shopt -s extglob

# Define the function for testing.
function test_feature() {
    # Test which parser supports the given feature.
    #
    # Argument:
    # - $1: the feature test's directory name
    # - $2: the feature's name
    # - $@: the command line arguments to pass to the parsers

    local command_line
    local directory
    local feature_name
    local parser
    local -a parsers
    local script

    directory="$1"
    feature_name="$2"
    shift 2
    command_line=("$@")

    parsers=(
        getopts
        getopt
        shflags
        docopts
        argparser
    )

    printf '%s:\n' "${feature_name}"
    for parser in "${parsers[@]}"; do
        # Run each parser's test script.  Its exit code serves as
        # indicator whether the feature is supported or not---which may
        # require additional checks in the respective script to ensure
        # correctness.  Ignore possible error and warning messages.
        script="feature_tests/${directory}/test_${parser}.sh"
        if "${script}" "${command_line[@]}" &> /dev/null; then
            printf -- '- %s:%*s✓\n' "${parser}" "$(( "${#parser}" - 10 ))" ""
        else
            printf -- '- %s:%*s✗\n' "${parser}" "$(( "${#parser}" - 10 ))" ""
        fi
    done
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
    "test_inheritable_argument_definition   | test-inheritable-argument-definition   | false    | bool | 0      | Tests     | test which parser supports inheriting the argument definition          "
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
    "Test name                              | Feature description                          | Command line   "
    "test_alternative_option_prefixes       | Alternative option prefixes (\"+\" or \"/\") | /v 1           "
    "test_argument_definition_files         | Argument definition files                    |                "
    "test_argument_groups                   | Argument groups                              | -h             "
    "test_argument_intermixing              | Intermixed positional and keyword arguments  | -v 1           "
    "test_auto_set_variables                | Auto-setting of arguments to variables       |                "
    "test_choice_values                     | Choice values                                |                "
    "test_configurable_parsing              | Configurable parsing                         |                "
    "test_debug_mode                        | Debug mode                                   |                "
    "test_default_values                    | Default values                               |                "
    "test_deprecation_notes                 | Deprecation notes                            |                "
    "test_error_warning_silencing           | Error/warning silencing                      |                "
    "test_exit_codes_customization          | Customizable exit codes                      |                "
    "test_flag_counting                     | Flag counting (\"-a -a\")                    | -v -v          "
    "test_flag_inversion                    | Flag inversion (\"+a\"/\"++arg\")            | +v             "
    "test_flag_negation                     | Flag negation (\"--no-arg\")                 | ++var          "
    "test_flags                             | Flags (Boolean options)                      | -v             "
    "test_help_message                      | Help message                                 |                "
    "test_help_options_customization        | Customizable help options                    |                "
    "test_inheritable_argument_definition   | Inheritable argument definition              |                "
    "test_internationalization_localization | Internationalization / localization          |                "
    "test_long_options                      | Long options                                 | --var 1        "
    "test_mandatory_options                 | Mandatory options                            |                "
    "test_message_stylization               | Message stylization                          |                "
    "test_message_text_customization        | Customizable message text                    |                "
    "test_metavariables                     | Metavariables (value names)                  |                "
    "test_mutually_exclusive_arguments      | Mutually exclusive arguments                 | -a -b          "
    "test_option_abbreviation               | Option abbreviation (\"--ar\")               | --va 1         "
    "test_option_aliases                    | Option aliases (\"-a\"/\"-A\")               | -v 1 -V 2      "
    "test_option_merging                    | Option merging (\"-ab\")                     | -ab1           "
    "test_positional_arguments              | Positional arguments                         | 1              "
    "test_positional_delimiter_hyphens      | Positional arguments delimiter \"--\"        | -b 2 -- -a 1   "
    "test_positional_delimiter_plus_signs   | Positional arguments delimiter \"++\"        | -- -a 1 ++ -b 2"
    "test_posix_compliance                  | POSIX compliance                             |                "
    "test_shell_independence                | Shell independence (Bash, Dash, ksh93...)    |                "
    "test_short_options                     | Short options                                | -v 1           "
    "test_single_hyphen_long_options        | Single-hyphen long options (\"-arg\")        | -var 1         "
    "test_type_checking                     | Data type checking                           |                "
    "test_usage_message                     | Usage message                                |                "
    "test_variadic_arguments                | Any argument number (multi-value arguments)  |                "
    "test_version_message                   | Version message                              |                "
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
# tests.
for test in "${tests[@]:1}"; do
    IFS="|" read -r -a test_definition <<< "${test}"

    test_name="${test_definition[0]}"
    test_name="${test_name%%+( )}"

    feature_description="${test_definition[1]}"
    feature_description="${feature_description##+( )}"
    feature_description="${feature_description%%+( )}"

    IFS=" " read -r -a command_line <<< "${test_definition[2]}"

    if [[ "${!test_name}" == true ]]; then
        test_feature "${test_name#test_}" "${feature_description}" \
            "${command_line[@]}"
    fi
done
