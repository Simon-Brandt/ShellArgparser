#!/bin/false

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2024-12-11

# TODO: Enable parsing of combined short option flags, i.e.
#       script.sh -ab instead of script.sh -a -b.
# TODO: Use coloring function for help, usage, and error messages.
# BUG: Fix interpretation of keyword arguments after "--".
# BUG: Fix the argparser using all arguments from the definition, not
#      just from the indexed array "args".
# BUG: Fix short-option-only argument definitions giving faulty help
#      messages.

# Usage: Source this script with "source argparser.sh" inside the script
# whose arguments need to be parsed.  If ${ARGPARSER_READ_ARGS} is set
# to true (which per default is), the arguments will be parsed upon
# sourcing, else, the respective functions need to be called.  If
# ${ARGPARSER_SET_ARGS} is set to true (which per default is), the
# arguments will be set to variables upon sourcing, else, the
# associative array ${args} needs to be accessed.

# Purpose: Parse a script's arguments, giving proper error messages for
# wrongly set arguments, assigning the values to the respective
# variables, as well as creating and printing a help message.

########################################################################

# Set the argparser environment variables, as long as they aren't
# already set by the calling script or environment (to prevent
# overriding them).  The no-op command ":" is used for its side effect
# to set the variables, if unset or null, as part of the parameter
# expansion.
if (( "$#" >= 2 )) && [[ "$2" == "--" ]]; then
    case "$1" in
        "--read")
            ARGPARSER_READ_ARGS=true
            ARGPARSER_SET_ARGS=false
            ;;
        "--set")
            ARGPARSER_READ_ARGS=false
            ARGPARSER_SET_ARGS=true
            ;;
        "--all")
            ARGPARSER_READ_ARGS=true
            ARGPARSER_SET_ARGS=true
            ;;
        *)
            printf "Wrong action given: %s\n" "$1"
            exit 1
            ;;
    esac
    shift 2  # Get rid of the action specification.
fi
: "${ARGPARSER_READ_ARGS:=true}"
: "${ARGPARSER_SET_ARGS:=true}"
: "${ARGPARSER_ARG_ARRAY_NAME:="args"}"
: "${ARGPARSER_ARG_DEF_FILE:=""}"
: "${ARGPARSER_ARG_DELIMITER_1:="|"}"
: "${ARGPARSER_ARG_DELIMITER_2:=":"}"
: "${ARGPARSER_ARG_DELIMITER_3:=","}"
: "${ARGPARSER_ARG_GROUP_DELIMITER:="#"}"
: "${ARGPARSER_HELP_FILE:=""}"
: "${ARGPARSER_HELP_FILE_KEEP_COMMENTS:=false}"
: "${ARGPARSER_MAX_COL_WIDTH_1:=5}"
: "${ARGPARSER_MAX_COL_WIDTH_2:=33}"
: "${ARGPARSER_MAX_COL_WIDTH_3:=39}"
: "${ARGPARSER_POSITIONAL_NAME:="Positional"}"
: "${ARGPARSER_SET_ARRAYS:=true}"
: "${ARGPARSER_UNSET_ARGS:=true}"
: "${ARGPARSER_UNSET_ENV_VARS:=true}"
: "${ARGPARSER_UNSET_FUNCTIONS:=true}"

# Define the argparser functions.
function argparser_in_array() {
    # Check if an element occurs in an array.
    #
    # Arguments:
    # - $1: the element to search for
    # - $@: the array to search through
    #
    # Output:
    # - 0, if the element exists in the array
    # - 1, else

    # Define the local variables.
    local array
    local element
    local query

    # Read the query element and the array to search through.
    query="$1"
    shift
    read -a array <<< "$@"

    # Iterate through the array and compare each element to the query.
    # Output"0" on success, else "1".
    for element in "${array[@]}"; do
        if [[ "${element}" == "${query}" ]]; then
            printf "0"
            return
        fi
    done

    printf "1"
}

