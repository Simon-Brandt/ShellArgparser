#!/bin/bash

# Author: Simon Brandt
# E-Mail: simon.brandt@stud.uni-greifswald.de
# Last Modification: 2024-11-07

# TODO: Correct auto-generated help message with erroneous line breaks.
# TODO: Enable parsing of combined short option flags, i.e.
# script.sh -ab instead of script.sh -a -b.

# Usage: Source this script with "source argparser.sh" inside the script
# whose arguments need to be parsed.  If ${ARGPARSER_AUTO_READ_ARGS} is
# set to true (which per default is), the arguments will be parsed
# upon sourcing, else, the respective functions need to be called.  If
# ${ARGPARSER_AUTO_SET_ARGS} is set to true (which per default is), the
# arguments will be set to variables upon sourcing, else, the
# associative array ${args} needs to be accessed.

# Purpose: Parse a script's arguments, giving proper error messages for
# wrongly set arguments, assigning the values to the respective
# variables, as well as creating and printing a help message.

#----------------------------------------------------------------------#

# Example usage (uncomment for testing):
# # 1.    Source the argparser without reading the arguments from a file.
# #       As the arguments have multiple short and long options, override
# #       the default column widths for the help message.
# export ARGPARSER_ARG_DEF_FILE=""
# export ARGPARSER_MAX_COL_WIDTH_1=9
# export ARGPARSER_MAX_COL_WIDTH_2=33
# export ARGPARSER_MAX_COL_WIDTH_3=35
#
# # 2.    Define the arguments.
# args=(
#     var_1
#     var_2
#     var_3
#     var_4
#     var_5
#     var_6
# )
#
# declare -A args_definition
# args_definition=(
#     [var_1]="a,A:var_1,var_A:-:-:1:Arguments:one value without default or choice"
#     [var_2]="b,B:var_2,var_B:-:-:+:Arguments:at least one value without default or choice"
#     [var_3]="c,C:var_3,var_C:-:A,B:+:Arguments:at least one value with choice"
#     [var_4]="d,D:-:A:A,B,C:1:Options:one value with default and choice"
#     [var_5]="-:var_5,var_E:E:-:1:Options:one value with default"
#     [var_6]="f,F:var_6,var_F:false:-:0:Options:no value (flag) with default"
# )
# source argparser.sh
#
# # 3.    The arguments can now be accessed as keys and values of the
# #       associative array "args".  Further, they are set as variables
# #       to the environment.  If positional arguments were given, they
# #       are set to $@.
# for arg in "${!args[@]}"; do
#     printf "The variable \"%s\" equals \"%s\".\n" "${arg}" "${args[${arg}]}"
# done | sort
#
# if [[ -n "$1" ]]; then
#     printf "%s\n" "$@"
# fi

#----------------------------------------------------------------------#

# As you can see, you need to source the argparser, possibly after
# adjusting some of the argparser environment variables (here to prevent
# the auto-reading from the non-existent arguments definition file and
# to set the maximum column widths for the help message), and then
# define the arguments.  Even though you may choose another way, as long
# as the input to argparser_main keeps the same structure, this is the
# recommended way.  The argument-defining associative array consists of
# a key (which is nothing more than a unique identifier for the
# argparser functions) and a value.  The latter consists of seven
# columns, each separated by a colon (":") from each other.  The first
# column defines the short options (one hyphen), the second the long
# options (two hyphens), the third the default value, the fourth the
# choice values for options with a limited set of values to choose from,
# the fifth the number of required values (either numerical from 0 to
# infinity or "+", meaning to accept as many values as given, at least
# one), the sixth the argument group for grouping of arguments in the
# help text, and the seventh the help text for the --help flag.
# Arguments can have multiple short and/or long names, a default value
# and/or an arbitrary number of choice values.
# The argparser will aggregate all values given after a word starting
# with a hyphen to this argument.  If the number doesn't match the
# number of required values, an error is thrown instead of cutting the
# values.  If an argument gets a wrong number of values, but has a
# default value, only a warning is thrown and the default value is
# taken.
# Even after errors occurred, the parsing continues and aggregates the
# error messages until the end, when all are printed, to simplify the
# correction of multiple mistakes.
# No matter how many arguments are given (even with the same name), the
# argparser interprets the arguments "-u" and "--usage" as call for a
# usage message and "-h" and "--help" as call for a help message.  These
# arguments are always added to the script's arguments.
# Further, all values given after "--" are interpreted as values to
# positional arguments and, if ${ARGPARSER_AUTO_SET_ARGS} is set to
# true, are assigned to $@.
# As many arguments may be given as desired (i.e., the same argument can
# be called multiple times), with the values given afterwards being all
# assigned to the respective argument.
# The argparser will build the help and usage messages from the
# arguments, indicating the short and long names, the default and choice
# values, as well as the argument group, and print the help text from
# the arguments' definitions.

#----------------------------------------------------------------------#

# Set the argparser environment variables, as long as they aren't
# already set by the calling script (to prevent overriding them).  If a
# variable can have a zero-length string ("") as value, an explicit "if"
# statement is used instead of parameter expansion as these don't make
# a difference between unset variables and those set to NULL or the
# empty string.
ARGPARSER_ARG_ARRAY_NAME="${ARGPARSER_ARG_ARRAY_NAME:-"args"}"
if [[ ! -v ARGPARSER_ARG_DEF_FILE ]]; then
    ARGPARSER_ARG_DEF_FILE="arguments.lst"
fi
ARGPARSER_ARG_DELIMITER_1="${ARGPARSER_ARG_DELIMITER_1:-"|"}"
ARGPARSER_ARG_DELIMITER_2="${ARGPARSER_ARG_DELIMITER_2:-":"}"
ARGPARSER_ARG_DELIMITER_3="${ARGPARSER_ARG_DELIMITER_3:-","}"
ARGPARSER_ARG_GROUP_DELIMITER="${ARGPARSER_ARG_GROUP_DELIMITER:-"#"}"
ARGPARSER_AUTO_READ_ARGS="${ARGPARSER_AUTO_READ_ARGS:-true}"
ARGPARSER_AUTO_SET_ARGS="${ARGPARSER_AUTO_SET_ARGS:-true}"
ARGPARSER_AUTO_SET_ARRAYS="${ARGPARSER_AUTO_SET_ARRAYS:-true}"
ARGPARSER_AUTO_UNSET_ARGS="${ARGPARSER_AUTO_UNSET_ARGS:-true}"
ARGPARSER_MAX_COL_WIDTH_1="${ARGPARSER_MAX_COL_WIDTH_1:-5}"
ARGPARSER_MAX_COL_WIDTH_2="${ARGPARSER_MAX_COL_WIDTH_2:-33}"
ARGPARSER_MAX_COL_WIDTH_3="${ARGPARSER_MAX_COL_WIDTH_3:-39}"
ARGPARSER_POSITIONAL_NAME="${ARGPARSER_POSITIONAL_NAME:-"Positional"}"

# Define the argparser functions.
function argparser_in_array() {
    # Check if an element occurs in an array.
    #
    # Arguments:
    # - $1: the element to search for
    # - $@: the array to search through
    #
    # Return values:
    # - 0, if the element exists in the array
    # - 1, else

    # Define the local variables.
    local array
    local element
    local query

    # Read the query element and the array to search through.
    query="$1"
    shift
    array=("$@")

    # Iterate through the array and compare each element to the query.
    # Return "0" on success, else "1".
    for element in "${array[@]}"; do
        if [[ "${element}" == "${query}" ]]; then
            printf "0"
            return
        fi
    done

    printf "1"
}