function argparser_colorize() {
    # Colorize the string using ANSI escape sequences.
    #
    # Arguments:
    # - $1: the string to colorize
    # - $2: the color to use
    # - $2: the style to use
    #
    # Output:
    # - the colorized string

    # Define the local variables.
    local color
    local colors
    local string
    local style
    local styles

    # Read the arguments.
    string="$1"
    color="$2"
    style="$3"

    # Define the associative array with colors and their corresponding
    # Select Graphic Rendition (SGR) ANSI escape sequence codes.
    declare -A colors
    colors=(
        [black]=30
        [red]=31
        [green]=32
        [yellow]=33
        [blue]=34
        [magenta]=35
        [cyan]=36
        [white]=37
    )

    declare -A styles
    styles=(
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

    printf "\e[%s;%sm%s\e[0m" "${colors["${color}"]}" "${styles["${style}"]}" \
        "${string}"
}

function argparser_parse_args() {
    # Parse the script's given arguments.
    #
    # Arguments:
    # - $1: the argument to parse
    # - $2: the associative array's keys for the argument definition
    # - $3: the associative array's values for the argument definition
    #
    # Output:
    # - the parsed argument as message or an error message, starting
    #   with "Help", "Usage", "Positional", "Error: ", "Argument: " or
    #   "Value: ", possibly concatenated with
    #   ${ARGPARSER_ARG_DELIMITER_1} characters

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
    # help or usage, output the respective message.
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
    # ${ARGPARSER_ARG_DELIMITER_3} characters and output the respective
    # message for each value.
    if [[ "${given_arg}" != -* ]]; then
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a values <<< "${given_arg}"
        for value in "${values[@]}"; do
            printf "Value: %s%s" "${value}" "${ARGPARSER_ARG_DELIMITER_1}"
        done
        return
    fi

    # Read all defined arguments and check whether the given argument is
    # part of them.  If so, output the argument's name and possibly all
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
                # Output the argument.
                printf "Argument: %s" "${arg}"
                return
            elif [[ "${given_arg}" == "-${short_option}="* ]]; then
                # Output the argument and all values split on
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
                # Output the argument.
                printf "Argument: %s" "${arg}"
                return
            elif [[ "${given_arg}" == "--${long_option}="* ]]; then
                # Output the argument and all values split on
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

    # If the argument hasn't been found in the definition, output an
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
    # Output:
    # - the parsed argument as message or an error message, starting
    #   with "Error: ", "Warning: " or "Value: ", possibly concatenated
    #   with ${ARGPARSER_ARG_DELIMITER_1} characters

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

    option_names="$(printf -- "--%s, " "${long_options[@]}" | sed "s/, $//")"

    # Check the values.  If an argument hadn't been given, its value was
    # set to "-".
    if [[ "${#values[@]}" > 0 && "${values[0]}" == "-" ]]; then
        # If the argument doesn't have a default value, it must have
        # been given, but is not.  Hence, output an error message.
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
            # If not, output an error message indicating the number of
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
        elif [[ "${arg_number}" == 0 && (! -v values || -z "${values[0]}") ]]
        then
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
    # match, output an error message indicating the number of required
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
    # production scripts.  Else, output an error message.
    if [[ "${choice_values[0]}" != "-" ]]; then
        # Check that flags have no choice values.
        if [[ "${arg_number}" == "0" ]]; then
            choice_values="$(IFS="${ARGPARSER_ARG_DELIMITER_3}"; printf "%s" \
                "${choice_values[*]}")"
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
                choice_values="$(IFS="${ARGPARSER_ARG_DELIMITER_3}"; \
                    printf "%s" "${choice_values[*]}")"
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
                choice_values="$(IFS="${ARGPARSER_ARG_DELIMITER_3}"; \
                    printf "%s" "${choice_values[*]}")"
                printf "Error: The argument "
                printf "%s " "${option_names}"
                printf "must be in "
                printf "{%s}.\n" "${choice_values}"
                return
            fi
        done
    fi

    # Output the checked values as
    # ${ARGPARSER_ARG_DELIMITER_3}-separated string.
    value="$(IFS="${ARGPARSER_ARG_DELIMITER_3}"; printf "%s" "${values[*]}")"
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
    line_type="text"

    while IFS="" read line; do
        # Set the line_type to "at_directive" if the line contains the
        # "@<ArgumentGroup>" directive, to "comment" if the line is
        # commented and ARGPARSER_HELP_FILE_KEEP_COMMENTS is false, and
        # to "text" if it is not empty (but not commented).  Thus, empty
        # lines following comments still have line_type set to
        # "comment".
        if [[ "${line}" == @* ]]; then
            line_type="at_directive"
            at_directive="${line:1}"

            if [[ "${help_type}" == "help" ]]; then
                argparser_create_help_message "${script_name}" \
                    "${at_directive}" "${args_keys}" "${args_values}"
            else
                argparser_create_usage_message "${script_name}" \
                    "${args_keys}" "${args_values}"
            fi
        elif [[ "${line}" == \#* \
            && "${ARGPARSER_HELP_FILE_KEEP_COMMENTS}" == false ]]
        then
            line_type="comment"
        elif [[ -n "${line}" \
            || "${ARGPARSER_HELP_FILE_KEEP_COMMENTS}" == true ]]
        then
            line_type="text"
        fi

        # If the line_type has been set to "text", print the current
        # line.  If it is set to "at_directive", reset it to "text" to
        # (possibly) print the next line, and only not the current
        # "@<ArgumentGroup>" line.
        if [[ "${line_type}" == "text" ]]; then
            printf "%s\n" "${line}"
        elif [[ "${line_type}" == "at_directive" ]]; then
            line_type="text"
        fi
    done < "${ARGPARSER_HELP_FILE}"
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
    local len_word
    local len_joined_words
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
                new_col_1_value+="$(printf -- "-%s, " "${short_options[@]}" \
                    | sed "s/, $//")"
                new_col_1_value+="]"
                if [[ "${long_options[0]}" != "-" ]]; then  # Long option.
                    new_col_1_value+=","
                fi
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
    # better able to parse the line breaks later on,
    # ${ARGPARSER_ARG_DELIMITER_1} characters are used instead.
    col_width_1=0
    for i in "${!col_1[@]}"; do
        # Split the element of column 1 word by word (on whitespace),
        # such that line breaks aren't inserted into entire words.
        read -a words <<< "${col_1[${i}]}"
        joined_words=""
        col_width=0
        for word in "${words[@]}"; do
            len_word="${#word}"
            len_joined_words="${#joined_words}"
            if (( len_word > ARGPARSER_MAX_COL_WIDTH_1 \
                && len_joined_words == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + len_word > ARGPARSER_MAX_COL_WIDTH_1 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break and print the word.  Then, set
                # the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${len_word}"
            elif (( len_joined_words == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += len_word ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += len_word + 1 ))
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
            len_word="${#word}"
            len_joined_words="${#joined_words}"
            if (( len_word > ARGPARSER_MAX_COL_WIDTH_2 \
                && len_joined_words == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + len_word > ARGPARSER_MAX_COL_WIDTH_2 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break and print the word.  Then, set
                # the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${len_word}"
            elif (( len_joined_words == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += len_word ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += len_word + 1 ))
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
            len_word="${#word}"
            len_joined_words="${#joined_words}"
            if (( len_word > ARGPARSER_MAX_COL_WIDTH_3 \
                && len_joined_words == 0 ))
            then
                # As the word is too long, print the word and introduce
                # a line break.  Then, reset the column width.
                joined_words+="$(printf "%s" "${word}" \
                    "${ARGPARSER_ARG_DELIMITER_1}")"
                col_width=0
            elif (( col_width + len_word > ARGPARSER_MAX_COL_WIDTH_3 ))
            then
                # As the line with the word appended would be too long,
                # introduce a line break and print the word.  Then, set
                # the column width.
                joined_words+="$(printf "%s" "${ARGPARSER_ARG_DELIMITER_1}" \
                    "${word}")"
                col_width="${len_word}"
            elif (( len_joined_words == 0 )); then
                # For the first word, add the word only.  Increase the
                # column width by the word's length.
                joined_words="${word}"
                (( col_width += len_word ))
            else
                # For any other word, add the word and a leading space
                # character, else, the words would be concatenated
                # without separation (the splitting removed any
                # whitespace).  Increase the column width appropriately.
                joined_words+=" ${word}"
                (( col_width += len_word + 1 ))
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
    local fallback_values
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
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a choice_values \
            <<< "${arg_definition[3]}"
        arg_number="${arg_definition[4]}"

        # Concatenate the short options and choice values for their
        # printing style.  If the argument has no default value, a set
        # of fallback s are printed.  Set these as the short options'
        # names in capitalized form.
        fallback_values="$(printf -- "%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${short_options[@]}")"
        fallback_values="${fallback_values%?}"
        fallback_values="${fallback_values^^}"
        short_options="$(printf -- "-%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${short_options[@]}")"
        short_options="${short_options%?}"
        choice_values="$(printf -- "%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${choice_values[@]}")"
        choice_values="${choice_values%?}"

        # Define the line for the current argument.  The argument may
        # have some short options, a default value and some choice
        # values or an argument number of 0 (i.e., it is a flag), with
        # the existence of each changing the look of the line.
        if [[ "${arg_number}" == 0 ]]; then  # Flag.
            printf "%s[%s]\n" "${whitespace}" "${short_options}"
        elif [[ "${choice_values[0]}" != "-" \
            && "${default_values[0]}" != "-" ]]
        then  # Choice and default.
            printf "%s%s[={%s}]\n" "${whitespace}" "${short_options}" \
                "${choice_values}"
        elif [[ "${choice_values[0]}" != "-" ]]; then  # Choice only.
            printf "%s%s={%s}\n" "${whitespace}" "${short_options}" \
                "${choice_values}"
        elif [[ "${default_values[0]}" != "-" ]]; then  # Default only.
            printf "%s%s[=%s]\n" "${whitespace}" "${short_options}" \
                "${fallback_values}"
        else  # No choice nor default.
            printf "%s%s=%s\n" "${whitespace}" "${short_options}" \
                "${fallback_values}"
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
        IFS="${ARGPARSER_ARG_DELIMITER_3}" read -a choice_values \
            <<< "${arg_definition[3]}"
        arg_number="${arg_definition[4]}"

        # Concatenate the long options and choice values for their
        # printing style.  If the argument has no default value, a set
        # of fallback s are printed.  Set these as the long options'
        # names in capitalized form.
        fallback_values="$(printf -- "%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${long_options[@]}")"
        fallback_values="${fallback_values%?}"
        fallback_values="${fallback_values^^}"
        long_options="$(printf -- "--%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${long_options[@]}")"
        long_options="${long_options%?}"
        choice_values="$(printf -- "%s${ARGPARSER_ARG_DELIMITER_3}" \
            "${choice_values[@]}")"
        choice_values="${choice_values%?}"

        # Define the line for the current argument.  The argument may
        # have some long options (short options aren't printed), a
        # default value and some choice values or an argument number of
        # 0 (i.e., it is a flag), with the existence of each changing
        # the look of the line.
        if [[ "${arg_number}" == 0 ]]; then  # Flag.
            printf "%s[%s]\n" "${whitespace}" "${long_options}"
        elif [[ "${choice_values[0]}" != "-" \
            && "${default_values[0]}" != "-" ]]
        then  # Choice and default.
            printf "%s%s[={%s}]\n" "${whitespace}" "${long_options}" \
                "${choice_values}"
        elif [[ "${choice_values[0]}" != "-" ]]; then  # Choice only.
            printf "%s%s={%s}\n" "${whitespace}" "${long_options}" \
                "${choice_values}"
        elif [[ "${default_values[0]}" != "-" ]]; then  # Default only.
            printf "%s%s[=%s]\n" "${whitespace}" "${long_options}" \
                "${fallback_values}"
        else  # No choice nor default.
            printf "%s%s=%s\n" "${whitespace}" "${long_options}" \
                "${fallback_values}"
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
    if [[ -n "${ARGPARSER_HELP_FILE}" ]]; then
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
    # - $@: the arguments to parse
    #
    # Output:
    # - the parsed and checked arguments with key and value as
    #   associative array

    # Define the local variables.
    local arg
    local arg_key
    local arg_value
    local args_keys
    local args_values
    local checked_arg
    local def_pattern
    local error
    local error_message
    local error_messages
    local key_pattern
    local given_args
    local i
    local line
    local lines
    local message
    local parsed_arg
    local value_pattern

    # Read the arguments.
    read -a given_args <<< "$@"

    # Check if the variable that ${ARGPARSER_ARG_ARRAY_NAME} refers to
    # is defined.  If not, guess how it may be called by searching the
    # set variables (not functions, hence the set POSIX mode) for a
    # variable name starting with "arg" to give a clearer error message.
    # If no such variable name is found, use "?" as default.
    if [[ ! -v "${ARGPARSER_ARG_ARRAY_NAME}" ]]; then
        args_name="$(set -o posix; set | grep "^arg" \
            | cut --delimiter="=" --fields=1)"
        : "${args_name:=?}"
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
    # If it already is "args" (the default name), nothing needs to be
    # done, but other variable names need to be mapped to "args" to be
    # able to refer to the variable by name.  Thus, the array name
    # stored in ${ARGPARSER_ARG_ARRAY_NAME} gets concatenated with the
    # string "[@]" to form a construct Bash interprets as array index.
    # By using variable indirection, this then gets expanded to the
    # array's values and copied into the final "args" array.
    if [[ "${ARGPARSER_ARG_ARRAY_NAME}" != "args" ]]; then
        args="${ARGPARSER_ARG_ARRAY_NAME}[@]"
        args=("${!args}")
    fi

    # Read the argument definition, if given as a file (i.e.,
    # ${ARGPARSER_ARG_DEF_FILE} isn't set to the empty string).
    if [[ -n "${ARGPARSER_ARG_DEF_FILE}" ]]; then
        mapfile -t lines < "${ARGPARSER_ARG_DEF_FILE}"
    fi

    # Define the patterns how the arguments definition's keys and values
    # look like, as well as the pattern of both.  For the default value
    # of ${ARGPARSER_ARG_DELIMITER_2}, a colon, the value pattern
    # describes alternating sequences of seven non-colons ("+([^:])")
    # and six colons (":") in Bash's extglob syntax.  In PCRE syntax,
    # the non-colon patten would be written as "[^:]+".  The key pattern
    # only consists of one non-colon pattern and the joined definition
    # pattern of the key pattern, a colon, and the value pattern, i.e.,
    # of eight non-colons interspersed with seven colons.  This reflects
    # the structure of the arguments definition.
    key_pattern="+([^${ARGPARSER_ARG_DELIMITER_2}])"

    value_pattern=""
    for i in {1..6}; do
        value_pattern+="+([^${ARGPARSER_ARG_DELIMITER_2}])"
        value_pattern+="${ARGPARSER_ARG_DELIMITER_2}"
    done
    value_pattern+="+([^${ARGPARSER_ARG_DELIMITER_2}])"

    def_pattern="${key_pattern}${ARGPARSER_ARG_DELIMITER_2}${value_pattern}"

    # Read all arguments for the script.  The arguments may either be
    # defined in the script, where they're given in the eight-column
    # argparser syntax, or in a separate arguments definition file,
    # where they're only given as their key.  If the structure differs,
    # an error is printed and the script is aborted.
    declare -A args_definition
    for arg in "${args[@]}"; do
        if [[ "${arg}" == ${def_pattern} ]]; then
            # The argument matches the entire definition pattern.
            # Separate its key and value from each other and store them.
            arg_key="${arg%%${ARGPARSER_ARG_DELIMITER_2}*}"
            arg_value="${arg#*${ARGPARSER_ARG_DELIMITER_2}}"
            args_definition["${arg_key}"]="${arg_value}"
        elif [[ "${arg}" == ${key_pattern} && -n "${ARGPARSER_ARG_DEF_FILE}" ]]
        then
            # The argument matches the key pattern and an arguments
            # definition file is given. Iterate over all arguments
            # definition lines from the file. When the argument key in
            # one line matches the given key and the value matches the
            # value pattern, store the argument's definition and
            # continue the outer loop (with index 2).  If the inner loop
            # doesn't get aborted by the continuation, it means that no
            # fitting argument definition has been found.  Thus, print
            # an error message and abort.
            for line in "${lines[@]}"; do
                arg_key="${line%%${ARGPARSER_ARG_DELIMITER_2}*}"
                arg_value="${line#*${ARGPARSER_ARG_DELIMITER_2}}"
                if [[ "${arg_key}" == "${arg}" \
                    && "${arg_value}" == ${value_pattern} ]]
                then
                    args_definition["${arg_key}"]="${arg_value}"
                    continue 2
                fi
            done
            printf "Error: No argument definition for \"%s\"\n" "${arg}" >&2
            exit 1
        else
            # The argument doesn't match any pattern and is thus deemed
            # invalid.  Abort the script with an error message.
            printf "Error: Invalid argument definition: \"%s\"\n" "${arg}" >&2
            exit 1
        fi
    done

    # Concatenate the keys and values.
    args_keys="$(IFS="${ARGPARSER_ARG_DELIMITER_1}"; printf "%s" \
        "${!args_definition[*]}")"
    args_values="$(IFS="${ARGPARSER_ARG_DELIMITER_1}"; printf "%s" \
        "${args_definition[*]}")"

    # Set the default argument key to ${ARGPARSER_POSITIONAL_NAME}, such
    # that initially, all arguments given before a keyword argument are
    # recognized as positional.
    arg_key="${ARGPARSER_POSITIONAL_NAME}"
    arg_value=( )

    error=false
    error_messages=( )

    unset args
    declare -Ag args

    # Parse the script's given arguments.
    for arg in "${given_args[@]}"; do
        # Parse the argument.
        parsed_arg="$(argparser_parse_args "${arg}" "${args_keys}" \
            "${args_values}")"
        IFS="${ARGPARSER_ARG_DELIMITER_1}" read -a parsed_arg \
            <<< "${parsed_arg}"

        # Read the output message and either print the help or usage
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
            args["${arg_key}"]="$(IFS="${ARGPARSER_ARG_DELIMITER_3}"; \
                printf "%s" "${arg_value[*]}")"
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

        # Read the output message and either append the message to the
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
}

# If ${ARGPARSER_READ_ARGS} is set to true, read the arguments.
if [[ "${ARGPARSER_READ_ARGS}" == true ]]; then
    argparser_main "$@"
fi

# If ${ARGPARSER_SET_ARGS} is set to true, set the arguments as
# variables to the current environment.  Set the positional arguments.
# If ${ARGPARSER_UNSET_ARGS} is set to true, all positional arguments
# given to the calling script are disabled to prevent the keyword
# arguments from being included into the environment as positional-like
# arguments.
# As setting positional variables inside a function makes them local to
# the function, not the calling script, this part is not encapsulated
# inside a function.
if [[ "${ARGPARSER_SET_ARGS}" == true ]]; then
    # Unset all positional arguments.
    if [[ "${ARGPARSER_UNSET_ARGS}" == true ]]; then
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
            && "${ARGPARSER_SET_ARRAYS}" == true ]]
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

unset args_keys
unset args_values
unset parsed_arg
unset parsed_args

# If ${ARGPARSER_UNSET_FUNCTIONS} is set to true, unset all argparser
# functions.  The names are used instead of a glob to limit side effects
# with potentially same-named functions from the calling script that
# stand in no relation to the argparser.
if [[ "${ARGPARSER_UNSET_FUNCTIONS}" == true ]]; then
    unset -f argparser_in_array
    unset -f argparser_colorize
    unset -f argparser_parse_args
    unset -f argparser_check_arg_value
    unset -f argparser_print_help_message
    unset -f argparser_create_help_message
    unset -f argparser_create_usage_message
    unset -f argparser_prepare_help_message
    unset -f argparser_main
fi

# If ${ARGPARSER_UNSET_ENV_VARS} is set to true, unset all argparser
# environment variables.  Again, the names are used instead of a glob to
# limit side effects with potentially same-named variables from the
# calling script that stand in no relation to the argparser.
if [[ "${ARGPARSER_UNSET_ENV_VARS}" == true ]]; then
    unset ARGPARSER_ARG_ARRAY_NAME
    unset ARGPARSER_ARG_DEF_FILE
    unset ARGPARSER_ARG_DELIMITER_1
    unset ARGPARSER_ARG_DELIMITER_2
    unset ARGPARSER_ARG_DELIMITER_3
    unset ARGPARSER_ARG_GROUP_DELIMITER
    unset ARGPARSER_HELP_FILE
    unset ARGPARSER_HELP_FILE_KEEP_COMMENTS
    unset ARGPARSER_MAX_COL_WIDTH_1
    unset ARGPARSER_MAX_COL_WIDTH_2
    unset ARGPARSER_MAX_COL_WIDTH_3
    unset ARGPARSER_POSITIONAL_NAME
    unset ARGPARSER_READ_ARGS
    unset ARGPARSER_SET_ARGS
    unset ARGPARSER_SET_ARRAYS
    unset ARGPARSER_UNSET_ARGS
    unset ARGPARSER_UNSET_ENV_VARS
    unset ARGPARSER_UNSET_FUNCTIONS
fi