function argparser_parse_args() {
    # Parse the script's given arguments.
    #
    # Arguments:
    # - $1: the argument to parse
    # - $2: the associative array's keys for the argument definition
    # - $3: the associative array's values for the argument definition
    #
    # Return values:
    # - the parsed argument as message or an error message, starting
    #   with "Help", "Usage", "Positional", "Error: ", "Argument: " or
    #   "Value: ", possibly concatenated with
    #   ${ARGPARSER_ARG_DELIMITER_1} characters.

    # Define the local variables.
    local arg
    local arg_definition
    local args
    local args_keys
    local args_values
    local given_arg
    local i
    local long_option
    local long_options
    local short_option
    local short_options
    local value
    local values

    # Read the arguments.
    given_arg="$1"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_keys <<< "$2"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_values <<< "$3"

    declare -A args
    for i in "${!args_keys[@]}"; do
        args["${args_keys[${i}]}"]="${args_values[${i}]}"
    done

    # If the argument is the positional arguments delimiter "--" or for
    # help or usage, return the respective message.
    if [[ "${given_arg}" == "--" ]]; then
        printf "Positional"
        return
    elif [[ "${given_arg}" == "--="* ]]; then
        printf "Error: The delimiter \"--\" takes no value."
        return
    elif [[ "${given_arg}" == "-h" || "${given_arg}" == "--help" ]]; then
        printf "Help"
        return
    elif [[ "${given_arg}" == "-h="* || "${given_arg}" == "--help="* ]]; then
        printf "Error: The argument --help takes no value."
        return
    elif [[ "${given_arg}" == "-u" || "${given_arg}" == "--usage" ]]; then
        printf "Usage"
        return
    elif [[ "${given_arg}" == "-u="* || "${given_arg}" == "--usage="* ]]; then
        printf "Error: The argument --usage takes no value."
        return
    fi

    # If the argument doesn't start with a hyphen ("-"), it is
    # considered a value to a previous argument.  Split the value on
    # ${ARGPARSER_ARG_DELIMITER_3} characters and return the respective
    # message for each value.
    if [[ "${given_arg}" != -* ]]; then
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a values <<< "${given_arg}"
        for value in "${values[@]}"; do
            printf "Value: %s%s" "${value}" "${ARGPARSER_ARG_DELIMITER_1}"
        done
        return
    fi

    # Read all defined arguments and check whether the given argument is
    # part of them.  If so, return the argument's name and possibly all
    # values following the "=" character.
    for arg in "${!args[@]}"; do
        # Read the argument's definition.
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
            <<< "${args[${arg}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a short_options \
            <<< "${arg_definition[0]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a long_options \
            <<< "${arg_definition[1]}"

        # Check the short options.
        for short_option in "${short_options[@]}"; do
            if [[ "${given_arg}" == "-${short_option}" ]]; then
                # Return the argument.
                printf "Argument: %s" "${arg}"
                return
            elif [[ "${given_arg}" == "-${short_option}="* ]]; then
                # Return the argument and all values split on
                # ${ARGPARSER_ARG_DELIMITER_3} characters.
                printf "Argument: %s%s" "${arg}" \
                    "${ARGPARSER_ARG_DELIMITER_1}"

                IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a values <<< "${1#*=}"
                for value in "${values[@]}"; do
                    printf "Value: %s%s" "${value}" \
                        "${ARGPARSER_ARG_DELIMITER_1}"
                done
                return
            fi
        done

        # Check the long options.
        for long_option in "${long_options[@]}"; do
            if [[ "${given_arg}" == "--${long_option}" ]]; then
                # Return the argument.
                printf "Argument: %s" "${arg}"
                return
            elif [[ "${given_arg}" == "--${long_option}="* ]]; then
                # Return the argument and all values split on
                # ${ARGPARSER_ARG_DELIMITER_3} characters.
                printf "Argument: %s%s" "${arg}" \
                    "${ARGPARSER_ARG_DELIMITER_1}"

                IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a values <<< "${1#*=}"
                for value in "${values[@]}"; do
                    printf "Value: %s%s" "${value}" \
                        "${ARGPARSER_ARG_DELIMITER_1}"
                done
                return
            fi
        done
    done

    # If the argument hasn't been found in the definition, return an
    # error message.
    printf "Error: The argument %s is unknown." "$1"
}

function argparser_check_arg_value() {
    # Check if a script's argument accords to its definition.
    #
    # Arguments:
    # - $1: the associative array's values for the argument definition
    # - $2: the argument's values
    #
    # Return values:
    # - the parsed argument as message or an error message, starting
    #   with "Error: ", "Warning: " or "Value: ", possibly concatenated
    #   with ${ARGPARSER_ARG_DELIMITER_1} characters.

    # Define the local variables.
    local arg_definition
    local arg_number
    local choice_values
    local default_value
    local default_values
    local long_options
    local option_names
    local value
    local values

    # Read the arguments.
    IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition <<< "$1"
    IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a values <<< "$2"
    IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a long_options \
        <<< "${arg_definition[1]}"
    IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a default_values \
        <<< "${arg_definition[2]}"
    IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a choice_values \
        <<< "${arg_definition[3]}"
    arg_number="${arg_definition[4]}"

    option_names="$(printf -- "--%s, " "${long_options[@]}" | sed "s/, $//" )"

    # Check the values.  If an argument hadn't been given, its value was
    # set to "-".
    if [[ "${values[0]}" == "-" ]]; then
        # If the argument doesn't have a default value, it must have
        # been given, but is not.  Hence, return an error message.
        # Else, read the default values.  This is required for optional
        # arguments.
        if [[ "${default_values[0]}" == "-" ]]; then
            printf "Error: The argument "
            printf "%s " "${option_names}"
            printf "is mandatory, but not given.\n"
            return
        else
            read -a values <<< "${default_values[@]}"
        fi
    else
        if [[ "${arg_number}" != "+" && "${#values[@]}" != "${arg_number}" ]] \
            || [[ "${arg_number}" == "+" && "${#values[@]}" == 0 ]]
        then
            # If the number of values doesn't equal the number of
            # required values, check if some default values are given.
            # If not, return an error message indicating the number of
            # required and given arguments.  Else, print a similar
            # warning message but set the values to the default values
            # and continue.
            if [[ "${default_values[0]}" == "-" ]]; then
                if [[ "${arg_number}" == 1 ]]; then
                    printf "Error: The argument "
                    printf "%s " "${option_names}"
                    printf "requires 1 value, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.\n"
                elif [[ "${arg_number}" == "+" ]]; then
                    printf "Error: The argument "
                    printf "%s " "${option_names}"
                    printf "requires at least 1 value, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.\n"
                else
                    printf "Error: The argument "
                    printf "%s " "${option_names}"
                    printf "requires "
                    printf "%s " "${arg_number}"
                    printf "values, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.\n"
                fi
                return
            else
                if [[ "${arg_number}" == 1 ]]; then
                    printf "Warning: The argument "
                    printf "%s " "${option_names}"
                    printf "requires 1 value, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.  For convenience, the default "
                    printf "(%s) " "${default_values[@]}"
                    printf "is used."
                    printf "%s" "${ARGPARSER_ARG_DELIMITER_1}"
                elif [[ "${arg_number}" == "+" ]]; then
                    printf "Warning: The argument "
                    printf "%s " "${option_names}"
                    printf "requires at least 1 value, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.  For convenience, the default "
                    printf "(%s) " "${default_values[@]}"
                    printf "is used."
                    printf "%s" "${ARGPARSER_ARG_DELIMITER_1}"
                else
                    printf "Warning: The argument "
                    printf "%s " "${option_names}"
                    printf "requires "
                    printf "%s " "${arg_number}"
                    printf "values, but has "
                    printf "%s " "${#values[@]}"
                    printf "given.  For convenience, the default "
                    printf "(%s) " "${default_values[@]}"
                    printf "is used."
                    printf "%s" "${ARGPARSER_ARG_DELIMITER_1}"
                fi
                read -a values <<< "${default_values[@]}"
            fi
        elif [[ "${arg_number}" == 0 && "${values[0]}" == "" ]]; then
            # If no value is required nor given, the argument is a flag.
            # As it is set (present), set the value to true.
            values=true
        fi
    fi

    # Check if the default value for flags is either true or false.
    # This should always be true for production scripts, but maybe not
    # while testing.
    if [[ "${arg_number}" == "0" && "${default_values[0]}" != true \
        && "${default_values[0]}" != false ]]
    then
        printf "Error: The argument "
        printf "%s " "${option_names}"
        printf "must be true or false, but is "
        printf "{%s} " "${default_values[@]}"
        printf "per default.\n"
        return
    fi

    # Check if the number of default values equals the number of
    # required values.  This should also always be true for production
    # scripts.  If there are default values and their number doesn't
    # match, return an error message indicating the number of required
    # and default arguments.  Ignore flags as long as they have the
    # only default value of true or false, but a number of required
    # values of 0.
    if [[ "${arg_number}" != "+" && "${default_values[0]}" != "-" \
        && "${#default_values[@]}" != "${arg_number}" ]] \
        && [[ "${arg_number}" != "0" && "${#default_values[@]}" != 1 ]]
    then
        if [[ "${arg_number}" == 1 ]]; then
            printf "Error: The argument "
            printf "%s " "${option_names}"
            printf "requires 1 value, but has "
            printf "%s " "${#default_values[@]}"
            printf "given per default.\n"
        else
            printf "Error: The argument "
            printf "%s " "${option_names}"
            printf "requires "
            printf "%s " "${arg_number}"
            printf "values, but has "
            printf "%s " "${#default_values[@]}"
            printf "given per default.\n"
        fi
        return
    fi

    # Check if the given and default values accord to the choice values,
    # i.e., if each given or default value lies within the array of
    # choice values.  For default values, this should always be true for
    # production scripts.  Else, return an error message.
    if [[ "${choice_values[0]}" != "-" ]]; then
        # Check that flags have no choice values.
        if [[ "${arg_number}" == "0" ]]; then
            choice_values="$(printf "%s${ARGPARSER_ARG_DELIMITER_3}" \
                "${choice_values[@]}" \
                | sed "s/${ARGPARSER_ARG_DELIMITER_3}$//")"
            printf "Error: The argument "
            printf "%s " "${option_names}"
            printf "accepts no choice values, but uses "
            printf "{%s} " "${choice_values}"
            printf "per default.\n"
            return
        fi

        # Check the default values.
        for default_value in "${default_values[@]}"; do
            if [[ "${default_value}" != "-" \
                && "$(argparser_in_array "${default_value}" \
                "${choice_values[@]}")" == 1 ]]
            then
                choice_values="$(printf "%s${ARGPARSER_ARG_DELIMITER_3}" \
                    "${choice_values[@]}" \
                    | sed "s/${ARGPARSER_ARG_DELIMITER_3}$//")"
                printf "Error: The argument "
                printf "%s " "${option_names}"
                printf "accepts only the choice values "
                printf "{%s}, " "${choice_values}"
                printf "but has "
                printf "{%s} " "${default_values[@]}"
                printf "given per default.\n"
                return
            fi
        done

        # Check the given values.
        for value in "${values[@]}"; do
            if [[ "$(argparser_in_array "${value}" "${choice_values[@]}")" == \
                1 ]]
            then
                choice_values="$(printf "%s${ARGPARSER_ARG_DELIMITER_3}" \
                    "${choice_values[@]}" \
                    | sed "s/${ARGPARSER_ARG_DELIMITER_3}$//")"
                printf "Error: The argument "
                printf "%s " "${option_names}"
                printf "must be in "
                printf "{%s}.\n" "${choice_values}"
                return
            fi
        done
    fi

    # Return the checked values as
    # ${ARGPARSER_ARG_DELIMITER_3}-separated string.
    value="$(printf "%s${ARGPARSER_ARG_DELIMITER_3}" "${values[@]}" \
        | sed "s/${ARGPARSER_ARG_DELIMITER_3}$//")"
    printf "Value: %s\n" "${value}"
}

function argparser_print_help_message() {
    # Print a help or usage message from a file without commented lines
    # (i.e., lines starting with "#") and their trailing blank lines
    # inside the message. "@Arguments" lines will be replaced by the
    # auto-generated help or usage message.
    #
    # Arguments:
    # - $1: the help type ("help" or "usage")
    # - $2: the script's name
    # - $3: the associative array's keys for the argument definition
    # - $4: the associative array's values for the argument definition

    # Define the local variables.
    local args_keys
    local args_values
    local at_directive
    local help_type
    local line
    local line_type
    local script_name

    # Read the arguments.
    help_type="$1"
    script_name="$2"
    args_keys="$3"
    args_values="$4"
    line_type="comment"

    while IFS="" read line; do
        # Set the line_type to "arguments" if the line contains the
        # "@Arguments" directive, to "comment" if the line is commented
        # and to "text" if it is not empty (but not commented).  Thus,
        # empty lines following comments still have line_type set to
        # "comment".
        # TODO: Introduce an environment variable to override the
        # deletion of trailing blank lines (and perhaps even commented
        # lines?).
        # TODO: Check if the following statement still holds when all
        # variables are local.
        # Both functions to create the help or usage message change
        # args_keys and args_values to arrays, affecting the current
        # scope.  To still be able to pass all arguments as single
        # string to the respective function, concatenate them before.
        # This is required for multiple "@Arguments" directives in the
        # help file.
        if [[ "${line}" == @* ]]; then
            line_type="at_directive"
            at_directive="${line:1}"
            args_keys="$(printf "%s${ARGPARSER_ARG_DELIMITER_1}" \
                "${!args_definition[@]}" \
                | sed "s/${ARGPARSER_ARG_DELIMITER_1}$//")"
            args_values="$(printf "%s${ARGPARSER_ARG_DELIMITER_1}" \
                "${args_definition[@]}" \
                | sed "s/${ARGPARSER_ARG_DELIMITER_1}$//")"

            if [[ "${help_type}" == "help" ]]; then
                argparser_create_help_message "${script_name}" \
                    "${at_directive}" "${args_keys}" "${args_values}"
            else
                argparser_create_usage_message "${script_name}" \
                    "${args_keys}" "${args_values}"
            fi
        elif [[ "${line}" == \#* ]]; then
            line_type="comment"
        elif [[ -n "${line}" ]]; then
            line_type="text"
        fi

        # If the line_type has been set to "text", print the current
        # line.  If it is set to "arguments", reset it to "text" to
        # (possibly) print the next line, and only not the current
        # "@Arguments" line.
        if [[ "${line_type}" == "text" ]]; then
            printf "%s\n" "${line}"
        elif [[ "${line_type}" == "at_directive" ]]; then
            line_type="text"
        fi
    done < "${script_name%.sh}.${help_type}"
}

function argparser_create_help_message() {
    # Create a help message for the script's arguments.
    #
    # Arguments:
    # - $1: the script's name
    # - $2: the "@" directive ("All", "Header", "Help", or any argument
    #       group)
    # - $3: the associative array's keys for the argument definition
    # - $4: the associative array's values for the argument definition

    # Define the local variables.
    local arg
    local arg_definition
    local arg_group
    local arg_group
    local arg_groups
    local arg_groups
    local arg_number
    local args
    local args_keys
    local args_values
    local at_directive
    local choice_values
    local col_1
    local col_2
    local col_3
    local col_width
    local col_width_1
    local col_width_2
    local col_width_3
    local default_values
    local help_text
    local i
    local index
    local joined_words
    local line_count
    local line_count_1
    local line_count_2
    local line_count_3
    local line_counts
    local line_index
    local lines_col_1
    local lines_col_2
    local lines_col_3
    local long_option
    local long_options
    local max_line_count
    local new_col_1
    local new_col_1_value
    local new_col_2
    local new_col_2_value
    local new_col_3
    local new_col_3_value
    local newline_count_1
    local newline_count_2
    local newline_count_3
    local newlines_1
    local newlines_2
    local newlines_3
    local script_name
    local short_options
    local sorted_col_1
    local sorted_col_2
    local sorted_col_3
    local whitespace_1
    local whitespace_2
    local whitespace_len_1
    local whitespace_len_2
    local word
    local words

    # Read the arguments.
    script_name="$1"
    at_directive="$2"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_keys <<< "$3"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_values <<< "$4"

    declare -A args
    for i in "${!args_keys[@]}"; do
        args["${args_keys[${i}]}"]="${args_values[${i}]}"
    done

    # Read the arguments' groups to sort the arguments by group in the
    # help message.  To this end, sort the groups alphabetically and
    # compare each argument's group later upon iterating over them.
    arg_groups=( )
    for arg in "${!args[@]}"; do
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
            <<< "${args[${arg}]}"
        arg_group="${arg_definition[5]}"
        if [[ "$(argparser_in_array "${arg_group}" "${arg_groups[@]}")" == 1 ]]
        then
            arg_groups+=("${arg_group}")
        fi
    done

    # Sort the argument groups.
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a arg_groups \
        <<< "$(printf "%s\n" "${arg_groups[@]}" \
        | sort \
        | tr "\n" "${ARGPARSER_ARG_DELIMITER_1}")"

    # The help message is structured in three columns: short options,
    # long options and the help text.  Populate these columns with the
    # entries for each argument.
    col_1=( )
    col_2=( )
    col_3=( )
    for arg_group in "${arg_groups[@]}"; do
        # Only add the argument group that was requested by the "@"
        # directive.  Skip the "@Header" and "@Help" directive, but not
        # the "@All" directive.
        if [[ "${at_directive}" == "Header" || "${at_directive}" == "Help" \
            || ("${at_directive}" != "All" && "${arg_group}" != "${at_directive}") ]]
        then
            continue
        fi

        new_col_1=( )
        new_col_2=( )
        new_col_3=( )

        for arg in "${!args[@]}"; do
            # Read the argument's group to check whether it belongs to
            # the current group.
            IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
                <<< "${args[${arg}]}"
            if [[ "${arg_definition[5]}" != "${arg_group}" ]]; then
                continue
            fi

            # Read the argument's remaining definition.
            IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a short_options \
                <<< "${arg_definition[0]}"
            IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a long_options \
                <<< "${arg_definition[1]}"
            IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a default_values \
                <<< "${arg_definition[2]}"
            choice_values="${arg_definition[3]}"
            arg_number="${arg_definition[4]}"
            help_text="${arg_definition[6]}"

            # Define the columns' next line, for the current argument.
            # The argument may have some short and long options, a
            # default value and some choice values or an argument number
            # of 0 (i.e., it is a flag), with the existence of each
            # changing the look of the respective column, mostly the
            # second one.  If either no short or no long option is
            # given, use a space character instead.  This makes it
            # possible to sort the options later on by name.  Further,
            # the space character's length of 1 is the minimum length of
            # any option (especially due to the leading hyphen), so the
            # adjustment of whitespace between the columns doesn't get
            # affected.
            # Set the first column's value.
            if [[ "${short_options[0]}" == "-" ]]; then  # No short option.
                new_col_1+=(" ")
            elif [[ "${arg_number}" == 0 ]]; then  # Flag.
                new_col_1_value="["
                if [[ "${long_options[0]}" == "-" ]]; then  # No long option.
                    new_col_1_value+="$(printf -- "-%s, " \
                        "${short_options[@]}" | sed "s/, $//")"
                else  # Long option.
                    new_col_1_value+="$(printf -- "-%s, " \
                        "${short_options[@]}" | sed "s/ $//")"
                fi
                new_col_1_value+="]"
                new_col_1+=("${new_col_1_value}")
            else  # Non-flag.
                if [[ "${long_options[0]}" == "-" ]]; then  # No long option.
                    new_col_1+=("$(printf -- "-%s, " "${short_options[@]}" \
                        | sed "s/, $//")")
                else  # Long option.
                    new_col_1+=("$(printf -- "-%s, " "${short_options[@]}")")
                fi
            fi

            # Set the second column's value.
            if [[ "${long_options[0]}" == "-" ]]; then  # No long option.
                new_col_2+=(" ")
            elif [[ "${arg_number}" == 0 ]]; then  # Flag.
                new_col_2_value="["
                new_col_2_value+="$(printf -- "--%s, " "${long_options[@]}" \
                    | sed "s/, $//")"
                new_col_2_value+="]"
                new_col_2+=("${new_col_2_value}")
            elif [[ "${choice_values[0]}" != "-" \
                && "${default_values[0]}" != "-" ]]
            then  # Choice and default.
                new_col_2_value=""
                for long_option in "${long_options[@]}"; do
                    new_col_2_value+="$(printf -- "--%s[={%s}], " \
                        "${long_option}" "${choice_values}")"
                done
                new_col_2_value="$(sed "s/, $//" <<< "${new_col_2_value}")"
                new_col_2+=("${new_col_2_value}")
            elif [[ "${choice_values[0]}" != "-" ]]; then  # Choice only.
                new_col_2_value=""
                for long_option in "${long_options[@]}"; do
                    new_col_2_value+="$(printf -- "--%s={%s}, " \
                        "${long_option}" "${choice_values}")"
                done
                new_col_2_value="$(sed "s/, $//" <<< "${new_col_2_value}")"
                new_col_2+=("${new_col_2_value}")
            elif [[ "${default_values[0]}" != "-" ]]; then  # Default only.
                new_col_2_value=""
                for long_option in "${long_options[@]}"; do
                    new_col_2_value+="$(printf -- "--%s[=%s], " \
                        "${long_option}" "${long_option^^}")"
                done
                new_col_2_value="$(sed "s/, $//" <<< "${new_col_2_value}")"
                new_col_2+=("${new_col_2_value}")
            else  # No choice nor default.
                new_col_2_value=""
                for long_option in "${long_options[@]}"; do
                    new_col_2_value+="$(printf -- "--%s=%s, " \
                        "${long_option}" "${long_option^^}")"
                done
                new_col_2_value="$(sed "s/, $//" <<< "${new_col_2_value}")"
                new_col_2+=("${new_col_2_value}")
            fi

            # Set the third column's value.
            if [[ "${default_values[0]}" != "-" ]]; then  # Default.
                new_col_3+=("${help_text} (default: ${default_values[0]})")
            else  # No default.
                new_col_3+=("${help_text}")
            fi
        done

        # Sort the arguments by the first long option.  To this end,
        # two associative arrays are defined that use the second
        # column's values as keys and the first or third column's values
        # as values.  Then, the second column's indexed array gets
        # sorted by sort and the indexed arrays for the first and third
        # columns are re-populated using the values from the associative
        # array, such that the sorted second column defines the order of
        # the yet unsorted other columns.  As a consequence, all columns
        # are sorted as if they would have been sorted together (which
        # appears not be feasible).
        declare -A sorted_col_1
        declare -A sorted_col_3
        for i in "${!new_col_2[@]}"; do
            sorted_col_1["${new_col_2[${i}]}"]="${new_col_1[${i}]}"
            sorted_col_3["${new_col_2[${i}]}"]="${new_col_3[${i}]}"
        done

        mapfile -t sorted_col_2 \
            <<< "$(printf "%s\n" "${new_col_2[@]}" | sort)"

        for i in "${!sorted_col_2[@]}"; do
            col_1+=("${sorted_col_1[${sorted_col_2[${i}]}]}")
            col_2+=("${sorted_col_2[${i}]}")
            col_3+=("${sorted_col_3[${sorted_col_2[${i}]}]}")
        done

        # To mark the end of an argument group later upon printing, add
        # an ARGPARSER_ARG_GROUP_DELIMITER character, that won't get
        # printed.
        col_1+=("${ARGPARSER_ARG_GROUP_DELIMITER}")
        col_2+=("${ARGPARSER_ARG_GROUP_DELIMITER}")
        col_3+=("${ARGPARSER_ARG_GROUP_DELIMITER}")
    done

    # Add the help and usage flags that always exist if "@All" or
    # "@Help" was requested.
    if [[ "${at_directive}" == "All" || "${at_directive}" == "Help" ]]; then
        col_1+=("-h,")
        col_2+=("--help")
        col_3+=("display this help and exit")
        col_1+=("-u,")
        col_2+=("--usage")
        col_3+=("display the usage and exit")
    fi

    # Limit the width of each column of the help message to
    # ${ARGPARSER_MAX_COL_WIDTH_*} by inserting line breaks.  For being
    # better able of parsing the line breaks later on,
    # ${ARGPARSER_ARG_DELIMITER_1} characters are used instead.
    col_width_1=0
    for i in "${!col_1[@]}"; do
        # Split the element of column 1 word by word (on whitespace),
        # such that line breaks aren't inserted into entire words.
        read -a words <<< "${col_1[${i}]}"
        joined_words=""
        col_width=0
        for word in "${words[@]}"; do
            if (( "${#word}" > ARGPARSER_MAX_COL_WIDTH_1 \
                && "${#joined_words}" == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + "${#word}" + 1 > ARGPARSER_MAX_COL_WIDTH_1 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break, print the word and introduce
                # yet another line break  Then, reset the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${#word}"
            elif (( "${#joined_words}" == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += "${#word}" ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += "${#word}" + 1 ))
            fi

            # If the current lines are wider than the previous ones, set
            # the col_width_1 respectively.  Later, this value is used
            # to determine the amount of whitespace between the columns'
            # elements.
            if (( col_width > col_width_1 )); then
                col_width_1="${col_width}"
            fi
        done

        # Set the column's element to the joined line.
        col_1["${i}"]="${joined_words}"
    done

    col_width_2=0
    for i in "${!col_2[@]}"; do
        # Split the element of column 2 word by word (on whitespace),
        # such that line breaks aren't inserted into entire words.
        read -a words <<< "${col_2[${i}]}"
        joined_words=""
        col_width=0
        for word in "${words[@]}"; do
            if (( "${#word}" > ARGPARSER_MAX_COL_WIDTH_2 \
                && "${#joined_words}" == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + "${#word}" + 1 > ARGPARSER_MAX_COL_WIDTH_2 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break, print the word and introduce
                # yet another line break  Then, reset the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${#word}"
            elif (( "${#joined_words}" == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += "${#word}" ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += "${#word}" + 1 ))
            fi

            # If the current lines are wider than the previous ones, set
            # the col_width_2 respectively.  Later, this value is used
            # to determine the amount of whitespace between the columns'
            # elements.
            if (( col_width > col_width_2 )); then
                col_width_2="${col_width}"
            fi
        done

        # Set the column's element to the joined line.
        col_2["${i}"]="${joined_words}"
    done

    col_width_3=0
    for i in "${!col_3[@]}"; do
        # Split the element of column 3 word by word (on whitespace),
        # such that line breaks aren't inserted into entire words.
        read -a words <<< "${col_3[${i}]}"
        joined_words=""
        col_width=0
        for word in "${words[@]}"; do
            if (( "${#word}" > ARGPARSER_MAX_COL_WIDTH_3 \
                && "${#joined_words}" == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + "${#word}" + 1 > ARGPARSER_MAX_COL_WIDTH_3 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break, print the word and introduce
                # yet another line break  Then, reset the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${#word}"
            elif (( "${#joined_words}" == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += "${#word}" ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += "${#word}" + 1 ))
            fi

            # If the current lines are wider than the previous ones, set
            # the col_width_3 respectively.  Later, this value is used
            # to determine the amount of whitespace between the columns'
            # elements.
            if (( col_width > col_width_3 )); then
                col_width_3="${col_width}"
            fi
        done

        # Set the column's element to the joined line.
        col_3["${i}"]="${joined_words}"
    done

    # Adjust the number of line breaks between each column's rows, such
    # that each element shares the same number of rows.
    for i in "${!col_1[@]}"; do
        # Count the number of rows for each element.
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_1 \
            <<< "${col_1[${i}]}"
        line_count_1="${#lines_col_1[@]}"

        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_2 \
            <<< "${col_2[${i}]}"
        line_count_2="${#lines_col_2[@]}"

        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_3 \
            <<< "${col_3[${i}]}"
        line_count_3="${#lines_col_3[@]}"

        # Get the largest line count.
        line_counts=(
            "${line_count_1}"
            "${line_count_2}"
            "${line_count_3}"
        )
        mapfile -t line_counts \
            <<< "$(printf "%s\n" "${line_counts[@]}" | sort --reverse)"
        max_line_count="${line_counts[0]}"

        # Set the number of required line breaks to align each line.  If
        # the line count is greater than 0, 1 is added to the maximum
        # line count to add a definitive line break (given as
        # ${ARGPARSER_ARG_DELIMITER_1}).  The same holds true for a line
        # count of 0, where normally 1 would have to be subtracted.
        # This is due to how Bash reads arrays, as the line break would
        # yield a line too many.
        if (( line_count_1 == 0 )); then
            (( newline_count_1 = max_line_count ))
        else
            (( newline_count_1 = max_line_count - line_count_1 + 1 ))
        fi

        if (( line_count_2 == 0 )); then
            (( newline_count_2 = max_line_count ))
        else
            (( newline_count_2 = max_line_count - line_count_2 + 1 ))
        fi

        if (( line_count_3 == 0 )); then
            (( newline_count_3 = max_line_count ))
        else
            (( newline_count_3 = max_line_count - line_count_3 + 1 ))
        fi

        # Add as many line breaks as computed to each element.  To
        # preserve the correct number of line breaks upon reading the
        # element into another array, later, one break is inserted for
        # sure (by the increment in the above compution).
        newlines_1="$(printf "%*s" "${newline_count_1}" \
            | tr " " "${ARGPARSER_ARG_DELIMITER_1}")"
        col_1["${i}"]+="${newlines_1}"

        newlines_2="$(printf "%*s" "${newline_count_2}" \
            | tr " " "${ARGPARSER_ARG_DELIMITER_1}")"
        col_2["${i}"]+="${newlines_2}"

        newlines_3="$(printf "%*s" "${newline_count_3}" \
            | tr " " "${ARGPARSER_ARG_DELIMITER_1}")"
        col_3["${i}"]+="${newlines_3}"
    done

    # Re-read in the columns' lines, such that each line makes up one
    # element of the array.  To this end, split the lines on
    # ${ARGPARSER_ARG_DELIMITER_1} characters.  As the last character
    # protects all former characters, the line count remains preserved.
    new_col_1=( )
    new_col_2=( )
    new_col_3=( )
    for i in "${!col_1[@]}"; do
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_1 \
            <<< "${col_1[${i}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_2 \
            <<< "${col_2[${i}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a lines_col_3 \
            <<< "${col_3[${i}]}"

        line_count="${#lines_col_1[@]}"
        for (( line_index = 0; line_index < line_count; line_index++ )); do
            new_col_1+=("${lines_col_1[${line_index}]}")
            new_col_2+=("${lines_col_2[${line_index}]}")
            new_col_3+=("${lines_col_3[${line_index}]}")
        done
    done

    # Store the lines back in the original columns' variables.  Trim the
    # trailing ${ARGPARSER_ARG_DELIMITER_2} characters.
    col_1=( )
    col_2=( )
    col_3=( )
    for i in "${!new_col_1[@]}"; do
        col_1+=("$(printf "%s" "${new_col_1[${i}]}")")
        col_2+=("$(printf "%s" "${new_col_2[${i}]}")")
        col_3+=("$(printf "%s" "${new_col_3[${i}]}")")
    done

    # For proper alignment of the columns, whitespace must be used as
    # separation between shorter elements.  Compute the width for both
    # the first and the second column.  If a line is wider, set the
    # width to the respective value, as long as the width doesn't exceed
    # the limit set by ${ARGPARSER_MAX_COL_WIDTH_*}.
    if [[ "${at_directive}" != "Header" ]]; then
        col_width_1=0
        col_width_2=0
        for i in "${!col_1[@]}"; do
            if (( "${#col_1[${i}]}" <= ARGPARSER_MAX_COL_WIDTH_1 \
                && "${#col_1[${i}]}" > col_width_1 ))
            then
                col_width_1="${#col_1[${i}]}"
            fi

            if (( "${#col_2[${i}]}" <= ARGPARSER_MAX_COL_WIDTH_2 \
                && "${#col_2[${i}]}" > col_width_2 ))
            then
                col_width_2="${#col_2[${i}]}"
            fi
        done
    fi

    # Compute the length of whitespace between column 1 and 2, as well
    # as between column 2 and 3.  This length equals the column's
    # maximum width minus the current line's element's length plus 1 to
    # have at least one space as separation.  If the column width
    # exceeds the limit set by ${ARGPARSER_MAX_COL_WIDTH_*}, insert a
    # line break instead to make the following column's content begin on
    # the next line.  Then, insert as much whitespace as needed to align
    # the column with the other elements.  For column 1, this equals the
    # column's maximum width plus 1 (the mandatory separation), for
    # column 2, both columns' maximum widths plus 2 (twice the mandatory
    # separation).
    whitespace_1=( )
    whitespace_2=( )
    for i in "${!col_1[@]}"; do
        if (( "${#col_1[${i}]}" <= ARGPARSER_MAX_COL_WIDTH_1 )); then
            (( whitespace_len_1 = col_width_1 - "${#col_1[${i}]}" + 1 ))
            whitespace_1+=("$(printf "%*s" "${whitespace_len_1}")")
        else
            (( whitespace_len_1 = col_width_1 + 1 ))
            whitespace_1+=("$(printf "\n%*s" "${whitespace_len_1}")")
        fi

        if (( "${#col_2[${i}]}" <= ARGPARSER_MAX_COL_WIDTH_2 )); then
            (( whitespace_len_2 = col_width_2 - "${#col_2[${i}]}" + 1 ))
            whitespace_2+=("$(printf "%*s" "${whitespace_len_2}")")
        else
            (( whitespace_len_2 = col_width_1 + col_width_2 + 2 ))
            whitespace_2+=("$(printf "\n%*s" "${whitespace_len_2}")")
        fi
    done

    # If "@All" or "@Header" was requested, print the help message's
    # header, giving the script's name and instructions on how to
    # interpret the arguments.  With "@All", print a trailing blank line
    # to separate the block from the following arguments.
    if [[ "${at_directive}" == "All" ]]; then
        printf "Usage: %s ARGUMENTS\n\n" "${script_name}"
        printf "Mandatory arguments to long options are mandatory for short "
        printf "options too.\n\n"
    elif [[ "${at_directive}" == "Header" ]]; then
        printf "Usage: %s ARGUMENTS\n\n" "${script_name}"
        printf "Mandatory arguments to long options are mandatory for short "
        printf "options too.\n"
    fi

    # For each argument group, print its arguments.
    index=0
    for arg_group in "${arg_groups[@]}"; do
        # Only print the argument group's arguments if it was requested
        # by the "@" directive.
        if [[ "${at_directive}" != "All" \
            && "${arg_group}" != "${at_directive}" ]]
        then
            continue
        fi

        # Print the argument group's name.
        printf "%s:\n" "${arg_group}"

        # For any argument line, print the three columns and their
        # delimiting whitespace.  ${ARGPARSER_ARG_GROUP_DELIMITER}
        # characters denote the end of the current argument group and
        # don't get printed.
        for (( i = index; i < "${#col_1[@]}"; i++ )); do
            if [[ "${col_1[${i}]}" == "${ARGPARSER_ARG_GROUP_DELIMITER}" ]]
            then
                break
            fi

            printf "%s" "${col_1[${i}]}" "${whitespace_1[${i}]}" \
                "${col_2[${i}]}" "${whitespace_2[${i}]}" "${col_3[${i}]}"
            printf "\n"
        done

        # If the "@All" directive is given, print a trailing blank line
        # to separate the argument group blocks from each other.
        if [[ "${at_directive}" == "All" ]]; then
            printf "\n"
        fi

        # Set the start index for the next argument group to the current
        # group's end index plus 1 (with the latter being the
        # ${ARGPARSER_ARG_GROUP_DELIMITER}).
        (( index = i + 1 ))
    done

    # If "@All" or "@Help" was requested, print the help and usage
    # lines, which shall be the last two and hence were not used in the
    # sorting process.
    if [[ "${at_directive}" == "All" || "${at_directive}" == "Help" ]]; then
        printf "%s" "${col_1[-2]}" "${whitespace_1[-2]}" "${col_2[-2]}" \
            "${whitespace_2[-2]}" "${col_3[-2]}"
        printf "\n"

        printf "%s" "${col_1[-1]}" "${whitespace_1[-1]}" "${col_2[-1]}" \
            "${whitespace_2[-1]}" "${col_3[-1]}"
        printf "\n"
    fi
}

function argparser_create_usage_message() {
    # Create a usage message for the script's arguments.
    #
    # Arguments:
    # - $1: the script's name
    # - $2: the associative array's keys for the argument definition
    # - $3: the associative array's values for the argument definition

    # Define the local variables.
    local arg
    local arg_definition
    local arg_number
    local args
    local args_keys
    local args_values
    local choice_values
    local default_values
    local header
    local i
    local long_option_args
    local long_options
    local script_name
    local short_option_args
    local short_options
    local whitespace
    local whitespace_len

    # Read the arguments.
    script_name="$1"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_keys <<< "$2"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a args_values <<< "$3"

    declare -A args
    for i in "${!args_keys[@]}"; do
        args["${args_keys[${i}]}"]="${args_values[${i}]}"
    done

    # Print the usage message's header, giving the script's name and
    # the existence of the --help and --usage arguments.  To keep all
    # arguments aligned, the length of the script name and the leading
    # "Usage: " determines the amount of whitespace printed before them.
    header="$(printf "Usage: %s" "${script_name}")"
    printf "%s [--help] [--usage]\n" "${header}"
    whitespace_len="${#header}"
    (( whitespace_len++ ))
    whitespace="$(printf "%*s" "${whitespace_len}")"

    # Separate arguments with long options from those without to output
    # first the short option-only arguments, and afterwards those with
    # long options (no matter whether they also have short options as
    # these won't get printed).
    short_option_args=( )
    long_option_args=( )
    for arg in "${!args[@]}"; do
        # Read the argument's definition.
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
            <<< "${args[${arg}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a short_options \
            <<< "${arg_definition[0]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a long_options \
            <<< "${arg_definition[1]}"

        # Add the argument to the respective array.
        if [[ "${long_options[0]}" == "-" ]]; then  # No long option.
            short_option_args+=("${arg}")
        else  # Long option.
            long_option_args+=("${arg}")
        fi
    done

    # Print each argument having only short options with the short
    # options and possibly choice values and sort them alphabetically.
    for arg in "${short_option_args[@]}"; do
        # Read the argument's definition.
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
            <<< "${args[${arg}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a short_options \
            <<< "${arg_definition[0]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a default_values \
            <<< "${arg_definition[2]}"
        choice_values="${arg_definition[3]}"
        arg_number="${arg_definition[4]}"

        # Define the line for the current argument.  The argument may
        # have some short options, a default value and some choice
        # values or an argument number of 0 (i.e., it is a flag), with
        # the existence of each changing the look of the line.
        if [[ "${arg_number}" == 0 ]]; then  # Flag.
            short_options="$(printf -- "-%s, " "${short_options[@]}" \
                | sed "s/, $//")"
            printf "%s[%s]\n" "${whitespace}" "${short_options}"
        elif [[ "${choice_values[0]}" != "-" \
            && "${default_values[0]}" != "-" ]]
        then  # Choice and default.
            printf "%s-%s[={%s}]\n" "${whitespace}" "${short_options}" \
                "${choice_values}"
        elif [[ "${choice_values[0]}" != "-" ]]; then  # Choice only.
            printf "%s-%s={%s}\n" "${whitespace}" "${short_options}" \
                "${choice_values}"
        elif [[ "${default_values[0]}" != "-" ]]; then  # Default only.
            printf "%s-%s[=%s]\n" "${whitespace}" "${short_options}" \
                "${short_options^^}"
        else  # No choice nor default.
            printf "%s-%s=%s\n" "${whitespace}" "${short_options}" \
                "${short_options^^}"
        fi
    done | sort

    for arg in "${long_option_args[@]}"; do
        # Read the argument's definition.
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_definition \
            <<< "${args[${arg}]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a long_options \
            <<< "${arg_definition[1]}"
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a default_values \
            <<< "${arg_definition[2]}"
        choice_values="${arg_definition[3]}"
        arg_number="${arg_definition[4]}"

        # Define the line for the current argument.  The argument may
        # have some long options (short options aren't printed), a
        # default value and some choice values or an argument number of
        # 0 (i.e., it is a flag), with the existence of each changing
        # the look of the line.
        if [[ "${arg_number}" == 0 ]]; then  # Flag.
            long_options="$(printf -- "--%s, " "${long_options[@]}" \
                | sed "s/, $//")"
            printf "%s[%s]\n" "${whitespace}" "${long_options}"
        elif [[ "${choice_values[0]}" != "-" \
            && "${default_values[0]}" != "-" ]]
        then  # Choice and default.
            printf "%s--%s[={%s}]\n" "${whitespace}" "${long_options}" \
                "${choice_values}"
        elif [[ "${choice_values[0]}" != "-" ]]; then  # Choice only.
            printf "%s--%s={%s}\n" "${whitespace}" "${long_options}" \
                "${choice_values}"
        elif [[ "${default_values[0]}" != "-" ]]; then  # Default only.
            printf "%s--%s[=%s]\n" "${whitespace}" "${long_options}" \
                "${long_options^^}"
        else  # No choice nor default.
            printf "%s--%s=%s\n" "${whitespace}" "${long_options}" \
                "${long_options^^}"
        fi
    done | sort
}

function argparser_prepare_help_message() {
    # Print a help or usage message.  If a file with such exists, print
    # the file, else, create a message for the script's arguments.  The
    # file must be named like the script, with either ".help" or
    # ".usage" as ending instead of the script's ".sh".
    #
    # Arguments:
    # - $1: the help type ("help" or "usage")
    # - $2: the script's name
    # - $3: the associative array's keys for the argument definition
    # - $4: the associative array's values for the argument definition

    # Define the local variables.
    local args_keys
    local args_values
    local help_type
    local script_name

    # Read the arguments.
    help_type="$1"
    script_name="$2"
    args_keys="$3"
    args_values="$4"

    # Decide which message type to print to STDERR.  This is necessary
    # to keep the wanted output (the parsed arguments) strictly separate
    # from any other messages.
    if [[ -f "${script_name%.sh}.${help_type}" ]]; then
        argparser_print_help_message "${help_type}" "${script_name}" \
            "${args_keys}" "${args_values}"
    elif [[ "${help_type}" == "help" ]]; then
        argparser_create_help_message "${script_name}" "All" "${args_keys}" \
            "${args_values}"
    else
        argparser_create_usage_message "${script_name}" "${args_keys}" \
            "${args_values}"
    fi
}

function argparser_main() {
    # Parse the script's given arguments and check if they accord to
    # their definition.  Give proper error messages for wrongly set
    # arguments and assign the values to the respective variables.
    # Possibly, create and print a help message.
    #
    # Arguments:
    # - $1: the associative array's keys for the argument definition
    # - $2: the associative array's values for the argument definition
    # - $@: the arguments to parse
    #
    # Return values:
    # - the parsed and checked arguments with key and value, separated
    #   by ${ARGPARSER_ARG_DELIMITER_1} characters and concatenated with
    #   ${ARGPARSER_ARG_DELIMITER_1} characters.

    # Define the local variables.
    local arg
    local arg_key
    local arg_value
    local args
    local args_definition
    local args_keys
    local args_values
    local checked_arg
    local error
    local error_message
    local error_messages
    local given_args
    local message
    local parsed_arg

    # Read the arguments.
    args_keys="$1"
    args_values="$2"
    shift 2
    read -a given_args <<< "$@"

    # Set the default argument key to ${ARGPARSER_POSITIONAL_NAME}, such
    # that initially, all arguments given before a keyword argument are
    # recognized as positional.
    arg_key="${ARGPARSER_POSITIONAL_NAME}"
    arg_value=( )

    error=false
    error_messages=( )
    declare -A args

    # Parse the script's given arguments.
    for arg in "${given_args[@]}"; do
        # Parse the argument.
        parsed_arg="$(argparser_parse_args "${arg}" "${args_keys}" \
            "${args_values}")"
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a parsed_arg \
            <<< "${parsed_arg}"

        # Read the returned message and either print the help or usage
        # message, append the message to the previous error messages or
        # set the argument's value.  In case of arguments given multiple
        # times, i.e., the key already exists in ${!args[@]}, add the
        # new values to the previously given by re-reading in the values
        # into ${arg_value}.
        for message in "${parsed_arg[@]}"; do
            case "${message}" in
                Help*)
                    argparser_prepare_help_message "help" "$0" "${args_keys}" \
                        "${args_values}" >&2
                    exit 1
                    ;;
                Usage*)
                    argparser_prepare_help_message "usage" "$0" \
                        "${args_keys}" "${args_values}" >&2
                    exit 1
                    ;;
                Error*)
                    error=true
                    error_messages+=("${message}")
                    ;;
                Warning*)
                    error_messages+=("${message}")
                    ;;
                Positional)
                    arg_key="${ARGPARSER_POSITIONAL_NAME}"

                    if [[ "$(argparser_in_array "${arg_key}" \
                        "${!args[@]}")" == 0 ]]
                    then
                        # Read the previously given values.
                        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a arg_value \
                            <<< "${args[${arg_key}]}"
                    else
                        arg_value=( )
                    fi
                    ;;
                Argument*)
                    arg_key="${message#Argument: }"

                    if [[ "$(argparser_in_array "${arg_key}" \
                        "${!args[@]}")" == 0 ]]
                    then
                        # Read the previously given values.
                        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a arg_value \
                            <<< "${args[${arg_key}]}"
                    else
                        arg_value=( )
                    fi
                    ;;
                Value*)
                    arg_value+=("${message#Value: }")
                    ;;
            esac
        done

        # If the argument had been set before, assign the new value to
        # it (as ${ARGPARSER_ARG_DELIMITER_3}-separated list).
        if [[ -v arg_key ]]; then
            args["${arg_key}"]="$(printf "%s${ARGPARSER_ARG_DELIMITER_3}" \
                "${arg_value[@]}" | sed "s/${ARGPARSER_ARG_DELIMITER_3}$//")"
        fi
    done

    # Check the arguments' values.
    for arg_key in "${!args_definition[@]}"; do
        # Check which defined argument is given to the script.  Omitted
        # arguments are assigned a hypen ("-") as value.  Check the
        # value.
        if [[ "$(argparser_in_array "${arg_key}" "${!args[@]}")" == 0 ]]; then
            checked_arg="$(argparser_check_arg_value \
                "${args_definition[${arg_key}]}" "${args[${arg_key}]}")"
        else
            checked_arg="$(argparser_check_arg_value \
                "${args_definition[${arg_key}]}" "-")"
        fi

        # Read the returned message and either append the message to the
        # previous error messages or set the argument's value.
        arg_value=""
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a checked_arg \
            <<< "${checked_arg}"
        for message in "${checked_arg[@]}"; do
            case "${message}" in
                Error*)
                    error=true
                    error_messages+=("${message}")
                    ;;
                Warning*)
                    error_messages+=("${message}")
                    ;;
                Value*)
                    arg_value="${message#Value: }"
                    ;;
            esac
        done

        # Assign the checked value to the argument.
        args["${arg_key}"]="${arg_value}"
    done

    # Sort and print all error messages.
    for error_message in "${error_messages[@]}"; do
        printf "%s\n" "${error_message}"
    done | sort >&2

    # If any argument was not or wrongly given, ${error} is set to true,
    # then print a blank line and the usage message, then exit.
    if [[ "${error}" == true ]]; then
        printf "\n" >&2
        argparser_prepare_help_message "usage" "$0" "${args_keys}" \
            "${args_values}" >&2
        exit 1
    fi

    # Return all arguments and their values as long string, with each
    # argument separated from its value by an
    # ${ARGPARSER_ARG_DELIMITER_2} character and each key-value tuple
    # separated by an ${ARGPARSER_ARG_DELIMITER_1} character.
    for arg in "${!args[@]}"; do
        printf "%s" "${arg}" "${ARGPARSER_ARG_DELIMITER_2}" "${args[${arg}]}" \
            "${ARGPARSER_ARG_DELIMITER_1}"
    done | sed "s/${ARGPARSER_ARG_DELIMITER_1}$//"
}

# If ${ARGPARSER_AUTO_READ_ARGS} is set to true, read in the arguments
# definitions from the file defined by ${ARGPARSER_ARG_DEF_FILE}.
# For ease of use, this part is not encapsulated inside a function, such
# that the code automatically gets executed upon sourcing the argparser.
if [[ "${ARGPARSER_AUTO_READ_ARGS}" == true ]]; then
    # Check if the variable that ${ARGPARSER_ARG_ARRAY_NAME} refers to
    # is defined.  If not, guess how it may be called by searching the
    # set variables (not functions, hence the set POSIX mode) for one
    # starting with "arg" for a better error message.
    if [[ ! -v "${ARGPARSER_ARG_ARRAY_NAME}" ]]; then
        args_name="$(set -o posix; set | grep "^arg" \
            | cut --delimiter="=" --fields=1)"
        printf "Error: The variable ARGPARSER_ARG_ARRAY_NAME refers to " >&2
        printf "\"%s\", " "${ARGPARSER_ARG_ARRAY_NAME}" >&2
        printf "but this variable is not defined.  Either you have given " >&2
        printf "your arguments array another name (maybe " >&2
        printf "\"%s\" -- " "${args_name}" >&2
        printf "then change ARGPARSER_ARG_ARRAY_NAME accordingly) or you " >&2
        printf "forgot defining the array at all (then define it).\n" >&2
        exit 1
    fi

    # Read in the requested arguments.  ${ARGPARSER_ARG_ARRAY_NAME} is
    # set to the name of the array holding the arguments in the script.
    # This name gets concatenated with the string "[@]" to form a
    # construct Bash interprets as array index.  By using variable
    # indirection, this then gets expanded to the array's values.  As
    # they are interpreted as string separated by spaces, read converts
    # them back into an array.
    args_keys="${ARGPARSER_ARG_ARRAY_NAME}[@]"
    read -a args_keys <<< "${!args_keys}"

    # Declare the variable ${args_definition} only if it doesn't exist
    # yet.  This happens when it is defined in the script to add
    # individual arguments that don't exist in ${ARGPARSER_ARG_DEF_FILE}
    # or no such file is given.
    if [[ ! -v args_definition ]]; then
        declare -A args_definition
    fi

    # If an arguments definition file is given (i.e.,
    # ${ARGPARSER_ARG_DEF_FILE} isn't set to the empty string), read the
    # arguments definitions from the list by discarding the respective
    # key from the line using sed.
    if [[ -n "${ARGPARSER_ARG_DEF_FILE}" ]]; then
        for arg_key in "${args_keys[@]}"; do
            arg_value="$(sed --regexp-extended --quiet \
                "s/^\[${arg_key}\]=(.*)\"(.*)\"/\1\2/p" \
                "${ARGPARSER_ARG_DEF_FILE}")"
            args_definition["${arg_key}"]="${arg_value}"
        done
    fi

    # Concatenate the keys and values.
    args_keys="$(printf "%s${ARGPARSER_ARG_DELIMITER_1}" \
        "${!args_definition[@]}" | sed "s/${ARGPARSER_ARG_DELIMITER_1}$//")"
    args_values="$(printf "%s${ARGPARSER_ARG_DELIMITER_1}" \
        "${args_definition[@]}" | sed "s/${ARGPARSER_ARG_DELIMITER_1}$//")"

    # Parse the arguments.
    parsed_args="$(argparser_main "${args_keys}" "${args_values}" "$@")"
    IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a parsed_args <<< "${parsed_args}"
    unset args
    declare -A args
    for parsed_arg in "${parsed_args[@]}"; do
        IFS="${ARGPARSER_ARG_DELIMITER_2}" read -a arg_tuple \
            <<< "${parsed_arg}"
        args["${arg_tuple[0]}"]="${arg_tuple[1]}"
    done
fi

# If ${ARGPARSER_AUTO_SET_ARGS} is set to true, set the arguments as
# variables to the current environment.  Set the positional arguments.
# To prevent the keyword arguments from being included into the
# environment as positional-like arguments, all positional arguments
# given to the calling script are diabled, if
# ${ARGPARSER_AUTO_UNSET_ARGS} is set to true.
# For ease of use, this part is not encapsulated inside a function, such
# that the code automatically gets executed upon sourcing the argparser.
if [[ "${ARGPARSER_AUTO_SET_ARGS}" == true ]]; then
    # Unset all positional arguments.
    if [[ "${ARGPARSER_AUTO_UNSET_ARGS}" == true ]]; then
        set --
    fi

    # Set all arguments.
    for arg in "${!args[@]}"; do
        if [[ "${arg}" == "${ARGPARSER_POSITIONAL_NAME}" ]]; then
            # Set all positional arguments and remove the respective key
            # from ${args}.
            IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a positional \
                <<< "${args[${arg}]}"
            set -- "${positional[@]}"
            unset positional
            unset "args[${ARGPARSER_POSITIONAL_NAME}]"
        elif [[ "${args[${arg}]}" == *"${ARGPARSER_ARG_DELIMITER_3}"*
            && "${ARGPARSER_AUTO_SET_ARRAYS}" == true ]]
        then
            # Set the keyword argument, which includes the
            # ${ARGPARSER_ARG_DELIMITER_3} and hence is a sequence of
            # elements, as indexed array variable, while keeping it in
            # ${args} for usage by the calling script.
            IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a "${arg}" \
                <<< "${args[${arg}]}"
        else
            # Set the keyword argument as variable, while keeping it in
            # ${args} for potential usage by the calling script.
            declare "${arg}"="${args[${arg}]}"
        fi
    done
fi
