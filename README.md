# Bash argparser

The argparser is a designed to be an easy-to-use, yet powerful command-line argument parser for your shell scripts. It is mainly targeting Bash, but other shells are supported, as well. Shells other than Bash just require a slightly different method of invokation (*i.e.*, running the argparser in a pipe or process substitution, not by sourcing it).

Applying the argparser should lead to shorter and more concise code than the traditionally used [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)")/[`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") or a bare suite of conditionals in a [`case..esac`](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#index-case "gnu.org &rightarrow; Conditional Constructs &rightarrow; case") statement allow. More importantly, the user-friendliness of argparser-powered command-line parsing is far superior thanks to a wide range of checked conditions with meaningful error messages.

The argparser is entirely written in pure Bash, without invoking external commands. Thus, using it does not add additional dependencies to your script&mdash;except of course the argparser itself&mdash;, especially not differing versions/implementations of a program (like with [`awk`](https://man7.org/linux/man-pages/man1/awk.1p.html "man7.org &rightarrow; man pages &rightarrow; awk(1p)")). Additionally, its design choices of not calling external commands and running almost without forking into subshells lead to a good runtime despite the extensive parsing and checking steps. The argparser is inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module.

<!-- <toc> -->
## Table of contents

1. [Features](#1-features)
1. [Installation](#2-installation)
1. [Tutorial](#3-tutorial)
   1. [Argument passing](#31-argument-passing)
   1. [Argparser invokation](#32-argparser-invokation)
   1. [Argparser configuration](#33-argparser-configuration)
   1. [Arguments definition files](#34-arguments-definition-files)
   1. [Help and usage messages](#35-help-and-usage-messages)
   1. [Help and usage message files](#36-help-and-usage-message-files)
   1. [Help and usage message localization](#37-help-and-usage-message-localization)
   1. [Version messages](#38-version-messages)
   1. [Error and warning messages](#39-error-and-warning-messages)
   1. [Message styles](#310-message-styles)
   1. [Standalone usage](#311-standalone-usage)
1. [Comparison of command-line parsers](#4-comparison-of-command-line-parsers)
   1. [Feature comparison](#41-feature-comparison)
   1. [Example scripts](#42-example-scripts)
      1. [`getopts`](#421-getopts)
      1. [`getopt`](#422-getopt)
      1. [shFlags](#423-shflags)
      1. [docopt](#424-docopt)
      1. [argparser](#425-argparser)
1. [Reference](#5-reference)
   1. [Arguments definition](#51-arguments-definition)
      1. [Argument ID (`id`)](#511-argument-id-id)
      1. [Short option names (`short_opts`)](#512-short-option-names-short_opts)
      1. [Long option names (`long_opts`)](#513-long-option-names-long_opts)
      1. [Value names (`val_names`)](#514-value-names-val_names)
      1. [Default values (`defaults`)](#515-default-values-defaults)
      1. [Choice values (`choices`)](#516-choice-values-choices)
      1. [Data type (`type`)](#517-data-type-type)
      1. [Argument count (`arg_no`)](#518-argument-count-arg_no)
      1. [Argument group (`arg_group`)](#519-argument-group-arg_group)
      1. [Notes (`notes`)](#5110-notes-notes)
      1. [Help text (`help`)](#5111-help-text-help)
   1. [Colors and styles](#52-colors-and-styles)
   1. [Include directives](#53-include-directives)
      1. [`@All` directive](#531-all-directive)
      1. [`@<ArgumentGroup>` directive](#532-argumentgroup-directive)
      1. [`@Header` directive](#533-header-directive)
      1. [`@Remark` directive](#534-remark-directive)
      1. [`@Usage` directive](#535-usage-directive)
      1. [`@Help` directive](#536-help-directive)
   1. [Translations](#54-translations)
      1. [`Positional arguments`](#541-positional-arguments)
      1. [`Help options`](#542-help-options)
      1. [`Error`](#543-error)
      1. [`Warning`](#544-warning)
      1. [`Usage`](#545-usage)
      1. [`Arguments`](#546-arguments)
      1. [`Options`](#547-options)
      1. [`Mandatory arguments`](#548-mandatory-arguments)
      1. [`Deprecated`](#549-deprecated)
      1. [`Default`](#5410-default)
      1. [`--help`](#5411---help)
      1. [`--usage`](#5412---usage)
      1. [`--version`](#5413---version)
      1. [`false`](#5414-false)
      1. [`true`](#5415-true)
      1. [`Error env var bool`](#5416-error-env-var-bool)
      1. [`Error env var char`](#5417-error-env-var-char)
      1. [`Error env var identifier`](#5418-error-env-var-identifier)
      1. [`Error env var int`](#5419-error-env-var-int)
      1. [`Error env var uint`](#5420-error-env-var-uint)
      1. [`Error env var file 0001`](#5421-error-env-var-file-0001)
      1. [`Error env var file 0010`](#5422-error-env-var-file-0010)
      1. [`Error env var file 0011`](#5423-error-env-var-file-0011)
      1. [`Error env var file 0100`](#5424-error-env-var-file-0100)
      1. [`Error env var file 0101`](#5425-error-env-var-file-0101)
      1. [`Error env var file 0110`](#5426-error-env-var-file-0110)
      1. [`Error env var file 0111`](#5427-error-env-var-file-0111)
      1. [`Error env var file 1111`](#5428-error-env-var-file-1111)
      1. [`Error env var styles`](#5429-error-env-var-styles)
      1. [`Error env var option type`](#5430-error-env-var-option-type)
      1. [`Error env var orientation`](#5431-error-env-var-orientation)
      1. [`Error env var delimiters`](#5432-error-env-var-delimiters)
      1. [`Error env var short name empty`](#5433-error-env-var-short-name-empty)
      1. [`Error env var short name length`](#5434-error-env-var-short-name-length)
      1. [`Error env var short name inner duplication`](#5435-error-env-var-short-name-inner-duplication)
      1. [`Error env var short name outer duplication`](#5436-error-env-var-short-name-outer-duplication)
      1. [`Error env var short options`](#5437-error-env-var-short-options)
      1. [`Error env var long options`](#5438-error-env-var-long-options)
      1. [`Error env var files`](#5439-error-env-var-files)
      1. [`Error arg array 1`](#5440-error-arg-array-1)
      1. [`Error arg array 2`](#5441-error-arg-array-2)
      1. [`Error arg array 3`](#5442-error-arg-array-3)
      1. [`Error wrong arg def`](#5443-error-wrong-arg-def)
      1. [`Error no arg def`](#5444-error-no-arg-def)
      1. [`Error arg def field`](#5445-error-arg-def-field)
      1. [`Error arg def file field`](#5446-error-arg-def-file-field)
   1. [Environment variables](#55-environment-variables)
      1. [Overview](#551-overview)
      1. [`ARGPARSER_ADD_HELP`](#552-argparser_add_help)
      1. [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage)
      1. [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version)
      1. [`ARGPARSER_ALLOW_FLAG_INVERSION`](#555-argparser_allow_flag_inversion)
      1. [`ARGPARSER_ALLOW_FLAG_NEGATION`](#556-argparser_allow_flag_negation)
      1. [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#557-argparser_allow_option_abbreviation)
      1. [`ARGPARSER_ALLOW_OPTION_MERGING`](#558-argparser_allow_option_merging)
      1. [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name)
      1. [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file)
      1. [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header)
      1. [`ARGPARSER_ARG_DEF_HAS_HEADER`](#5512-argparser_arg_def_has_header)
      1. [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1)
      1. [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)
      1. [`ARGPARSER_ARGPARSER_VERSION`](#5515-argparser_argparser_version)
      1. [`ARGPARSER_ARGS`](#5516-argparser_args)
      1. [`ARGPARSER_CHECK_ARG_DEF`](#5517-argparser_check_arg_def)
      1. [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars)
      1. [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file)
      1. [`ARGPARSER_COUNT_FLAGS`](#5520-argparser_count_flags)
      1. [`ARGPARSER_DICTIONARY`](#5521-argparser_dictionary)
      1. [`ARGPARSER_ERROR_EXIT_CODE`](#5522-argparser_error_exit_code)
      1. [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style)
      1. [`ARGPARSER_HELP_ARG_GROUP`](#5524-argparser_help_arg_group)
      1. [`ARGPARSER_HELP_EXIT_CODE`](#5525-argparser_help_exit_code)
      1. [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file)
      1. [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#5527-argparser_help_file_include_char)
      1. [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#5528-argparser_help_file_keep_comments)
      1. [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options)
      1. [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style)
      1. [`ARGPARSER_LANGUAGE`](#5531-argparser_language)
      1. [`ARGPARSER_MAX_COL_WIDTH_1`](#5532-argparser_max_col_width_1)
      1. [`ARGPARSER_MAX_COL_WIDTH_2`](#5533-argparser_max_col_width_2)
      1. [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3)
      1. [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width)
      1. [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group)
      1. [`ARGPARSER_READ_ARGS`](#5537-argparser_read_args)
      1. [`ARGPARSER_SCRIPT_ARGS`](#5538-argparser_script_args)
      1. [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name)
      1. [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args)
      1. [`ARGPARSER_SET_ARRAYS`](#5541-argparser_set_arrays)
      1. [`ARGPARSER_SILENCE_ERRORS`](#5542-argparser_silence_errors)
      1. [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings)
      1. [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file)
      1. [`ARGPARSER_UNSET_ARGS`](#5545-argparser_unset_args)
      1. [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars)
      1. [`ARGPARSER_UNSET_FUNCTIONS`](#5547-argparser_unset_functions)
      1. [`ARGPARSER_USAGE_EXIT_CODE`](#5548-argparser_usage_exit_code)
      1. [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file)
      1. [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#5550-argparser_usage_file_include_char)
      1. [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#5551-argparser_usage_file_keep_comments)
      1. [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5552-argparser_usage_message_option_type)
      1. [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#5553-argparser_usage_message_orientation)
      1. [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options)
      1. [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style)
      1. [`ARGPARSER_USE_LONG_OPTIONS`](#5556-argparser_use_long_options)
      1. [`ARGPARSER_USE_SHORT_OPTIONS`](#5557-argparser_use_short_options)
      1. [`ARGPARSER_USE_STYLES_IN_FILES`](#5558-argparser_use_styles_in_files)
      1. [`ARGPARSER_VERSION`](#5559-argparser_version)
      1. [`ARGPARSER_VERSION_EXIT_CODE`](#5560-argparser_version_exit_code)
      1. [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options)
      1. [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style)
      1. [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style)
      1. [`ARGPARSER_WRITE_ARGS`](#5564-argparser_write_args)
<!-- </toc> -->

## 1. Features

The argparser:

- parses your script's **positional** and **keyword (option) arguments**
- allows **any number** of **short** and **long option names** for the same option (as aliases)
- gives proper **error** and **warning messages** for wrongly set arguments or unset mandatory options, according to a concise definition provided by your script
- assigns the positional and keyword arguments' values to **corresponding variables** in your script's scope
- can use parts of an arguments definition **shared across multiple scripts**
- creates and prints a verbose and customizable **help** or a brief **usage message**, as well as a short **version message**
- can give **localized** help, usage, error, and warning messages in any language you define
- can be widely **configured** to your needs by a large set of environment variables and optional companion files to your script

## 2. Installation

> [!WARNING]
> The argparser requires Bash 4.0 or higher (try `bash --version`). It is extensively tested with Bash 5.2, precisely, with `GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`. With `BASH_COMPAT` set to `40` or higher, the [tests](tests) still succeed, but if you encounter errors for versions earlier than 5.2, please file an issue, such that the minimum requirement can be adjusted. For the execution (not invokation) of the argparser, shells other than Bash aren't supported, and the argparser aborts with an error message.

No actual installation is necessary, as the argparser is just a Bash script that can be located in an arbitrary directory of your choice, like `/usr/local/bin`. Thus, the "installation" is as simple as cloning the repository in this very directory:

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Simon-Brandt/bash_argparser.git
```

To be able to refer to the argparser directly by its name, without providing the entire path (which enhances the portability of your script to other machines), you may want to add

```bash
PATH="/path/to/bash_argparser:${PATH}"
```

(replace the `/path/to` with your actual path) to either of the following files (see `info bash` or `man bash`):

- `~/.profile` (local addition, for login shells)
- `~/.bashrc` (local addition, for non-login shells)
- `/etc/profile` (global addition, for login shells)
- `/etc/bash.bashrc` (global addition, for non-login shells)

> [!CAUTION]
> Be wary not to forget the final `${PATH}` component in the above command, or else you will override the [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH")) for all future shell sessions, meaning no other (non-builtin) command will be resolvable, anymore.

## 3. Tutorial

To give you an idea about the argparser's application, the following sections show some excerpts of scripts used for internal testing purposes, in the herein given form located in the [tutorial](tutorial) directory, trying to guide you through the various features.

> [!NOTE]
> For the terminology in argument parsing, refer to the Python [`optparse` documentation](https://docs.python.org/3/library/optparse.html#terminology "python.org &rightarrow; Python documentation &rightarrow; optparse module &rightarrow; terminology"). Additionally, for consistency with the positional arguments, options are herein partly referred to as keyword arguments.

<!-- <toc title="Table of contents (Tutorial)"> -->
### Table of contents (Tutorial)

1. [Argument passing](#31-argument-passing)
1. [Argparser invokation](#32-argparser-invokation)
1. [Argparser configuration](#33-argparser-configuration)
1. [Arguments definition files](#34-arguments-definition-files)
1. [Help and usage messages](#35-help-and-usage-messages)
1. [Help and usage message files](#36-help-and-usage-message-files)
1. [Help and usage message localization](#37-help-and-usage-message-localization)
1. [Version messages](#38-version-messages)
1. [Error and warning messages](#39-error-and-warning-messages)
1. [Message styles](#310-message-styles)
1. [Standalone usage](#311-standalone-usage)
<!-- </toc> -->

### 3.1. Argument passing

First, let's see how we can use the argparser to parse the arguments given to your script, here saved as `try_argparser.sh` in the CWD. You can uncover the script if you want to test and try it, but we'll come back to it in the next section. For now, only the output is relevant, when we call the script from the command line.

<details>

<summary>Contents of <code>try_argparser.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser.  As the arguments have multiple short and long
# options, override the default column widths for the help message.
ARGPARSER_MAX_COL_WIDTH_1=9
ARGPARSER_MAX_COL_WIDTH_2=33

# Define the arguments.
args=(
    "id    | short_opts | long_opts   | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |             | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |             | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a,A        | var-1,var-a | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b,B        | var-2,var-b | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c,C        | var-3,var-c | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d,D        | var-4,var-d | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 | e,E        | var-5,var-e | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f,F        | var-6,var-f | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g,G        | var-7,var-g | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
```

</details>

When you (as a user) have to deal with unknown scripts or programs, maybe the first thing to try is to run the script with the `--help` flag. As we're currently seeing `try_argparser.sh` as sort of a "black box", we assume not to know any implementation detail. So we're trying to run:

```console
$ bash try_argparser.sh --help
Usage: try_argparser.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                              one positional argument with default
                                           and choice (default: 2)
pos_2                                      two positional arguments without
                                           default or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR_A     one value without default or choice
-b, -B,   --var-2=VAL_2, --var-b=VAR_B     at least one value without default
                                           or choice
-c, -C,   --var-3={A,B}, --var-c={A,B}     at least one value with choice

Optional options:
-d, -D,   [--var-4={A,B,C}],               one value with default and choice
          [--var-d={A,B,C}]                (default: "A")
-e, -E,   [--var-5=VAL_5], [--var-e=VAR_E] one value with default (default:
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
```

This already gives us plenty of information. Even though we don't know yet where it comes from (it's generated by the argparser, not hardcoded in the script), we can see that `try_argparser.sh` accepts two positional arguments and seven different options, (more or less) aptly named `--var-1` through `--var-7`. There are other names referring to the same options, but we'll come back to this later.

Now that we had a look at the options (or keyword arguments, to cope with the fact that some are mandatory), we know that some of them, `--var-4` through `--var-7`, as well as `pos_1`, to be precise, have default arguments. These are indicated by the square brackets in the help message, and since they are optional, we try not to care about them. Instead, we run `try_argparser.sh` as follows:

```console
$ bash try_argparser.sh 1 --var-1=1 --var-2=2 --var-3=A
Error: The argument "pos_2" requires 2 values, but has 1 given.

Usage: try_argparser.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

This gives us an error message&mdash;certainly not what we wanted. Trying to understand the reason, we see that we guesstimated that there should be one value for the positional argument `pos_2` (we chose a literal `1`), but the error message tells us it should be two. Further, the argparser tries to help us by giving a line with the general usage for `try_argparser.sh`, but the error message seems clear enough for us, here. So we try it again, this time using `1` and `2` as positional arguments:

```console
$ bash try_argparser.sh 1 2 --var-1=1 --var-2=2 --var-3=A
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

And now we got something that looks like the intended output (and yes, it is). Even without fully understanding yet what the argparser does, you can see that we set *three* options and their arguments ([`IFS`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-IFS "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; IFS") whitespace&ndash;delimited) on the command-line invokation of `try_argparser.sh`, *viz.* `--var-1`, `--var-2`, and `--var-3`. Nonetheless, the script reports *seven* options to be given. This is due to `var_4` through `var_7` (note that the *identifiers* use underscores ("snake case"), while the *option names* use hyphens ("kebab case"), here) having said default values that are used when the argument is not given on the command line. For `var_1` through `var_3`, the reported values are exactly what we specified, *i.e.*, `"1"`, `"2"`, and `"A"`, respectively.

Likewise, `pos_2` is reported to be `"1,2"`, so some sort of sequence of the two values we gave (more precise: the concatenation of the two values, joined by an [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) character, as we'll see later), and `pos_1` has been assigned a default value of `"2"`. Note that the quotes here are added by `try_argparser.sh` upon printing the values; internally, they are unquoted.

From the help message above, we know that there are also short versions of the keyword arguments, and that it's possible to give positional arguments after a `--`, fitting with our command-line experience. So, let's see what happens with the following type of call:

```console
$ bash try_argparser.sh -a 1 -b 2 -c A -- 1 2
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

That's exactly the same output as before. We set the three mandatory options with arguments, *viz.* `-a 1`, `-b 2`, and `-c A`, but none is reported in the script's output. Then, we set a double hyphen (`--`) and two values, `1` and `2`. Thus, it is possible to give positional arguments after the special keyword argument `--`, *i.e.*, a double hyphen with no name behind. This is the usual way of saying "end of keyword arguments".

There is an argparser-specific additional feature, intended to facilitate the mixing of positional and keyword arguments: the special keyword argument `++`:

```console
$ bash try_argparser.sh -a 1 -b 2 -- 1 2 ++ -c A
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

Two plus signs together are interpreted by the argparser as sign to re-start the parsing of keyword arguments. You can imagine the plus signs as crossed hyphens, thus negating their meaning (as is done for flags in a later example).

Setting `--` after the positional argument&ndash;only part has started (*i.e.*, after a previous `--`) makes this second `--` a positional argument. In contrast, setting `++` after `--` re-starts the usual parsing, so the following argument is parsed as keyword argument if it starts with a hyphen (or a plus sign for flags, see below), and as positional argument, else.

Setting `--` after `++` stops the parsing (possibly again), while setting `++` after `++` means to parse a following non-hyphenated argument as positional, instead of as value to the previous keyword argument. You may rarely need the `++`, but a possible use case for scripts would be to gather command-line arguments or values from different processes, like *via* command/process substitution. Then, you can just combine the two streams, without needing to care whether both may set a `--`. Just join them with a `++` and the parsing occurs as expected.

As we saw in the two examples, options can have name aliases, *i.e.*, any number of synonymous option names pointing to the same entity (argument identifier in the arguments definition). Thereby, not only aliases with two hyphens (so-called long options) are possible, but also some with only one leading hyphen (short options). For fast command-line usage, short options are convenient to quickly write a command; but for scripts, the long options should be preferred as they carry more information due to their verbose name (like, what does `-v` mean&mdash;is it `--version`, `--verbose`, or even `--verbatim`?). The argparser allows an arbitrary number of short and/or long option names for a keyword argument to be defined, and options can be provided by any alias on the command line.

Further, long option names can be abbreviated, as long as no collision with other names arises (like when giving `--verb` in the example above). This requires [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#557-argparser_allow_option_abbreviation) to be set to `true`. In contrast, short option names may be merged with their value or other short option names (if they're flags, see below), given that [`ARGPARSER_ALLOW_OPTION_MERGING`](#558-argparser_allow_option_merging) is set to `true`. For the sake of an example without needing a novel script, we'll set the latter variable to the environment of the script execution by prefixing the assignments to the usual command line:

```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash try_argparser.sh -a1 -b2 -cA -- 1 2
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

That's again the same output, somehow suggesting it may be hardcoded in the script&mdash;fortunately, such tricks aren't needed. But as you saw, there is no whitespace between the short option names and the values.

And since the long option names only differ in their last character, here, it is impossible to abbreviate them without ambiguity:

```console
$ ARGPARSER_ALLOW_OPTION_ABBREVIATION=true bash try_argparser.sh --var-1 1 --var-2 2 --var -- 1 2
Error: The argument "--var" matches multiple options.

Usage: try_argparser.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

You may have noticed that we didn't use an equals sign (`=`) to delimit option names and their values, here. Though from the former examples it may seem as if it was related to the usage of short option names, for the argparser, it is completely arbitrary whether you use spaces or equals signs. Again, typing spaces is faster on the command line, but using the explicit equals sign makes a script's code more legible.

This has the additional advantage that it's clear to a user (reading *e.g.* your script's manual) that the value belongs to the option before, and that it's not a flag followed by a positional argument. As long as this user doesn't know that the argparser only treats values following option names as positional arguments when they're separated by a double hyphen or doubled plus sign, it may look confusing.

Moreover, using an equals sign is the only way of providing arguments starting with a hyphen to an option, since a whitespace-separated word would be interpreted as (possibly nonexistent) option name. By this, you can give negative numbers on the command line.

Let's have a look at another example invokation:

```console
$ bash try_argparser.sh 1 2 -a 1 -b 2 3 -c A,B -b 4
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2,3,4".
The keyword argument "var_3" is set to "A,B".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

Two things have changed in the invokation call: The `-b` option now appears twice, with the first of which being followed by two values instead of one. Then, the `-c` option has its value given as `A,B` (note the comma).

From the report for the `-b` option, an alias of `--var-2`, you can see that all three values&mdash;`2`, `3`, and `4`&mdash;are passed to `var_2`. Thus, it is possible to define keyword arguments to accept more than one value (just as `pos_2` already has shown for the positional arguments), with any given value being concatenated to the last given option name (or rather, the last hyphenated value, a difference important for nonexistent option names). You can even call an argument multiple times, passing values at different positions to it, though it seems rather counterproductive (in terms of confusing and unnecessarily verbose) for usage in scripts. On the command line, however, it may save you to go back when you realize you forgot to type a value. Another use case even for scripts would again be the gathering of command-line arguments or values from different processes, combining the two streams without needing to care whether they pass mutually exclusive option names or the same.

As you can see from the `-c` option, you can also use commas (again actually [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) characters) to pass multiple values at the same time. These have the same meaning as whitespace-delimited arguments, again with the exception of not interpreting hyphens as option names. As a stylistic advice, for scripts, use long options, the equals sign, and commas, as they tend to look clearer; whereas for simple command-line usage, take advantage of the short options and the ability to use spaces as delimiter, as both are faster to type.

Regarding the positional arguments, we'll try the following:

```console
$ bash try_argparser.sh 1 2 -a 1 -b 2 -c A -- 3
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "1".
The positional argument "pos_2" on index 2 is set to "2,3".
```

Like the keyword arguments, also the positional arguments can be given on multiple locations, *viz.* right after the script name, anywhere after `--`, and right after `++`. These values are assigned to the defined positional arguments in their order of definition, with each of which taking as many values as defined. If there is an optional positional argument (*i.e.*, a default is given), it is only assigned a value from the command line if more values are given than necessary for the required arguments. This is the reason for `pos_1` now being set to `1` instead of `2` as hitherto; we explicitly set its value by adding a third positional argument.

It may be worth noting that, if a positional argument accepts an infinite number of values, it gets all remaining values, meaning that no positional argument can be defined or given after it. Moreover, it is impossible to parse the presence or absence of multiple optional positional arguments, only their presence or absence altogether is parsable. Thus, use a positional argument taking two values for this purpose. Likewise, both having an optional positional argument and a positional argument accepting an infinite number of values is impossible. For keyword arguments, no such restrictions exist, as they're delimited by the option names.

Since there were some additional options given in the help message, let's have a look at another example invokation:

```console
$ bash try_argparser.sh 1 2 -a 1 -b 2 -c A -f +g
Warning: The argument "-g,-G,--var-7,--var-g" is deprecated and will be removed in the future.
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "true".
The keyword argument "var_7" is set to "false".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

Enter: flags. The options `-f`, aliased to `--var-6`, and `+g`, aliased to `++var-7`, are so-called flags: Their presence or absence on the command line changes their value in a boolean manner (though flags are less powerful than booleans since you can't calculate with them). As you can see in the reported values, `var_6` has changed its value from `false` to `true`, just by giving the flag's *name*, instead of a real value. This means that you can check whether a flag had been set by evaluating the corresponding variable's value to `true` or `false`. Note that these are just mnemonics, they have no boolean meaning (like upon testing in an [`if..else`](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#index-if "gnu.org &rightarrow; Conditional Constructs &rightarrow; if") statement) for the weakly typed Bash interpreter.

Similarly, `var_7` has become `false` instead of the default `true`. Here, unusually, the option name was not introduced by a hyphen, but a plus sign. For flags only, and only when [`ARGPARSER_ALLOW_FLAG_INVERSION`](#555-argparser_allow_flag_inversion) is set to `true` (the default), it is possible to set the value to `true` by the normal hyphen, and to `false` by the plus sign, which, again, can be imagined as crossed hyphen. The default value is only taken when the flag is absent, else, their presence gives the value as `true` or `false`.

Precisely, giving `-g` or `--var-7` sets `var_7` to `true`, and giving `+g` or `++var-7` sets `var_7` to `false` (a crossed, *i.e.* negated, `true`). This behavior is used, for example, by the Bash [`set`](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html "gnu.org &rightarrow; The Set Builtin") builtin (like `set -x` to activate `xtrace` and `set +x` to deactivate it). Though the usage for long options is uncommon, it is enabled by the argparser for consistency, such that long option&ndash;only flags can be used along normal long option&ndash;only arguments.

Further, when [`ARGPARSER_ALLOW_FLAG_NEGATION`](#556-argparser_allow_flag_negation) is set to `true` (the default), flags can also be given by prepending their long option name by `no-`, *i.e.*, `--var-7` would become `--no-var-7`. This negates the flag's value as well, doubling its effect for `++no-var-7`&mdash;which would be a very obfuscated of saying `--var-7`.

Another interesting fact is that the argparser output a warning that `-g,-G,--var-7,--var-g` would be deprecated. This shows us that we can define arguments, and years later, when we want to change the command-line interface, we can set the obsolete arguments as deprecated, allowing the user to gradually adapt to the changes in his workflows employing your script. A common application would be the renaming of an option or the entire removal of its function.

Taking one final set of example invokations, we can see how the option merging works for flags:

```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash try_argparser.sh 1 2 -a 1 -b 2 -c A +fg
Warning: The argument "-g,-G,--var-7,--var-g" is deprecated and will be removed in the future.
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "false".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

We merged `--var_6` and `-var_7` in one call, `+fg`, thus setting them both to `false`.

```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash try_argparser.sh 1 2 -a 1 -b 2 -fgcA
Warning: The argument "-g,-G,--var-7,--var-g" is deprecated and will be removed in the future.
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "true".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

Now, we gave them together with `var_3` and its value, and we see that the flags are set to `true`, owing to the hyphen, and that `-c` correctly interprets the following `A` as value, not as option `-A` (which would be an alias for `-var_1`).

```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash try_argparser.sh 1 2 -a 1 -b 2 +fgcA
Error: The argument "-c,-C,--var-3,--var-c" is no flag and thus cannot be given with a "+" prefix.
Warning: The argument "-g,-G,--var-7,--var-g" is deprecated and will be removed in the future.

Usage: try_argparser.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

The tiny change of the prefix for the `fgcA` compound argument made our whole attempt fail: Since `var_3` is not a flag, we can't use the boolean negation, here, and thus the argparser yields an error. So, although specifying `+fg` is no problem, the merged `c` makes the parsing fail. Were `g` also defined to accept a value, the argparser would have reported the error already here, since the following `cA` would have been seen as value to the option `+g`. This shows that care should be taken when merging option names.

### 3.2. Argparser invokation

Now that you have seen how the argparser serves in parsing and interpreting the command-line arguments given to your script, it's time to explain what you need to do to employ the argparser in your script. As promised, here's the code of `try_argparser.sh` again. You can cover it if you already read it above (and memorize the lines of code&hellip;).

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser.  As the arguments have multiple short and long
# options, override the default column widths for the help message.
ARGPARSER_MAX_COL_WIDTH_1=9
ARGPARSER_MAX_COL_WIDTH_2=33

# Define the arguments.
args=(
    "id    | short_opts | long_opts   | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |             | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |             | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a,A        | var-1,var-a | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b,B        | var-2,var-b | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c,C        | var-3,var-c | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d,D        | var-4,var-d | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 | e,E        | var-5,var-e | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f,F        | var-6,var-f | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g,G        | var-7,var-g | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
```

</details>

As you can see, there are three sections in the code that are specific to the argparser. The accession at the end only serves us to gain insights into the values of the arguments and are not necessary to include&mdash;you would replace this by the actual workings of your script.

The first section sets argparser-specific [environment variables](#55-environment-variables) to optimize the visual output, which we'll investigate later. Then, the arguments are defined, and finally, the argparser is called. This call is central to the script as it is the line that runs the argparser. So, most simply, from your Bash script whose command-line arguments you want to be parsed, the main thing you need to do is to [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") the argparser (sourcing means in-place execution without forking):

```bash
source argparser -- "$@"
```

Shells other than Bash require a slightly different approach, the [standalone usage](#311-standalone-usage) in a pipe, but most things still hold for this case. As a result of the argparser's configurability (see below), it is necessary to give cour script's command line after a double hyphen, *i.e.*, using `-- "$@"`.

Alternatively to `source`, but not recommended for the lack of the command's clearness, you could use the synonymous [dot operator](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_002e "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; dot operator") inherited from the Bourne shell (which cannot run the argparser, which is a Bash script!):

```bash
. argparser -- "$@"
```

This is the simplest form of invoking the argparser. It will read your script's command line, parse the arguments, and set them to variables in your script. And this is the reason for sourcing instead of normal calling as in:

```bash
bash argparser
```

or:

```bash
./argparser
```

since you don't want the arguments to be set in a subprocess created after forking, as these will be gone when the argparser (and with it, the subprocess) exits. Still, this is the required way for other shells, which make use of the argparser's ability to write the arguments to STDOUT, if [`ARGPARSER_WRITE_ARGS`](#5564-argparser_write_args) is set to `true`.

As stated, the argparser sets an associative array to store the arguments in. For maximum control over the variables in your script's scope, you can configure its name via [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name), defaulting to `"args"`. In `try_argparser.sh`, we obtained the report by accessing exactly this associative array, looping over all variables known to the script that start with `var` or `pos`, respectively. At the same time, this variable name is used to provide the arguments definition.

While the single line `source argparser -- "$@"` provides the argparser's functionality by running it, the positional and keyword arguments need to be defined somewhere. Thus, prior to the argparser's invokation (and, in our case, after setting some environment variables to set the maximum column widths for the help message), the arguments are defined. Thereby, the indexed array `args` defines which command-line arguments are acceptable for the script, possibly giving an argument definition in an argparser-specific tabular manner. Alternatively, this definition could be given as a separate [arguments definition file](#34-arguments-definition-files), indicated as [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file).

The rationale for allowing `args` to store both the arguments alone and them along their definition gets clear when you realize that it's possible to share an arguments definition file across multiple scripts and only require a limited subset of the arguments for the current script. Then, you can give these arguments a common definition, identical for any script using them. Additionally, it is even possible to use an arguments definition file and definitions in `args` together, with the latter expanding on the former or overriding them, thus providing the opportunity to use arguments with the same name, but different definitions, in separate scripts. This offers great flexibility when writing wrapper scripts around pipelines, when you want to pass common arguments to different programs in your pipeline. Just define an argument within your wrapper script and pass its value to both programs.

The argument-defining entries in the indexed array named by [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name), defaulting to `"args"`, can be understood as some sort of key&ndash;value pair for each argument, but merged in one string (not as true keys and values in associative arrays). The key is a unique identifier for the argparser functions, and the name under which the argument's value can be obtained from the associative array `args`. The corresponding value provides the argument's definition to the argparser.

This argparser-specific tabular format consists of eleven columns, each separated from each other by an [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1) character, defaulting to a pipe (`"|"`). Multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) character, defaulting to a comma (`","`). The columns are defined as follows:

- `id`: the unique argument identifier (like `var_1`)
- `short_opts`: the short options (one hyphen, like `-a` and `-A` for `var_1`)
- `long_opts`: the long options (two hyphens, like `--var-1` and `--var-a` for `var_1`)
- `val_names`: the value names for the help message, instead of uppercased short/long option names (like `VAL_1` for `var_1`)
- `defaults`: the default values (like `"A"` for `var_4`)
- `choices`: the choice values for options with a limited set of values to choose from (like `"A"`, `"B"`, and `"C"` for `var_4`)
- `type`: the data type the argument shall have and will be tested on (like `"char"` for `var_4`)
- `arg_no`: the number of required values (either numerical from `0` to infinity or `"+"`, meaning to accept as many values as given, at least one, like `1` for `var_4`)
- `arg_group`: the argument group for grouping of keyword arguments in the help text (like `"Optional options"` for `var_4`)
- `notes`: additional notes to the argparser, currently only `"deprecated"` is supported (like for `var_7`)
- `help`: the help text for the `--help` flag (like `"one value with default and choice"` for `var_4`)

If [`ARGPARSER_ARG_DEF_HAS_HEADER`](#5512-argparser_arg_def_has_header) is set to `true` (the default), then these names must be given as a header above all argument definitions. Providing a header has the advantage that the order of the columns does not matter, as long as the first column is the `id`. If you omit the header, the above order is mandatory.

Keyword arguments can have multiple short and/or long option names, optional default values, and/or an arbitrary number of choice values. The same holds for positional arguments, which are identified by having neither short nor long option names. Generally, absence of a value is indicated by the empty string (`""`). This allows the usage of hyphens, besides their special meaning on the command line (as option names), for the convention of regarding files given as `"-"` as sign to read from STDIN.

As you saw above, the argparser will aggregate all arguments (values) given after a word starting with a hyphen (*i.e.*, an option name) to this option. If the number doesn't match the number of required values, an error is thrown instead of cutting the values. If an argument gets a wrong number of values, but has a default value, only a warning is thrown and the default value is taken.

Thereby, errors abort the script, while warnings just write a message to `STDERR`. Even after parsing or value checking errors occurred, the parsing or value checking continues and the argparser aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

### 3.3. Argparser configuration

The argparser accepts over 50 options for configuring the argument parsing, checking their values and the consistency of the arguments definition, creating the various message types (see below), and setting the required companion files. These options are available as [environment variables](#55-environment-variables). By this, you can set them directly in your script, and even [`export`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-export "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; export") them to child processes. Thus, you can set these variables once and use them throughout your script suite.

Still, it is likely that, after some time or for a specific project, you'll settle with a certain set of options that you'll want to reuse for all or many scripts. Then, setting the environment variables in any script becomes a tedious task, wasting space in each script. Additionally, should you want to change a value, you'd need to change it in any file.

For this reason, the argparser also supports configuration by a config file (see the [example](resources/options.cfg)), given by the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file) environment variable. This file contains the options in a key&ndash;value syntax and can be shared by multiple scripts, which only need to point to the same configuration file. The options have the same name as the environment variables, with a stripped leading `"ARGPARSER_"` and being written in lowercase, and with underscores replaced by hyphens. *I.e.*, the "screaming snake case" is replaced by the "kebab case".

The keys and values must be separated by an equals sign (`=`), but can be surrounded by spaces, allowing for a table-like arrangement. Further, empty or commented lines (those starting with a hashmark, *i.e.*, `#`) are ignored, and thus can be used to explain certain values. In-line comments aren't supported to simplify the parsing of values containing a hashmark. It is possible to quote strings, but not necessary, which allows the one-by-one replacement of values from scripts to the configuration file and *vice versa*.

Thereby, you can override options from the file with some given in your script. Should an option be defined in neither place, a default is used. This allows you to list only necessary options in your configuration file and let the argparser set everything else.

Now, let's have a look at the configuration file (or at least, at the first ten lines to save some space):

```console
$ head --lines=10 options.cfg
add-help                  = true
add-usage                 = true
add-version               = true
allow-flag-inversion      = true
allow-flag-negation       = true
allow-option-abbreviation = false
allow-option-merging      = false
arg-array-name            = "args"
arg-def-file              = ""
arg-def-file-has-header   = true
```

For demonstration, we take a stripped-down version of our `try_argparser.sh` script as `try_config_file.sh`, where we omit the alias names for the short and long options, for the sake of brevity. Note that using [`readlink`](https://man7.org/linux/man-pages/man1/readlink.1.html "man7.org &rightarrow; man pages &rightarrow; readlink(1)") is only required here to cope with the configuration file residing in the [resources](resources) directory, it is not necessary if you use absolute paths or store the configuration file alongside your script in the same directory&mdash;or won't invoke your script from multiple working directories.

<details open>

<summary>Contents of <code>try_config_file.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser, reading the configuration from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_CONFIG_FILE="${dir}/options.cfg"

# Define the arguments.
args=(
    "id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |           | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d          |           | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
```

The script can now be invoked as any other script, yielding the same results:

```console
$ bash try_config_file.sh 1 2 -a 1 -b 2 -c A
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

</details>

Further, all environment variables can also be given as command-line parameters upon sourcing the argparser. Thereby, the options have the same name as in the configuration file ("kebab case"), and are only valid for the given argparser call.

You can give the options right before your script's command line and the delimiting double hyphen. The argparser interprets all options given before the first double hyphen as options belonging to the argparser, the remainder is interpreted as your script's command line. This especially means that you cannot use the double hyphen to delimit positional arguments for the argparser&mdash;but since none are supported (apart from the command line), an error would be given, anyways.

Due to the manner the [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") builtin is defined, the argparser cannot distinguish whether it was sourced with arguments, so mandates them in any case. This means that you must explicitly state the `-- "$@"` to pass the arguments to the argparser, even if you don't use any option. The `--` is required to separate the argparser modification from the actual arguments&mdash;after all, it is not too unlikely that some of your scripts might want to use one of the argparser options for themselves. To still be able to distinguish between an option for the argparser and an argument to your script, the double hyphen is used as delimiter.

So the general call would look like this:

```bash
source argparser [--option...] -- "$@"
```

with `option` being any environment variable's transformed name.

Since the argparser parses its options like it does for your script's ones (by non-recursively sourcing itself), the same special syntax regarding flags is used. That means, if you set `++set-args` as option, then the argparser will only read the command-line arguments, parsing them into an associative array you can access afterwards, denoted by the name the environment variable [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) refers to (per default, `"args"`)&mdash;but it won't set them as variables to your script.  The opposite holds for the option `++read-args`, which deactivates the reading. Finally, if `--read-args` and `--set-args` are set, the arguments will both be read and set (in this order). Since the default value for both options is `true`, these actions are also carried out when only one option or none is given.

Not surprisingly, you need to read the arguments before you set them, but you can perform arbitrary steps in-between. This could come handy when you want to use the variable names the argparser sets for some task or want to manipulate the associative array prior having the values set.

If you [`export`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-export "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; export") (or [`declare -x`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-declare "gnu.org &rightarrow; Bash Builtins &rightarrow; declare")) environment variables like [`ARGPARSER_READ_ARGS`](#5537-argparser_read_args) and [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args) to child processes (like scripts called from your master script), they will inherit these variables. If, in your child script, you use a bare `source argparser -- "$@"`, *i.e.*, without specifying an option to the argparser, the settings from the inherited environment variables will be used. However, you can always override them by specifying an argparser option. By this, you may set the environment variables in your master script and use the settings in some child scripts, with the others setting their own options. Thus, to rule out any possible influence of the environment on reading and setting, using the two respective option flags might be recommendable for certain use cases.

### 3.4. Arguments definition files

In the previous sections, we always provided the arguments definition directly in the script, right before we sourced the argparser. However, it is possible to "outsource" the definition (or part of it) in a bespoke file that is referred to by the [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file) environment variable.

Using a separate arguments definition file allows you to share the definition across multiple scripts that use partially or entirely identical arguments, a common case in program suites or when wrapper scripts are used. Should some scripts require an argument to have the same name, but different definitions, they can be given in their respective scripts, in addition to the remainder from the file. Moreover, this attempt allows a separation of concerns, as we can move the arguments definition (static) away from their manipulation (dynamic). This shrinks our trial file once more, yielding `try_arg_def_file.sh`.

<details open>

<summary>Contents of <code>try_arg_def_file.sh</code></summary>

```bash
#!/bin/bash

# Set the argparser, reading the arguments definition from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_ARG_DEF_FILE="${dir}/arguments.csv"

# Set the arguments.
args=(
    pos_1
    pos_2
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
    var_7
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
```

</details>

At the same time, we need an arguments definition file, herein aptly called `arguments.csv`. Its structure is identical to the arguments definition we previously used, allowing you to easily move a definition between your script and the separate file.

You can (and should) add the header to explain the fields, or else need to set [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header) to `false`. Then, you can set your text editor to interpret the data as CSV file, possibly syntax-highlighting the columns with the given header or aligning the columns (as done by the [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv "Visual Studio Code &rightarrow; Marketplace &rightarrow; Rainbow CSV Extension") extension in [Visual Studio Code](https://code.visualstudio.com/ "Visual Studio Code")). Since the argparser strips leading and trailing whitespace off the fields, you can save the file with this alignment:

```console
$ cat arguments.csv
id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help
pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice
pos_2 |            |           | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice
var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice
var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice
var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice
var_4 | d          |           | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice
var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default
var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default
var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default
```

When passing the usual argument names and values, we see that all arguments are still recognized:

```console
$ bash try_arg_def_file.sh 1 2 -a 1 -b 2 -c A
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "false".
The keyword argument "var_7" is set to "true".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```

Likewise, the [usage (and help) message](#35-help-and-usage-messages) is completely unaffected:

```console
$ bash try_arg_def_file.sh -u
Usage: try_arg_def_file.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```

### 3.5. Help and usage messages

No matter how many keyword arguments are defined, as long as [`ARGPARSER_ADD_HELP`](#552-argparser_add_help) and [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage) are set to `true` (the default), the argparser interprets the flags from the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options) (default: `-h` and `-?`) and `--help` as call for a verbose help message and the flags from the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options) (default: `-u`) and `--usage` as call for a brief usage message. Then, these options are automatically added to the script's argument definition and override any same-named argument name (yielding an error message if [`ARGPARSER_CHECK_ARG_DEF`](#5517-argparser_check_arg_def) is set to `true`). This is to ensure that the novice user of your script can do exactly what we did, above: trying the most common variants to get some help over how to use a program or script by typing

```bash
try_argparser.sh --help
```

or

```bash
try_argparser.sh -h
```

or

```bash
try_argparser.sh -?
```

Of course,

```bash
help try_argparser.sh
```

won't work as the [`help`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-help "gnu.org &rightarrow; Bash Builtins &rightarrow; help") command only recognizes Bash builtins.

As a huge convenience, the argparser will build the help and usage messages from the defined arguments for your script, if either of the `ARGPARSER_HELP_OPTIONS`, `--help`, `ARGPARSER_USAGE_OPTIONS`, or `--usage` options is given on the command line (even along with others). These messages indicate the short and/or long names, as well as the default and choice values. In the case of the help message, the argument group, the notes, and the help text from the arguments' definitions are printed, too.

As we already saw upon the occasion of an error, our `try_argparser.sh` usage message looks as follows:

```console
$ bash try_argparser.sh --usage
Usage: try_argparser.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

The usage message clearly summarizes the arguments, including name aliases (always taking all short options, or, if absent, all long options, or *vice versa*, see below), indicates whether they're optional or mandatory (optionals use square brackets), and specifies the choice values (in curly braces) and, partially, the argument number (an ellipsis, *i.e.*, `"..."`, for an infinite number). Short options precede long options, options with default precede those without, likewise for positionals, and keyword arguments precede positional arguments. All groups are sorted alphabetically by the first option name as key. The help and usage options precede all groups.

For a better overview when having lots of arguments, we can choose a columnar layout instead of the single row, using [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#5553-argparser_usage_message_orientation):

```console
$ ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash try_argparser.sh --usage
Usage: try_argparser.sh [-h,-? | -u | -V]
                        [-d,-D={A,B,C}]
                        [-e,-E=VAL_5]
                        [-f,-F]
                        [-g,-G]
                        -a,-A=VAL_1
                        -b,-B=VAL_2...
                        -c,-C={A,B}...
                        [{1,2}]
                        pos_2
```

Additionally, we may choose to show the long options by [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5552-argparser_usage_message_option_type):

```console
$ ARGPARSER_USAGE_MESSAGE_OPTION_TYPE=long ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash try_argparser.sh --usage
Usage: try_argparser.sh [--help | --usage | --version]
                        [--var-4,--var-d={A,B,C}]
                        [--var-5,--var-e=VAL_5]
                        [--var-6,--var-f]
                        [--var-7,--var-g]
                        --var-1,--var-a=VAL_1
                        --var-2,--var-b=VAL_2...
                        --var-3,--var-c={A,B}...
                        [{1,2}]
                        pos_2
```

Of course, you would normally give these environment variables in your script and wouldn't rely on the user to give them on the command line&mdash;especially not, when he's looking for *how to use* the script.

Likewise, we can investigate the help message (just as we did above, with the very same result):

```console
$ bash try_argparser.sh --help
Usage: try_argparser.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]                              one positional argument with default
                                           and choice (default: 2)
pos_2                                      two positional arguments without
                                           default or choice

Mandatory options:
-a, -A,   --var-1=VAL_1, --var-a=VAR_A     one value without default or choice
-b, -B,   --var-2=VAL_2, --var-b=VAR_B     at least one value without default
                                           or choice
-c, -C,   --var-3={A,B}, --var-c={A,B}     at least one value with choice

Optional options:
-d, -D,   [--var-4={A,B,C}],               one value with default and choice
          [--var-d={A,B,C}]                (default: "A")
-e, -E,   [--var-5=VAL_5], [--var-e=VAR_E] one value with default (default:
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
```

The help message details all short and long option names, their optionality (*i.e.*, whether there are default values), and their choice values, using the same syntax as in the usage message. Additionally, the help text and notes from the arguments definition are given. The arguments are separated by their groups, thus structuring the help message. First, the group for the positional arguments is given (indicated by [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group)), then follow the keyword argument groups in alphabetical order. Finally, the default `--help`, `--usage`, and `--version` arguments (the latter for the [version message](#38-version-messages)) are given as separate, yet unnamed group.

The help message's structure aims at reproducing the commonly found structure in command-line programs. By setting [`ARGPARSER_MAX_COL_WIDTH_1`](#5532-argparser_max_col_width_1), [`ARGPARSER_MAX_COL_WIDTH_2`](#5533-argparser_max_col_width_2), or [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3) (as done in `try_argparser.sh`), the column widths may be adapted to your needs, recommendably totalling 77 characters (thus 79 characters including the separating spaces). Note that columns are automatically shrunk, when their content is narrower, but they're not expanded, when their content is wider. This is to guarantee that the help message, when *e.g.* sent as logging output, nicely fits in the space you have.

Alternatively, you may want to set [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width). By this, the help message will have a defined width, independent of shrunk columns. This is achieved by expanding the third column (with the help text) to the remaining width. For this to work, [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3) must be set to `0`.

### 3.6. Help and usage message files

The argparser is not only able to compile a help message, but can also be guided by a separate file. Using the [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file) environment variable pointing to this file, to a certain degree, you can customize the help message's look and structure by moving the blocks the message consists of around and enriching it by arbitrary text. Again, we use a simplified script as `try_help_file.sh` without alias names for the short and long options.

<details open>

<summary>Contents of <code>try_help_file.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser, reading the help message from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_HELP_FILE="${dir}/help_message.txt"

# Define the arguments.
args=(
    "id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |           | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d          |           | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"
```

</details>

Additionally, we need a separate file, which we'll call `help_message.txt` and have passed as value to [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file). This plain-text file stores the help message's structure and can contain arbitrary additional content.

```console
$ cat help_message.txt
# Print the header.
A brief header summarizes the way how to interpret the help message.
@Header

# Print the options from the "Mandatory options" group.
The following options have no default value.
@Mandatory options

# Print the options from the "Optional options" group.
The following options have a default value.
@Optional options

# Print the three help options.
There are always three options for the help messages.
@Help
```

Now, we get the following help message:

```console
$ bash try_help_file.sh -h
A brief header summarizes the way how to interpret the help message.
Usage: try_help_file.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

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
[-d={A,B,C}]          one value with default and choice (default: "A")
      [--var-5=VAL_5] one value with default (default: "E")
[-f], [--var-6]       no value (flag) with default (default: false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with default (default: true)

There are always three options for the help messages.
[-h,  [--help]        display this help and exit (default: false)
-?],
[-u], [--usage]       display the usage and exit (default: false)
[-V], [--version]     display the version and exit (default: false)
```

When you compare the structure of this help message with both the previous version and the help file, you see that there, you can include the sections from the auto-generated help message by prefixing their names with an [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#5527-argparser_help_file_include_char) character, defaulting to an `"@"`. Generally speaking, an include directive, as the commands are referred to, like `@Section`, includes the section named `"Section"`.

The following section names (include directives) are supported, explained in greater detail in the reference below:

- [`@All`](#531-all-directive)
- [`@<ArgumentGroup>`](#532-argumentgroup-directive)
- [`@Header`](#533-header-directive)
- [`@Help`](#536-help-directive)
- [`@Remark`](#534-remark-directive)
- [`@Usage`](#535-usage-directive)

Thereby, `<ArgumentGroup>` can be the name of any argument group given in the arguments definition, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. `@Help` prints the help, usage, and version options (depending on which of them are defined by [`ARGPARSER_ADD_HELP`](#552-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version)), `@Remark` prints the remark that mandatory arguments to long options are mandatory for short options too, and `@Usage` prints the usage line. Finally, the shorthand `@All` means to print the usage line, the remark, all argument groups, and the help options, in this order, while `@Header` prints the usage line and the remark.

Further, lines starting with a `"#"` character in the help file aren't printed if [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#5528-argparser_help_file_keep_comments) is set to `false` (the default). This allows you to comment your help file, perhaps to explain the structure&mdash;or just to write a header or footer with your name and debug email address inside.

The same as for help messages can be done for usage messages, using the [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file), [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#5550-argparser_usage_file_include_char), and [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#5551-argparser_usage_file_keep_comments) environment variables. However there, only the `@All` directive is supported, yet.

### 3.7. Help and usage message localization

It is even possible to localize your script's help and usage message. For the usage message, all you need is an [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file), a simplified YAML file giving the translation of the auto-generated parts in the messages. For each section, you give the language identifier for the language you want the message to be translated to, *i.e.*, the [`ARGPARSER_LANGUAGE`](#5531-argparser_language). For the usage message, this suffices, but in the help message, also non-auto-generated parts are included, especially each argument's help text. For them to be translated, you need a dedicated [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file) and possibly a localized [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file).

If you set these environment variables to files whose filename contains the language, like so:

```console
$ ls -1 arguments_*.csv help_message_*.txt
arguments_de.csv
arguments_en.csv
help_message_de.txt
help_message_en.txt
```

then, in your script, you can set the `ARGPARSER_ARG_DEF_FILE` and `ARGPARSER_HELP_FILE` accordingly, as in our new script `try_localization.sh`. There, we dynamically extract the language as the first two characters of the `LANG` (or, alternatively, `LC_ALL` or `LANGUAGE`) environment variable. Its value is defined as the language, the country or territory, and the codeset, like `"en_US.UTF-8"` or `"de_DE.UTF-8"`.

<details open>

<summary>Contents of <code>try_localization.sh</code></summary>

```bash
#!/bin/bash

# Set the argparser, reading the arguments definition, help message, and
# translation from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_ARG_DEF_FILE="${dir}/arguments_${LANG::2}.csv"
ARGPARSER_ARG_DEF_FILE_HAS_HEADER=false
ARGPARSER_HELP_FILE="${dir}/help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="${dir}/translation.yaml"

# Set the arguments.
args=(
    pos_1
    pos_2
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
    var_7
)
source argparser -- "$@"
```

</details>

You need to manually translate the arguments definition (only the argument groups and the help texts) in the new arguments definition file, here shown as using no header (stated by the [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header) environment variable):

```console
$ cat arguments_de.csv
pos_1 |   |       | pos_1 | 2     | 1,2   | int  | 1 | Positionale Argumente  |            | ein positionales Argument mit Vorgabe und Auswahl
pos_2 |   |       | pos_2 |       |       | int  | 2 | Positionale Argumente  |            | zwei positionale Argumente ohne Vorgabe oder Auswahl
var_1 | a | var-1 | VAL_1 |       |       | uint | 1 | Erforderliche Optionen |            | ein Wert ohne Vorgabe oder Auswahl
var_2 | b | var-2 | VAL_2 |       |       | int  | + | Erforderliche Optionen |            | mindestens ein Wert ohne Vorgabe oder Auswahl
var_3 | c | var-3 | VAL_3 |       | A,B   | char | + | Erforderliche Optionen |            | mindestens ein Wert mit Auswahl
var_4 | d |       | VAL_4 | A     | A,B,C | char | 1 | Optionale Optionen     |            | ein Wert mit Vorgabe und Auswahl
var_5 |   | var-5 | VAL_5 | E     |       | str  | 1 | Optionale Optionen     |            | ein Wert mit Vorgabe
var_6 | f | var-6 | VAL_6 | false |       | bool | 0 | Optionale Optionen     |            | kein Wert (Flag) mit Vorgabe
var_7 | g | var-7 | VAL_7 | true  |       | bool | 0 | Optionale Optionen     | deprecated | kein Wert (Flag) mit Vorgabe
```

The same is necessary for the printable part of the help file:

```console
$ cat help_message_de.txt
# Print the header.
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
@Header

# Print the options from the "Erforderliche Optionen" group.
Die folgenden Optionen haben keinen Vorgabewert.
@Erforderliche Optionen

# Print the options from the "Optionale Optionen" group.
Die folgenden Optionen haben einen Vorgabewert.
@Optionale Optionen

# Print the three help options.
Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
@Help
```

Finally, we need a translation file for the auto-generated parts. Note that here, only the German locale is used, while you may want to add further rows if your target users come from multiple countries.

<details open>

<summary>Contents of <code>translation.yaml</code></summary>

```yaml
$ head --lines=80 translation.yaml
# 1.    Define the translations for the arguments parsing.
---
Positional arguments:
  en: Positional arguments
  de: Positionale Argumente

Help options:
  en: Help options
  de: Hilfsoptionen

Error:
  en: Error
  de: Fehler

Warning:
  en: Warning
  de: Warnung
...

# 2.    Define the translations for help messages.
# 2.1.  Define the translations for the usage line (part of the header).
---
Usage:
  en: Usage
  de: Aufruf

Arguments:
  en: ARGUMENTS
  de: ARGUMENTE

Options:
  en: OPTIONS
  de: OPTIONEN
...

# 2.2.  Define the translations for the remark (part of the header).
---
Mandatory arguments:
  en: >
    Mandatory arguments to long options are mandatory for short options too.
  de: >
    Erforderliche Argumente für lange Optionen sind auch für kurze
    erforderlich.
...

# 2.3.  Define the translations for the help column.
---
Deprecated:
  en: DEPRECATED
  de: VERALTET

Default:
  en: default
  de: Vorgabe

--help:
  en: display this help and exit
  de: diese Hilfe anzeigen und beenden

--usage:
  en: display the usage and exit
  de: den Aufruf anzeigen und beenden

--version:
  en: display the version and exit
  de: die Version anzeigen und beenden

false:
  en: false
  de: falsch

true:
  en: true
  de: wahr
...
```

</details>

Regarding the structure of the simplified and strictly line-oriented YAML file, the groups used as identifiers for the translations are given without indentation, followed by a colon. This creates a key in an associative array. The respective value is another associative array, this time holding the translation, with the language identifier as key and the translated string as value. The key must be indented by exactly two spaces, followed by a colon and another space. Then, either the translation can be given or a greater-than sign (`">"`). All lines given afterwards that are indented by exactly four spaces are concatenated and used as translated string. In the translation, you can (and should) use the format specifier `$n`, with $n \in \{1, 2, 3, 4\},$ to denote the $n$-th position that the argparser should use for the interpolation with variable values, which cannot be directly given in the translation.

You can optionally add line comments, though not in-line comments, and structure the file using empty lines or YAML blocks with three hyphens (`"---"`) or three dots (`"..."`). Since the purpose of the YAML file is to store a translation, not to serialize arbitrary data, more advanced features (like JSON-like in-line associative arrays) aren't supported by the argparser, and an error is thrown for unrecognized structures.

If a group identifier is missing, the argparser will emit a warning if and only if the state which uses the translation is reached, most commonly when the user requests the help message. In order not to miss a key, you can simply re-use the YAML file provided with the argparser.

Now, the argparser is given the arguments definition, help, and translation file for the current locale. Thus, the help message can be generated in localized form, according to the user's `LANG`.

You might also want to set the locale only for your script upon invokation from another script. Then, just prefix the invokation with the desired locale for the `LANG` variable. By this, you limit the effect of changing to the script call (just as we did above for the argparser environment variables):

```console
$ LANG=en_US.UTF-8 bash try_localization.sh --help
...
$ LANG=de_DE.UTF-8 bash try_localization.sh --help
...
```

The former command prints the American English help message, the latter its German translation, as you can see in full detail, here:

```console
$ LANG=de_DE.UTF-8 bash try_localization.sh -h
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
Aufruf: try_localization.sh [OPTIONEN] ARGUMENTE -- [pos_1] pos_2

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
[-d={A,B,C}]          ein Wert mit Vorgabe und Auswahl (Vorgabe: "A")
      [--var-5=VAL_5] ein Wert mit Vorgabe (Vorgabe: "E")
[-f], [--var-6]       kein Wert (Flag) mit Vorgabe (Vorgabe: falsch)
[-g], [--var-7]       (VERALTET) kein Wert (Flag) mit Vorgabe (Vorgabe: wahr)

Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
[-h,  [--help]        diese Hilfe anzeigen und beenden (Vorgabe: falsch)
-?],
[-u], [--usage]       den Aufruf anzeigen und beenden (Vorgabe: falsch)
[-V], [--version]     die Version anzeigen und beenden (Vorgabe: falsch)
```

Likewise, the usage message is localized:

```console
$ LANG=de_DE.UTF-8 bash try_localization.sh -u
Aufruf: try_localization.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```

### 3.8. Version messages

Besides the the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options), `--help`, the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options), and `--usage`, there is a third option intended to help the user, the [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options) (default: `-V`) and `--version`. This flag compiles a brief version message for your script, showing its canonical name (the [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name)) and the version number (the [`ARGPARSER_VERSION`](#5559-argparser_version)). Just as for the help and usage messages, you can disable the version message (and its corresponding flags) by setting [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version) to `false`. Note that the default short option name is an uppercase `V`, such that you can use the lowercase `v` (as `-v`) for your purposes, like `--verbatim` or `--verbose`. This is in line with the common behavior of command-line programs. By setting `ARGPARSER_VERSION_OPTIONS` accordingly, you can of course change it to your needs, if desired.

The output version message is very simple:

```console
$ bash try_argparser.sh -V
try_argparser.sh v1.0.0
```

### 3.9. Error and warning messages

The argparser outputs about a hundred different error and warning messages to give both you and your script's user as detailled feedback as possible about what went wrong with the argument parsing. Each message starts with your script's canonical name (the [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name)), followed by either `"Error:"` or `"Warning:"` and the respective message. Using the same simplified YAML file as for the help and usage messages (the [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file)), also the error and warning messages can be fully localized.

Generally, errors may lead to abortion of the script, while warnings just write the message to `STDERR`. Thus, warnings are less problematic errors, usually since some default or fallback value can be used, instead. The warning message then informs about this decision. Only for deprecated arguments, no default is used, simply because the argparser does not use the information about deprecation other than for creating a message to your script's user. After all, a deprecated argument should still be fully functional, until the deprecation time has passed and you decide to fully remove the argument (or replace it by a dummy implementation&mdash;then without deprecation note&mdash;whose application raises an error within your script).

Using [`ARGPARSER_SILENCE_ERRORS`](#5542-argparser_silence_errors) and [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings), it is possible to prevent the emission of error or warning messages. Still, in case of critical errors, the argparser exits, just not informing you or your user about its failure. Silencing errors may not be needed at all, except when you want to keep log files clean, but silencing warnings may improve the user experience.

### 3.10. Message styles

It is possible to customize the appearance of error, warning, help, usage, and version messages using the respective environment variable, *viz.*, [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style). Using [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters"), messages can be colorized and stylized. This is especially useful to quickly see errors when logging, but requires that the terminal or text editor, with which you opened the log file, supports interpreting the escape codes. This is, *e.g.*, supported by [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"). Further, when [`ARGPARSER_USE_STYLES_IN_FILES`](#5558-argparser_use_styles_in_files) is set to `false` (the default), the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, not a file.

The following colors and styles are available (with the actual appearance depending on the output device):

| Colors                                  | Styles        |
|-----------------------------------------|---------------|
| $\small\textsf{\color{black}black}$     | `normal`      |
| $\small\textsf{\color{red}red}$         | `bold`        |
| $\small\textsf{\color{green}green}$     | `faint`       |
| $\small\textsf{\color{orange}yellow}$   | `italic`      |
| $\small\textsf{\color{blue}blue}$       | `underline`   |
| $\small\textsf{\color{magenta}magenta}$ | `double`      |
| $\small\textsf{\color{cyan}cyan}$       | `overline`    |
| $\small\textsf{\color{lightgray}white}$ | `crossed-out` |
|                                         | `blink`       |
|                                         | `reverse`     |

Colors overwrite each other, whereas styles may be combined, like `"red,bold,reverse"` as default value for `ARGPARSER_ERROR_STYLE`. Styles may be given in any order; for colors, the last one is effectively visible. Still, the escape codes are concatenated in their order of definition in the style setting.

### 3.11. Standalone usage

Although the usual way to run the argparser is sourcing, you can also invoke it directly. By this, you can obtain the help, usage, and version message for the argparser itself, *e.g.* when you're looking for a certain option name, but don't want to or can't consult the manual. The invokation is identical to your script's:

```console
$ argparser --help
Usage: argparser [OPTIONS] [--] command_line

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
command_line                     the indexed array in which the argparser
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
[--arg-def-file-has-header]      whether the arguments definition file has a
                                 header explaining the columns (default: true)
[--arg-def-has-header]           whether the arguments definition in the script
                                 has a header explaining the columns (default:
                                 true)
[--arg-delimiter-1=CHAR]         the primary delimiter that separates the
                                 fields in the arguments definition (default:
                                 "|")
[--arg-delimiter-2=CHAR]         the secondary delimiter that separates the
                                 elements of sequences in the arguments
                                 definition (default: ",")
[--check-arg-def]                check if the arguments definition is
                                 consistent (default: false)
[--check-env-vars]               check if the argparser environment variables
                                 accord to their definition (default: false)
[--config-file=FILE]             the path to a file holding the argparser
                                 configuration (default: "''")
[--count-flags]                  count flags instead of setting them to true or
                                 false based on the last prefix used on the
                                 command line (default: false)
[--error-exit-code=INT]          the exit code when errors occurred upon
                                 parsing (default: 1)
[--error-style=STYLE]            the color and style specification for error
                                 messages (default: "red,bold,reverse")
[--help-arg-group=NAME]          the name of the argument group holding all
                                 help options, i.e., --help, --usage, and
                                 --version (default: "Help options")
[--help-exit-code=INT]           the exit code for help messages (default: 0)
[--help-file=FILE]               the path to a file holding the extended help
                                 message (default: "''")
[--help-file-include-char=CHAR]  the character that introduces an include
                                 directive in an ARGPARSER_HELP_FILE (default:
                                 "@")
[--help-file-keep-comments]      keep commented lines in the help file
                                 (default: false)
[--help-options=CHAR]            the short (single-character) option names to
                                 invoke the help message (default: "h,?")
[--help-style=STYLE]             the color and style specification for help
                                 messages (default: "italic")
[--language=LANG]                the language in which to localize the help and
                                 usage messages (default: "en")
[--max-col-width-1=INT]          the maximum column width of the first column
                                 in the help message (default: 5)
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
[--translation-file=FILE]        the path to a simplified YAML file holding the
                                 translation to ARGPARSER_LANGUAGE (default:
                                 "''")
[--unset-args]                   unset (remove) all command-line arguments
                                 given to the script (default: true)
[--unset-env-vars]               unset (remove) the argparser environment
                                 variables from the environment (default: true)
[--unset-functions]              unset (remove) the argparser functions from
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
[--usage-options=CHAR]           the short (single-character) option names to
                                 invoke the usage message (default: "u")
[--usage-style=STYLE]            the color and style specification for usage
                                 messages (default: "italic")
[--use-long-options]             use the long option names for parsing
                                 (default: true)
[--use-short-options]            use the short option names for parsing
                                 (default: true)
[--use-styles-in-files]          use the colors and styles when STDOUT/STDERR
                                 is not a terminal (default: false)
[--version=VERSION]              the script's version number for the version
                                 message (default: "1.0.0")
[--version-exit-code=INT]        the exit code for version messages (default:
                                 0)
[--version-options=CHAR]         the short (single-character) option names to
                                 invoke the version message (default: "V")
[--version-style=STYLE]          the color and style specification for version
                                 messages (default: "bold")
[--warning-style=STYLE]          the color and style specification for warning
                                 messages (default: "red,bold")
[--write-args]                   write the arguments from
                                 ARGPARSER_ARG_ARRAY_NAME to STDOUT (default:
                                 false)

[--help]                         display this help and exit (default: false)
[--usage]                        display the usage and exit (default: false)
[--version]                      display the version and exit (default: false)
```

The second, and perhaps more important way of standalone usage is included for compatibility with other shells. Since only Bash can successfully source Bash scripts (at least, when they rely on Bashisms, which is the case for the argparser), the argparser would only be usable from within Bash scripts. While this remains the central point of application, there is also a way to run the argparser from other shell's scripts. As an example, let's have a look at the `try_pipeline.sh` script:

<details open>

<summary>Contents of <code>try_pipeline.sh</code></summary>

```sh
#!/bin/sh

# Run the argparser in standalone mode from POSIX sh, reading from and
# writing to a pipe.
export ARGPARSER_SCRIPT_NAME="${0##*/}"
export ARGPARSER_WRITE_ARGS=true

# Define the arguments.
args='
    id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help
    pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice
    pos_2 |            |           | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice
    var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice
    var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice
    var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice
    var_4 | d          |           | VAL_4     | A        | A,B,C   | char | 1      | Optional options     |            | one value with default and choice
    var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default
    var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default
    var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default
'

if [ "$1" = "--help" ] \
    || [ "$1" = "-h" ] \
    || [ "$1" = "--usage" ] \
    || [ "$1" = "-u" ] \
    || [ "$1" = "--version" ] \
    || [ "$1" = "-V" ]
then
    printf '%s' "${args}" | argparser -- "$@"
else
    eval "$(printf '%s' "${args}" | argparser -- "$@" | tee /dev/stderr)"
fi

# The arguments can now be accessed as variables from the environment.
# In case of errors, eval hasn't been able to set them, thus the tested
# expansion ${var_1+set} will be empty, so nothing would get printed.
if [ -n "${var_1+set}" ]; then
    printf 'The keyword argument "var_1" is set to "%s".\n' "${var_1}"
    printf 'The keyword argument "var_2" is set to "%s".\n' "${var_2}"
    printf 'The keyword argument "var_3" is set to "%s".\n' "${var_3}"
    printf 'The keyword argument "var_4" is set to "%s".\n' "${var_4}"
    printf 'The keyword argument "var_5" is set to "%s".\n' "${var_5}"
    printf 'The keyword argument "var_6" is set to "%s".\n' "${var_6}"
    printf 'The keyword argument "var_7" is set to "%s".\n' "${var_7}"

    printf 'The positional argument "pos_1" on index 1 is set to "%s".\n' \
        "${pos_1}"
    printf 'The positional argument "pos_2" on index 2 is set to "%s".\n' \
        "${pos_2}"
fi | sort
```

As you can see, the script is written POSIX conformantly and by this already executable by `sh` or `dash`. Since POSIX doesn't specify useful programming constructs like arrays, the arguments definition must be a single string, delimited by linefeeds. By passing this string to the argparser via its STDIN stream (piping from `printf` to `argparser`), it is possible to feed the arguments definition to the argparser without requiring the usual [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name). Just as when sourcing, the argparser requires your script's command line as argument, separated from its own arguments by a double hyphen.

It is important to set [`ARGPARSER_WRITE_ARGS`](#5564-argparser_write_args) to `true`. By this, the argparser will write the parsed arguments as key&ndash;value pairs to its STDOUT stream, since setting them as variables to the environment would result in them being lost when the child process the argparser is running in terminates.

In our example script, the whole pipeline is run in a subshell, such that STDOUT gets captured by `eval`. This facilitates the setting of the variables to the main environment, as the argparser outputs one argument per line, with an `=` sign as delimiter between key and value. In other terms, the argparser produces output which may be re-used as input to `eval`&mdash;here assuming that no special shell characters are included. For the purpose of this example, calls for the help, usage, and version message are caught in a separate branch to circumvent the parsing by `eval`&mdash;after all, these messages are also written to STDOUT, while the usual error and warning messages end in STDERR. Depending on your shell, you may find more sophisticated solutions.

Another point to notice is the need to set the [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name) prior running the argparser, since from within its child process, it cannot access your script's name without requiring non-builtin commands like [`ps`](https://man7.org/linux/man-pages/man1/ps.1.html "man7.org &rightarrow; man pages &rightarrow; ps(1)").

In short, it is possible to run the argparser in standalone mode from other shells, but this comes with the caveats of subprocesses&mdash;which the sourcing in Bash overcomes. Still, the only feature that your shell must support, is calling processes in pipes or *via* process substitutions to pass data to the argparser's STDIN and read its STDOUT. Since pipes are defined by POSIX, most shells should support this feature.

</details>

## 4. Comparison of command-line parsers

Several other shell command-line parsers predate the argparser and were in part influential in its design choices. The table below aims at comparing their features or lack thereof, intended to be as comprehensive as possible. If you're missing a function, please open an issue, such that the function can be added. Manual argument parsing, the easiest (just most complex) method, is excluded here since in theory anything could be done, therein&mdash;it would just require a proportionate amount of work.

The [feature comparison](#41-feature-comparison) compares the various features for argument parsing, while some [example scripts](#42-example-scripts) later demonstrate the usage for the different parsers.

<!-- <toc title="Table of contents (Feature comparison)"> -->
### Table of contents (Feature comparison)

1. [Feature comparison](#41-feature-comparison)
1. [Example scripts](#42-example-scripts)
   1. [`getopts`](#421-getopts)
   1. [`getopt`](#422-getopt)
   1. [shFlags](#423-shflags)
   1. [docopt](#424-docopt)
   1. [argparser](#425-argparser)
<!-- </toc> -->

### 4.1. Feature comparison

The following command-line parsers are compared in the given versions:

- [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts"): Bash-builtin, POSIX-compliant command-line parser, from Bash `v5.2`
- [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"): legacy command-line parser with GNU extensions, from `util-linux v2.39.3`
- [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags"): clone of Google's C++ [`gflags`](https://gflags.github.io/gflags/ "github.io &rightarrow; gflags") library for Unix-like shells, `v1.3.0`
- [docopt](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts"): platform-independent command-line interface description language and parser, `v0.6.4`
- [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module"): Python module from the stdlib, from Python `v3.13`
- argparser: novel shell command-line parser, `v0.1.0`

In the following table, "&#10008;" marks the absence of a feature, "&#10004;" its presence, and "&#10033;" its partial presence, *e.g.*, due to a not-yet complete implementation.

| Function                                    | `getopts`    | `getopt`      | shFlags      | docopt   | `argparse`    | argparser    |
|---------------------------------------------|--------------|---------------|--------------|----------|---------------|--------------|
| Short options                               | &#10004;     | &#10004;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Long options                                | &#10008;     | &#10004;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Positional arguments                        | &#10033;[^1] | &#10033;[^1]  | &#10008;[^1] | &#10008; | &#10004;      | &#10004;     |
| Mandatory options                           | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Flags (Boolean options)                     | &#10004;     | &#10004;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Mutually exclusive arguments                | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10008;[^2] |
| Intermixed positional and keyword arguments | &#10008;     | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10008;[^3] |
| Argument groups                             | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Positional arguments delimiter `--`         | &#10004;     | &#10004;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Positional arguments delimiter `++`         | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10008;      | &#10004;     |
| Single-hyphen long options                  | &#10008;[^4] | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10008;[^3] |
| Alternative option characters (`+`/`/`)     | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10008;[^3] |
| Default values                              | &#10008;     | &#10008;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Choice values                               | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Any argument number (multi-value arguments) | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10033;[^2] |
| Metavariables (value names)                 | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Data type checking                          | &#10008;     | &#10008;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Deprecation note                            | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Option merging                              | &#10004;     | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Option abbreviation                         | &#10008;[^4] | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Flag counting                               | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Flag negation (`no-var`)                    | &#10008;[^4] | &#10008;      | &#10004;     | &#10008; | &#10008;      | &#10004;     |
| Flag inversion (`+a`)                       | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10008;      | &#10004;     |
| Inheritable arguments definition            | &#10004;[^5] | &#10004;[^5]  | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Arguments definition files                  | &#10004;[^5] | &#10004;[^5]  | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Arguments auto-set to variables             | &#10008;     | &#10008;      | &#10004;     | &#10008; | &#10008;      | &#10004;     |
| Error/warning silencing                     | &#10004;     | &#10004;      | &#10008;     | &#10008; | &#10008;      | &#10004;     |
| Help message                                | &#10008;     | &#10008;      | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Usage message                               | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Version message                             | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Stylized messages                           | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10008;      | &#10004;     |
| Customizable message text                   | &#10033;[^6] | &#10033;[^6]  | &#10004;     | &#10008; | &#10004;      | &#10004;     |
| Customizable help options                   | &#10033;[^7] | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Customizable exit codes                     | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10033;[^8]  | &#10004;     |
| Configurable parsing                        | &#10008;     | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Internationalization / localization         | &#10004;     | &#10004;      | &#10008;     | &#10008; | &#10004;      | &#10004;     |
| Debug mode                                  | &#10008;     | &#10008;      | &#10008;     | &#10008; | &#10008;      | &#10008;[^2] |
| Shell independence (Bash, Dash, ksh93...)   | &#10004;[^9] | &#10004;      | &#10004;     | &#10008; | &#10008;[^10] | &#10004;     |
| POSIX compliance                            | &#10004;     | &#10033;[^11] | &#10008;     | &#10008; | &#10008;      | &#10008;[^3] |

[^1]: Not rejected, but not parsed and only usable by manual parsing.
[^2]: Not (entirely) supported, but to be implemented in a future version.
[^3]: By design decision, might still be implemented in a future version.
[^4]: Not applicable for lack of long options.
[^5]: As (possibly exported) variable.
[^6]: Not builtin, only due to need to write messages manually.
[^7]: Except the common `?`.
[^8]: Not upon errors, with an exit code of `2`.
[^9]: Regarding its application in scripts, would need equivalent builtins in other shells.
[^10]: Not applicable as not designed for usage from within shells.
[^11]: Opt-in feature *via* environment variable (`POSIXLY_CORRECT`).

### 4.2. Example scripts

#### 4.2.1. `getopts`

<details open>

<summary>Contents of <code>getopts_wrapper.sh</code></summary>

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
source process_html_template.sh
```

</details>

Example calls:

```bash
# Short options.
bash getopts_wrapper.sh -v -n 'A. R. G. Parser' -a 2 -r b template.html argparser.html

# Merged short options.
bash getopts_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash getopts_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb -- template.html argparser.html

# Help, usage, and version messages.
bash getopts_wrapper.sh -h
bash getopts_wrapper.sh -u
bash getopts_wrapper.sh -V
```

Notes:

- Long options aren't supported, so no attempt is made to still parse them.
- The question mark `?` is used as sign for an invalid option name on the command line, thus preventing its use for invoking the help message.

#### 4.2.2. `getopt`

<details open>

<summary>Contents of <code>getopt_wrapper.sh</code></summary>

```bash
#!/bin/bash

function help() {
    # Define the help message.
    cat << EOF | sed 's/^    //'
    Usage: $0 [OPTIONS] ARGUMENTS source destination

    Mandatory arguments to long options are mandatory for short options too.

    Positional arguments:
    source                   the template HTML file to fill in
    destination              the output HTML file

    Mandatory options:
    -a,       --age=AGE      the current age of the homepage's owner
    -n,       --name=NAME    the name of the homepage's owner
    -r,       --role={u,m,b} the role of the homepage's owner (u: user, m:
                             moderator, b: bot)

    Optional options:
    [-v],     [--verbose]    output verbose information

    [-h, -?], [--help]       display this help and exit
    [-u],     [--usage]      display the usage and exit
    [-V],     [--version]    display the version and exit
EOF
}

function usage() {
    # Define the usage message.
    local usage
    usage="Usage: $0 [-h,-? | -u | -V] [-v] -a=AGE -n=NAME -r={u,m,b} source "
    usage+="destination"
    printf '%s\n' "${usage}"
}

# Parse the arguments.
if ! args="$(getopt --options="n:a:r:vh?uV" \
    --longoptions="name:,age:,role:,verbose,help,usage,version" -- "$@")"
then
    exit 1
fi
eval set -- "${args}"

verbose=false
while true; do
    case "$1" in
        -n|--name)
            name="$2"
            shift 2
            ;;
        -a|--age)
            age="$2"
            shift 2
            ;;
        -r|--role)
            role="$2"
            shift 2
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -h|--help)
            help
            exit
            ;;
        -u|--usage)
            usage
            exit
            ;;
        -V|--version)
            printf '%s v1.0.0\n' "$0"
            exit
            ;;
        --)
            shift
            break
            ;;
        *)
            usage >&2
            exit 1
            ;;
    esac
done

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
    printf '%s: Error: The option -n,--name is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
fi

if [[ -z "${age}" ]]; then
    printf '%s: Error: The option -a,--age is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
elif [[ "${age}" != ?([+-])+([[:digit:]]) ]]; then
    printf '%s: Error: The option -a,--age must be an integer.\n' "$0"
    usage >&2
    exit 1
fi

if [[ -z "${role}" ]]; then
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
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
    *)
        printf '%s: Error: The option -r,--role must be in {u, m, b}.\n' "$0"
        usage >&2
        exit 1
        ;;
esac

# Set the positional arguments to variables.
in_file="$1"
out_file="$2"

# Run the HTML processor.
source process_html_template.sh
```

</details>

Example calls:

```bash
# Long options.
bash getopt_wrapper.sh --verbose --name='A. R. G. Parser' --age=2 --role=b template.html argparser.html

# Short options.
bash getopt_wrapper.sh -v -n 'A. R. G. Parser' -a 2 -r b template.html argparser.html

# Merged short options.
bash getopt_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash getopt_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb -- template.html argparser.html

# Leading positional arguments.
bash getopt_wrapper.sh template.html argparser.html -vn 'A. R. G. Parser' -a2 -rb

# Intermixed positional arguments.
bash getopt_wrapper.sh -vn 'A. R. G. Parser' template.html -a2 argparser.html -rb

# Help, usage, and version messages.
bash getopt_wrapper.sh --help
bash getopt_wrapper.sh --usage
bash getopt_wrapper.sh --version
```

Notes:

- Using whitespace between options with optional arguments (*i.e.*, an argument number of zero or higher) and their values is disallowed.

#### 4.2.3. shFlags

<details open>

<summary>Contents of <code>shflags_wrapper.sh</code></summary>

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
FLAGS_HELP="$(cat << EOF | sed 's/^    //'
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

DEFINE_string "name" "${USER}" "the name of the homepage's owner" "n"
DEFINE_integer "age" "0" "the current age of the homepage's owner" "a"
DEFINE_string "role" "u" "the role of the homepage's owner (u: user, m: moderator, b: bot)" "r"
DEFINE_boolean "verbose" false "output verbose information" "v"
DEFINE_boolean "usage" false "display the usage and exit" "u"
DEFINE_boolean "version" false "display the version and exit" "V"

if ! FLAGS "$@"; then
    exit "$?"
fi
eval set -- "${FLAGS_ARGV}"

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

if [[ -z "${FLAGS_name}" ]]; then
    printf '%s: Error: The option -n,--name is mandatory, but not given.\n' \
        "$0"
    usage >&2
    exit 1
fi
name="${FLAGS_name}"

if [[ -z "${FLAGS_age}" ]]; then
    printf '%s: Error: The option -a,--age is mandatory, but not given.\n' "$0"
    usage >&2
    exit 1
fi
age="${FLAGS_age}"

if [[ -z "${FLAGS_role}" ]]; then
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
source process_html_template.sh
```

</details>

Example calls:

```bash
# Long options.
bash shflags_wrapper.sh --verbose --name='A. R. G. Parser' --age=2 --role=b template.html argparser.html

# Short options.
bash shflags_wrapper.sh -v -n 'A. R. G. Parser' -a 2 -r b template.html argparser.html

# Merged short options.
bash shflags_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb template.html argparser.html

# Positional arguments delimiter "--".
bash shflags_wrapper.sh -vn 'A. R. G. Parser' -a2 -rb -- template.html argparser.html

# Leading positional arguments.
bash shflags_wrapper.sh template.html argparser.html -vn 'A. R. G. Parser' -a2 -rb

# Intermixed positional arguments.
bash shflags_wrapper.sh -vn 'A. R. G. Parser' template.html -a2 argparser.html -rb

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

#### 4.2.4. docopt

#### 4.2.5. argparser

<details open>

<summary>Contents of <code>argparser_wrapper.sh</code></summary>

```bash
#!/bin/bash

# Parse the arguments.
args=(
    "id       | short_opts | long_opts | val_names   | defaults | choices | type | arg_no | arg_group            | notes | help                                                            "
    "in_file  |            |           | source      |          |         | file | 1      | Positional arguments |       | the template HTML file to fill in                               "
    "out_file |            |           | destination |          |         | file | 1      | Positional arguments |       | the output HTML file                                            "
    "name     | n          | name      | NAME        |          |         | str  | 1      | Mandatory options    |       | the name of the homepage's owner                                "
    "age      | a          | age       | AGE         |          |         | uint | 1      | Mandatory options    |       | the current age of the homepage's owner                         "
    "role     | r          | role      | ROLE        |          | u,m,b   | char | 1      | Mandatory options    |       | the role of the homepage's owner (u: user, m: moderator, b: bot)"
    "verbose  | v          | verbose   |             | false    |         | bool | 0      | Optional options     |       | output verbose information                                      "
)
source argparser -- "$@"

# Set the role to its long form.
case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
esac

# Run the HTML processor.
source process_html_template.sh
```

</details>

Example calls:

```bash
# Long options.
bash argparser_wrapper.sh --verbose --name='A. R. G. Parser' --age=2 --role=b -- template.html argparser.html

# Short options.
bash argparser_wrapper.sh -v -n 'A. R. G. Parser' -a 2 -r b -- template.html argparser.html

# Leading positional arguments.
bash argparser_wrapper.sh template.html argparser.html -v -n 'A. R. G. Parser' -a 2 -r b

# Positional arguments delimiter "++".
bash argparser_wrapper.sh -v -n 'A. R. G. Parser' -- template.html argparser.html ++ -a 2 -r b

# Help, usage, and version messages.
bash argparser_wrapper.sh --help
bash argparser_wrapper.sh --usage
bash argparser_wrapper.sh --version
```

Notes:

- Trailing positional arguments must be delimited with `--` since the argparser aggregates all values after option names to them, as design decision.
- Intermixing positional and keyword arguments can be emulated by using the positional arguments delimiter `++`. True intermixing is yet disabled as design decision.

## 5. Reference

The reference details the actual definitions of all [colors and styles](#52-colors-and-styles), [include directives](#53-include-directives), and [environment variables](#55-environment-variables). While it may be advantageous to read it once in its entirety to see all features not discussed in the [tutorial](#3-tutorial), it is more designed as manual for specific questions regarding certain features.

### 5.1. Arguments definition

The arguments definition that the argparser uses to parse the arguments and to create the help and usage messages shows a tabular structure with eleven columns. These columns are delimited by an [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1) character each, by default a pipe (`"|"`). Since fields can be surrounded by an arbitrary number of spaces, visual alignment as true table is possible. Optionally, a header can be given, indicated by setting [`ARGPARSER_ARG_DEF_HAS_HEADER`](#5512-argparser_arg_def_has_header) and/or [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header) to `true`, using the identifiers shown below. Then, the order of the columns is arbitrary, but there should be little reason to deviate from the defult order. The values in multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) character, by default a comma (`","`). Absence of value is indicated by the empty string, resulting after trimming spaces. That is, a field consisting of only spaces means absence.

#### 5.1.1. Argument ID (`id`)

The argument identifier must be a valid variable identifier in Bash syntax (at least when [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args) is set to `true`, else, the ID is only used as key in associative arrays). These are defined as a word beginning with an alphabetic character or an underscore, followed by an arbitrary number of alphanumeric characters or underscores. In Bash's extglob syntax, the regular expression for verification may look like `[[:alpha:]_]*([[:word:]])`, assuming C locale.

#### 5.1.2. Short option names (`short_opts`)

The short option names must comprise exactly one character, thereby, no leading hyphen may be given. Multiple short option names that shall be treated as aliases for the same option must be separated by an [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) character. Bash is case-sensitive, so is the checking for option names. Thus, you would need to provide both `a` and `A` as short option names if you want both to be recognized. This distinction effectively allows doubling the number of available short option names defined as letters (`a-z` and `A-Z`).

#### 5.1.3. Long option names (`long_opts`)

The long option names must comprise more than one character, thereby, no leading hyphen may be given. Multiple long option names that shall be treated as aliases for the same option must be separated by an [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) character.

#### 5.1.4. Value names (`val_names`)

The value names are used as substitute for the uppercased option names in help messages for non-flag options, *i.e.*, those requiring at least one argument. Setting a value name may render the help message clearer or more concise, like when having an option `--in-file` whose argument just needs to be shown as `FILE`. If no value name is given, or less than there are short or long option names, the remaining argument texts are filled with the respective option name in "screaming-snake-cased" (uppercased with underscores instead of hyphens) form. For positional arguments, the value name is the only name that can be shown, thus, it is required in this case.

#### 5.1.5. Default values (`defaults`)

Positional and keyword arguments may have default values, which are assigned to the variables if the arguments aren't given on the command line. For flags, the default value must be either `true` or `false`.

#### 5.1.6. Choice values (`choices`)

It is possible to restrict the range of acceptable values for an argument to a set indicated by the choice values. If [default values](#515-default-values-defaults) are given, they must lie within the choice values.

#### 5.1.7. Data type (`type`)

The argparser defines several data types an argument may have. Using the regular expressions denoted below, the argument's value is compared to the data type. Still, Bash is weakly typed, and by this, the existence of a data type does not change the behavior of the variable. Nonetheless, you can use the type-checked value for certain computations, later on. It is mandatory that all default and choice values accord to the data type. The following data types are distinguished by the argparser:

- *bool* (Boolean): either `true` or `false`, to be used for flags
- *char* (Character): a string with length one
- *float* (Floating-point number): digits, possibly with a period in-between, optionally with a leading hyphen as minus sign
- *file* (Filepath): a filepath, currently unchecked
- *int* (Integer): digits without period in-between, optionally with a leading hyphen as minus sign
- *str* (String): anything not fitting into the other data types, unchecked
- *uint* (Unsigned integer): digits with neither a period in-between nor a leading hyphen as minus sign

#### 5.1.8. Argument count (`arg_no`)

The argument count defines the number of values a keyword or positional argument may accept. Independent of this count, the argparser will aggregate any non-hyphenated value to the previous keyword argument, or, if none is yet given, set it to the positional arguments. The argument count may be given as natural number (*i.e.*, as unsigned integer), including `0` as sign for flags, or as plus sign (`+`). The latter means to accept as many values as given, at least one.

The Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module further defines `*` to accept any argument count, and `?` to accept exactly zero or one argument. Both features aren't yet supported by the argparser, but the characters are reserved for future usage as such, invalidating them as values for [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2).

#### 5.1.9. Argument group (`arg_group`)

The argument groups serve to group arguments in the help message. The first group shall comprise all positional arguments (if any is defined) and is named by [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group). Any other argument group shall only contain keyword arguments (options), and is sorted alphabetically in the help message. In the future, argument groups will be expanded to allow actual grouping of arguments upon parsing, such that options may only be given together or mutually exclusively.

#### 5.1.10. Notes (`notes`)

The notes are intended to give additional information about arguments that don't warrant the introduction of a new column in the arguments definition. This is usually true for notes that are rarely used, where thus the column's fields would be mostly empty. Currently, only `"deprecated"` is supported, but this is expected to change. This token advises the argparser to treat an argument as deprecated, emitting a warning, when it is given on the command line. Since command-line interfaces are prone to change over time, this warning allows you to gradually change your CLI, introducing replacement option names or even removing the functionality prior to removing the argument itself. By this, your script's users can slowly adapt to the new CLI.

#### 5.1.11. Help text (`help`)

The help text should consist of a terse summary of the argument's function, like turning a feature on or off (which may be accomplished by flags), what a file is used for (like for input or output), or how your script's output may be modified. A help text can take any form, but be wary of it being wrapped to fit the width of the third column in the help message (if [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3) is non-zero) or the total line length ([`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width)). Help messages are no replacement for the manual, so the help text shouldn't be overly verbose.

### 5.2. Colors and styles

The argparser employs [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters") to set the appearance of error, warning, help, usage, and version messages. To this end, five environment variable are defined, *viz.*, [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style). Since the escape codes are nonprintable, not any terminal or text editor may support them. Many terminals do, while *e.g.* [`less`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)") has a dedicated flag, `--raw-control-chars`.

When [`ARGPARSER_USE_STYLES_IN_FILES`](#5558-argparser_use_styles_in_files) is set to `false`, the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, keeping files plain 7-bit ASCII for simpler parsing. Note that, when your arguments definition or help file includes non-ASCII characters (as is usual for almost any language other than English varieties), the output contains these characters as well.

A number of colors and styles is available. You don't need to remember the SGR codes, they're only internally used and given here for reference of what to expect from the keywords for the colors and styles. Further note that the actual RGB/Hex color values will depend on the output device.

| Color                                   | SGR code |
|-----------------------------------------|----------|
| $\small\textsf{\color{black}black}$     | `30`     |
| $\small\textsf{\color{red}red}$         | `31`     |
| $\small\textsf{\color{green}green}$     | `32`     |
| $\small\textsf{\color{orange}yellow}$   | `33`     |
| $\small\textsf{\color{blue}blue}$       | `34`     |
| $\small\textsf{\color{magenta}magenta}$ | `35`     |
| $\small\textsf{\color{cyan}cyan}$       | `36`     |
| $\small\textsf{\color{lightgray}white}$ | `37`     |

| Style         | SGR code |
|---------------|----------|
| `normal`      | `22`     |
| `bold`        | `1`      |
| `faint`       | `2`      |
| `italic`      | `3`      |
| `underline`   | `4`      |
| `double`      | `21`     |
| `overline`    | `53`     |
| `crossed-out` | `9`      |
| `blink`       | `5`      |
| `reverse`     | `7`      |

While colors overwrite each other, some styles can be combined. For instance, the default value for `ARGPARSER_ERROR_STYLE` is `"red,bold,reverse"`, meaning to colorize the message in red and to format it in bold font, using reverse video. Other useful combinations may include `"faint"` and `"italic"` or `"bold"` and `"underline"`. The order of giving the colors and styles in the environment variables' values does only matter if multiple colors are given, when the last one "wins". Else, the colors and styles are simply composed (concatenated).

### 5.3. Include directives

Six section names (include directives) are supported in the help and usage files. These are introduced with the [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#5527-argparser_help_file_include_char) or [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#5550-argparser_usage_file_include_char), respectively, defaulting to `"@"`.

<!-- <toc title="Table of contents (Include directives)"> -->
#### Table of contents (Include directives)

1. [`@All` directive](#531-all-directive)
1. [`@<ArgumentGroup>` directive](#532-argumentgroup-directive)
1. [`@Header` directive](#533-header-directive)
1. [`@Remark` directive](#534-remark-directive)
1. [`@Usage` directive](#535-usage-directive)
1. [`@Help` directive](#536-help-directive)
<!-- </toc> -->

#### 5.3.1. `@All` directive

The `@All` directive comprises all include directives in the following order: [`@Usage`](#535-usage-directive), [`@Remark`](#534-remark-directive), [`@<ArgumentGroup>`](#532-argumentgroup-directive), and [`@Help`](#536-help-directive), separated from each other by a blank line.

Consequently, the help message generated from the [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file) with the following content:

```text
@All
```

is exactly identical to the one from the following content:

```text
@Usage

@Remark

@<ArgumentGroup>

@Help
```

(note the blank lines), and indentical to the auto-generated help message.

#### 5.3.2. `@<ArgumentGroup>` directive

The `@<ArgumentGroup>` directive prints the help text for the respective `"<ArgumentGroup>"`, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. Their order in the auto-generated help message would be alphabetical for the keyword arguments, preceded by the group for the positional arguments (the [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group)). Thus, if you have reasons for another structure, you need an [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file), denoting all arguments groups in the order preferred by you.

#### 5.3.3. `@Header` directive

The `@Header` directive comprises the [`@Usage`](#535-usage-directive) and [`@Remark`](#534-remark-directive) include directive, separated from each other by a blank line, and is thus the shorthand for including both.

#### 5.3.4. `@Remark` directive

The `@Remark` directive prints the note that mandatory arguments to long options are mandatory for short options too. This should be given just before all arguments.

#### 5.3.5. `@Usage` directive

The `@Usage` directive prints the line `Usage: <script_name> ...`, with `<script_name>` replaced by [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name), defaulting to your script's name. This should be given as first line.

#### 5.3.6. `@Help` directive

The `@Help` directive prints the help text for the `--help`, `--usage`, and `--version` flags (if added to the arguments definition by [`ARGPARSER_ADD_HELP`](#552-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version)). Usually, you want to give this at the very end of all options.

### 5.4. Translations

In order to facilitate translators the translation of the argparser-generated strings, most importantly the error and warning messages, and including the interpolated variables, they are listed here for reference, sorted by their occurence in the provided [translation.yaml](resources/translation.yaml). Further, this should give an overview over the most likely reasons for argument parsing failures.

> [!NOTE]
> The translation keys in the simplified YAML file are subject to change, if messages are added or removed. Since missing keys only generate warnings (which can even be silenced using [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings)), such changes are *not* considered breaking changes, and by this would *not* lead to an increase in the argparser's major version number. However, as few modifications as possible are anticipated, and only when other breaking changes are introduced, larger refactorings should occur.

<!-- <toc title="Table of contents (Translations)"> -->
#### Table of contents (Translations)

1. [`Positional arguments`](#541-positional-arguments)
1. [`Help options`](#542-help-options)
1. [`Error`](#543-error)
1. [`Warning`](#544-warning)
1. [`Usage`](#545-usage)
1. [`Arguments`](#546-arguments)
1. [`Options`](#547-options)
1. [`Mandatory arguments`](#548-mandatory-arguments)
1. [`Deprecated`](#549-deprecated)
1. [`Default`](#5410-default)
1. [`--help`](#5411---help)
1. [`--usage`](#5412---usage)
1. [`--version`](#5413---version)
1. [`false`](#5414-false)
1. [`true`](#5415-true)
1. [`Error env var bool`](#5416-error-env-var-bool)
1. [`Error env var char`](#5417-error-env-var-char)
1. [`Error env var identifier`](#5418-error-env-var-identifier)
1. [`Error env var int`](#5419-error-env-var-int)
1. [`Error env var uint`](#5420-error-env-var-uint)
1. [`Error env var file 0001`](#5421-error-env-var-file-0001)
1. [`Error env var file 0010`](#5422-error-env-var-file-0010)
1. [`Error env var file 0011`](#5423-error-env-var-file-0011)
1. [`Error env var file 0100`](#5424-error-env-var-file-0100)
1. [`Error env var file 0101`](#5425-error-env-var-file-0101)
1. [`Error env var file 0110`](#5426-error-env-var-file-0110)
1. [`Error env var file 0111`](#5427-error-env-var-file-0111)
1. [`Error env var file 1111`](#5428-error-env-var-file-1111)
1. [`Error env var styles`](#5429-error-env-var-styles)
1. [`Error env var option type`](#5430-error-env-var-option-type)
1. [`Error env var orientation`](#5431-error-env-var-orientation)
1. [`Error env var delimiters`](#5432-error-env-var-delimiters)
1. [`Error env var short name empty`](#5433-error-env-var-short-name-empty)
1. [`Error env var short name length`](#5434-error-env-var-short-name-length)
1. [`Error env var short name inner duplication`](#5435-error-env-var-short-name-inner-duplication)
1. [`Error env var short name outer duplication`](#5436-error-env-var-short-name-outer-duplication)
1. [`Error env var short options`](#5437-error-env-var-short-options)
1. [`Error env var long options`](#5438-error-env-var-long-options)
1. [`Error env var files`](#5439-error-env-var-files)
1. [`Error arg array 1`](#5440-error-arg-array-1)
1. [`Error arg array 2`](#5441-error-arg-array-2)
1. [`Error arg array 3`](#5442-error-arg-array-3)
1. [`Error wrong arg def`](#5443-error-wrong-arg-def)
1. [`Error no arg def`](#5444-error-no-arg-def)
1. [`Error arg def field`](#5445-error-arg-def-field)
1. [`Error arg def file field`](#5446-error-arg-def-file-field)
<!-- </toc> -->

#### 5.4.1. `Positional arguments`

- ***Description:*** The name of the positional arguments' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group).

#### 5.4.2. `Help options`

- ***Description:*** The name of the help options' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_HELP_ARG_GROUP`](#5524-argparser_help_arg_group).

#### 5.4.3. `Error`

- ***Description:*** The word `"Error"` in error messages.

#### 5.4.4. `Warning`

- ***Description:*** The word `"Warning"` in warning messages.

#### 5.4.5. `Usage`

- ***Description:*** The word `"Usage"` in help and usage messages.

#### 5.4.6. `Arguments`

- ***Description:*** The word `"ARGUMENTS"` in help messages, to show the existence of mandatory options (those without a default value).

#### 5.4.7. `Options`

- ***Description:*** The word `"OPTIONS"` in help messages, to show the existence of optional options (those with a default value).

#### 5.4.8. `Mandatory arguments`

- ***Description:*** The remark that mandatory arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](#534-remark-directive) include directive.

#### 5.4.9. `Deprecated`

- ***Description:*** The word `"DEPRECATED"` in help messages, to show that an argument is deprecated and shouldn't be used, anymore.

#### 5.4.10. `Default`

- ***Description:*** The word `"default"` in help messages, to introduce the default values.

#### 5.4.11. `--help`

- ***Description:*** the help text for the help options, *i.e.*, the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options) and `--help`, if [`ARGPARSER_ADD_HELP`](#552-argparser_add_help) is set to `true`.

#### 5.4.12. `--usage`

- ***Description:*** the help text for the usage options, *i.e.*, the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options) and `--usage`, if [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage) is set to `true`.

#### 5.4.13. `--version`

- ***Description:*** the help text for the version options, *i.e.*, the [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options) and `--version`, if [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version) is set to `true`.

#### 5.4.14. `false`

- ***Description:*** The default value of `false` in help messages.

#### 5.4.15. `true`

- ***Description:*** The default value of `true` in help messages.

#### 5.4.16. `Error env var bool`

- ***Description:*** The error that an environment variable is not a boolean.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value other than `true` and `false`.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.17. `Error env var char`

- ***Description:*** The error that an environment variable is not a character.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value whose length differs from one.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.18. `Error env var identifier`

- ***Description:*** The error that an environment variable is not usable as a Bash variable identifier.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value not matched by the regular expression `[[:alpha:]_]*([[:word:]])` in Bash's extglob syntax.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.19. `Error env var int`

- ***Description:*** The error that an environment variable is not an integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value containing non-digit characters (excluding a leading sign).
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.20. `Error env var uint`

- ***Description:*** The error that an environment variable is not an unsigned integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value containing non-digit characters (including a leading sign).
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.21. `Error env var file 0001`

- ***Description:*** The error that an environment variable refers to an empty file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.22. `Error env var file 0010`

- ***Description:*** The error that an environment variable refers to a file which is not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.23. `Error env var file 0011`

- ***Description:*** The error that an environment variable refers to an empty file which is also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.24. `Error env var file 0100`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.25. `Error env var file 0101`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.26. `Error env var file 0110`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file and also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.27. `Error env var file 0111`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file and not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.28. `Error env var file 1111`

- ***Description:*** The error that an environment variable refers to a nonexistent file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.29. `Error env var styles`

- ***Description:*** The error that an environment variable refers to an undefined [color or style](#52-colors-and-styles).
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value intended to set a message color or style which does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 5.4.30. `Error env var option type`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5552-argparser_usage_message_option_type) is not set to `long` or `short`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value other than `long` and `short`.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 5.4.31. `Error env var orientation`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#5553-argparser_usage_message_orientation) is not set to `row` or `column`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_ORIENTATION`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value other than `row` and `column`.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 5.4.32. `Error env var delimiters`

- ***Description:*** The error that the environment variables [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2) have an identical value.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that the environment variables `ARGPARSER_ARG_DELIMITER_1` and `ARGPARSER_ARG_DELIMITER_2`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, have the same value, rendering parsing of the arguments definition impossible.

#### 5.4.33. `Error env var short name empty`

- ***Description:*** The error that an environment variable uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has the empty string (`""`) given as one of the short option names.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The number of short option names.

#### 5.4.34. `Error env var short name length`

- ***Description:*** The error that an environment variable has a too long short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a short option name given whose length is greater than one, which contradicts the definition of short options.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option's name.

#### 5.4.35. `Error env var short name inner duplication`

- ***Description:*** The error that an environment variable has a short option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a short option name given more than once in its own value.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option's name.
  - `$3`: The number of identical short option names.

#### 5.4.36. `Error env var short name outer duplication`

- ***Description:*** The error that two environment variables have the same short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a short option name that was already given to an earlier parsed environment variable.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The short option's name.
  - `$3`: The previous environment variable's name.

#### 5.4.37. `Error env var short options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5430-error-env-var-option-type) requests short option names, while [`ARGPARSER_USE_SHORT_OPTIONS`](#5557-argparser_use_short_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, is set to `short`, while `ARGPARSER_USE_SHORT_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no short option name is available.

#### 5.4.38. `Error env var long options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5430-error-env-var-option-type) requests long option names, while [`ARGPARSER_USE_LONG_OPTIONS`](#5556-argparser_use_long_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, is set to `long`, while `ARGPARSER_USE_LONG_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no long option name is available.

#### 5.4.39. `Error env var files`

- ***Description:*** The error that two environment variables refer to the same file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars) is set to `true`, the argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file), on the argparser invokation command line, or as an environment variable, has a value pointing to the same file as an earlier parsed environment variable. Since the files referred to by these environment variables have different meanings (like the argparser configuration and translation), it is impossible that both information is given in the same file.
- ***Interpolated variables:***
  - `$1`: The first environment variable's name.
  - `$2`: The second environment variable's name.

#### 5.4.40. `Error arg array 1`

- ***Description:*** The error that no arguments definition has been provided upon calling the argparser.
- ***Reasons for error:*** When calling (and not sourcing) the argparser, the arguments definition must be provided through STDIN, either by piping or by process substitution. However, STDIN (file descriptor 0) has been deemed empty.
- ***Interpolated variables:***
  - `$1`: The path to the argparser, as [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name).

#### 5.4.41. `Error arg array 2`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"` and reports the first match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.
  - `$2`: The guesstimated actual name of the variable.

#### 5.4.42. `Error arg array 3`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"`, but didn't find any match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.

#### 5.4.43. `Error wrong arg def`

- ***Description:*** The error that an argument has a malformed definition.
- ***Reasons for error:*** When reading the arguments definition, the argparser found a definition line giving either a wrong number of columns or only an argument name, with a likewise malformed definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 5.4.44. `Error no arg def`

- ***Description:*** The error that an argument is lacking a definition.
- ***Reasons for error:*** When reading the arguments definition, the argparser found a definition line giving only an argument name, but no definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 5.4.45. `Error arg def field`

- ***Description:*** The error that the arguments definition in the script lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the script, the argparser found the definition with as many columns as required, but the header sets a column name to a string not used by the argparser, leaving a column indentifier missing.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name) with the problematic definition.
  - `$2`: The missing column.

#### 5.4.46. `Error arg def file field`

- ***Description:*** The error that the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file) lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the argparser found the definition with as many columns as required, but the header sets a column name to a string not used by the argparser, leaving a column indentifier missing.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file) with the problematic definition.
  - `$2`: The missing column.

### 5.5. Environment variables

The argparser defines a large set of environment variables, each following the naming pattern `"ARGPARSER_*"`. They are used to control the behavior of the argument parsing, help and usage message generation, and much more. Note that, if for some reason your script or environment is using a variable with the same name as one of the argparser variables, the argparser might not work as expected. If you want to be 100&#8239;% safe, you can unset any variable following the given pattern prior setting any desired argparser variables and sourcing the argparser&mdash;with the caveat that in turn the program that set the variable might not work, anymore.

<!-- <toc title="Table of contents (Environment variables)"> -->
#### Table of contents (Environment variables)

1. [Overview](#551-overview)
1. [`ARGPARSER_ADD_HELP`](#552-argparser_add_help)
1. [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage)
1. [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version)
1. [`ARGPARSER_ALLOW_FLAG_INVERSION`](#555-argparser_allow_flag_inversion)
1. [`ARGPARSER_ALLOW_FLAG_NEGATION`](#556-argparser_allow_flag_negation)
1. [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#557-argparser_allow_option_abbreviation)
1. [`ARGPARSER_ALLOW_OPTION_MERGING`](#558-argparser_allow_option_merging)
1. [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name)
1. [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file)
1. [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header)
1. [`ARGPARSER_ARG_DEF_HAS_HEADER`](#5512-argparser_arg_def_has_header)
1. [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1)
1. [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)
1. [`ARGPARSER_ARGPARSER_VERSION`](#5515-argparser_argparser_version)
1. [`ARGPARSER_ARGS`](#5516-argparser_args)
1. [`ARGPARSER_CHECK_ARG_DEF`](#5517-argparser_check_arg_def)
1. [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars)
1. [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file)
1. [`ARGPARSER_COUNT_FLAGS`](#5520-argparser_count_flags)
1. [`ARGPARSER_DICTIONARY`](#5521-argparser_dictionary)
1. [`ARGPARSER_ERROR_EXIT_CODE`](#5522-argparser_error_exit_code)
1. [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style)
1. [`ARGPARSER_HELP_ARG_GROUP`](#5524-argparser_help_arg_group)
1. [`ARGPARSER_HELP_EXIT_CODE`](#5525-argparser_help_exit_code)
1. [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file)
1. [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#5527-argparser_help_file_include_char)
1. [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#5528-argparser_help_file_keep_comments)
1. [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options)
1. [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style)
1. [`ARGPARSER_LANGUAGE`](#5531-argparser_language)
1. [`ARGPARSER_MAX_COL_WIDTH_1`](#5532-argparser_max_col_width_1)
1. [`ARGPARSER_MAX_COL_WIDTH_2`](#5533-argparser_max_col_width_2)
1. [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3)
1. [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width)
1. [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group)
1. [`ARGPARSER_READ_ARGS`](#5537-argparser_read_args)
1. [`ARGPARSER_SCRIPT_ARGS`](#5538-argparser_script_args)
1. [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name)
1. [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args)
1. [`ARGPARSER_SET_ARRAYS`](#5541-argparser_set_arrays)
1. [`ARGPARSER_SILENCE_ERRORS`](#5542-argparser_silence_errors)
1. [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings)
1. [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file)
1. [`ARGPARSER_UNSET_ARGS`](#5545-argparser_unset_args)
1. [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars)
1. [`ARGPARSER_UNSET_FUNCTIONS`](#5547-argparser_unset_functions)
1. [`ARGPARSER_USAGE_EXIT_CODE`](#5548-argparser_usage_exit_code)
1. [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file)
1. [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#5550-argparser_usage_file_include_char)
1. [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#5551-argparser_usage_file_keep_comments)
1. [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5552-argparser_usage_message_option_type)
1. [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#5553-argparser_usage_message_orientation)
1. [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options)
1. [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style)
1. [`ARGPARSER_USE_LONG_OPTIONS`](#5556-argparser_use_long_options)
1. [`ARGPARSER_USE_SHORT_OPTIONS`](#5557-argparser_use_short_options)
1. [`ARGPARSER_USE_STYLES_IN_FILES`](#5558-argparser_use_styles_in_files)
1. [`ARGPARSER_VERSION`](#5559-argparser_version)
1. [`ARGPARSER_VERSION_EXIT_CODE`](#5560-argparser_version_exit_code)
1. [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options)
1. [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style)
1. [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style)
1. [`ARGPARSER_WRITE_ARGS`](#5564-argparser_write_args)
<!-- </toc> -->

#### 5.5.1. Overview

| Variable name                                                                      | Type[^12]  | Default value[^13][^14]  |
|------------------------------------------------------------------------------------|------------|--------------------------|
| [`ARGPARSER_ADD_HELP`](#552-argparser_add_help)                                    | *bool*     | `true`                   |
| [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage)                                  | *bool*     | `true`                   |
| [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version)                              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_INVERSION`](#555-argparser_allow_flag_inversion)            | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_NEGATION`](#556-argparser_allow_flag_negation)              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#557-argparser_allow_option_abbreviation)  | *bool*     | `false`                  |
| [`ARGPARSER_ALLOW_OPTION_MERGING`](#558-argparser_allow_option_merging)            | *bool*     | `false`                  |
| [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name)                        | *str*[^15] | `"args"`                 |
| [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file)                           | *file*     | `""`                     |
| [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#5511-argparser_arg_def_file_has_header)     | *bool*     | `true`                   |
| [`ARGPARSER_ARG_DEF_HAS_HEADER`](#5512-argparser_arg_def_has_header)               | *bool*     | `true`                   |
| [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1)                     | *char*     | `"\|"`[^16]              |
| [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)                     | *char*     | `","`[^16]               |
| [`ARGPARSER_ARGPARSER_VERSION`](#5515-argparser_argparser_version)                 | *str*      | *None* (unset)           |
| [`ARGPARSER_ARGS`](#5516-argparser_args)                                           | *arr*      | *None* (unset)           |
| [`ARGPARSER_CHECK_ARG_DEF`](#5517-argparser_check_arg_def)                         | *bool*     | `false`                  |
| [`ARGPARSER_CHECK_ENV_VARS`](#5518-argparser_check_env_vars)                       | *bool*     | `false`                  |
| [`ARGPARSER_CONFIG_FILE`](#5519-argparser_config_file)                             | *file*     | `""`                     |
| [`ARGPARSER_COUNT_FLAGS`](#5520-argparser_count_flags)                             | *bool*     | `false`                  |
| [`ARGPARSER_DICTIONARY`](#5521-argparser_dictionary)                               | *dict*     | *None* (unset)           |
| [`ARGPARSER_ERROR_EXIT_CODE`](#5522-argparser_error_exit_code)                     | *int*      | `1`                      |
| [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style)                             | *str*      | `"red,bold,reverse"`     |
| [`ARGPARSER_HELP_EXIT_CODE`](#5525-argparser_help_exit_code)                       | *int*      | `0`                      |
| [`ARGPARSER_HELP_ARG_GROUP`](#5524-argparser_help_arg_group)                       | *str*      | `"Help options"`         |
| [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file)                                 | *file*     | `""`                     |
| [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#5527-argparser_help_file_include_char)       | *char*     | `"@"`                    |
| [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#5528-argparser_help_file_keep_comments)     | *bool*     | `false`                  |
| [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options)                           | *char*     | `"h,?"`                  |
| [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style)                               | *str*      | `"italic"`               |
| [`ARGPARSER_LANGUAGE`](#5531-argparser_language)                                   | *str*      | `"en"`                   |
| [`ARGPARSER_MAX_COL_WIDTH_1`](#5532-argparser_max_col_width_1)                     | *uint*     | `5`[^17]                 |
| [`ARGPARSER_MAX_COL_WIDTH_2`](#5533-argparser_max_col_width_2)                     | *uint*     | `33`[^17]                |
| [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3)                     | *uint*     | `0`[^17]                 |
| [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width)                                 | *uint*     | `79`                     |
| [`ARGPARSER_POSITIONAL_ARG_GROUP`](#5536-argparser_positional_arg_group)           | *str*      | `"Positional arguments"` |
| [`ARGPARSER_READ_ARGS`](#5537-argparser_read_args)                                 | *bool*     | `true`                   |
| [`ARGPARSER_SCRIPT_ARGS`](#5538-argparser_script_args)                             | *arr*      | *None* (unset)           |
| [`ARGPARSER_SCRIPT_NAME`](#5539-argparser_script_name)                             | *str*      | `"${0##*/}"`             |
| [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args)                                   | *bool*     | `true`                   |
| [`ARGPARSER_SET_ARRAYS`](#5541-argparser_set_arrays)                               | *bool*     | `true`                   |
| [`ARGPARSER_SILENCE_ERRORS`](#5542-argparser_silence_errors)                       | *bool*     | `false`                  |
| [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings)                   | *bool*     | `false`                  |
| [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file)                   | *file*     | `""`                     |
| [`ARGPARSER_UNSET_ARGS`](#5545-argparser_unset_args)                               | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars)                       | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_FUNCTIONS`](#5547-argparser_unset_functions)                     | *bool*     | `true`                   |
| [`ARGPARSER_USAGE_EXIT_CODE`](#5548-argparser_usage_exit_code)                     | *int*      | `0`                      |
| [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file)                               | *file*     | `""`                     |
| [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#5550-argparser_usage_file_include_char)     | *char*     | `"@"`                    |
| [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#5551-argparser_usage_file_keep_comments)   | *bool*     | `false`                  |
| [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#5552-argparser_usage_message_option_type) | *str*      | `"short"`                |
| [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#5553-argparser_usage_message_orientation) | *str*      | `"row"`                  |
| [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options)                         | *char*     | `"u"`                    |
| [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style)                             | *str*      | `"italic"`               |
| [`ARGPARSER_USE_LONG_OPTIONS`](#5556-argparser_use_long_options)                   | *bool*     | `true`                   |
| [`ARGPARSER_USE_SHORT_OPTIONS`](#5557-argparser_use_short_options)                 | *bool*     | `true`                   |
| [`ARGPARSER_USE_STYLES_IN_FILES`](#5558-argparser_use_styles_in_files)             | *bool*     | `false`                  |
| [`ARGPARSER_VERSION`](#5559-argparser_version)                                     | *str*      | `"1.0.0"`                |
| [`ARGPARSER_VERSION_EXIT_CODE`](#5560-argparser_version_exit_code)                 | *int*      | `0`                      |
| [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options)                     | *char*     | `"V"`                    |
| [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style)                         | *str*      | `"bold"`                 |
| [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style)                         | *str*      | `"red,bold"`             |
| [`ARGPARSER_WRITE_ARGS`](#5564-argparser_write_args)                               | *bool*     | `false`                  |

[^12]: Bash is weakly typed, hence the denoted types are just a guidance.
[^13]: Strings can optionally be enclosed by quotes.
[^14]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^15]: In fact, any legit Bash variable identifier.
[^16]: Values must be different from each other.
[^17]: Sum of values is recommended to be 77.

#### 5.5.2. `ARGPARSER_ADD_HELP`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options) and `--help` as flags to call the help message.

#### 5.5.3. `ARGPARSER_ADD_USAGE`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options) and `--usage` as flags to call the usage message.

#### 5.5.4. `ARGPARSER_ADD_VERSION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options) and `--version` as flags to call the version message.

#### 5.5.5. `ARGPARSER_ALLOW_FLAG_INVERSION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to allow the user to give flags with a prefixed `+` instead of `-` (for short option names) or `++` instead of `--` (for long option names) to negate its value. If [`ARGPARSER_ALLOW_FLAG_NEGATION`](#556-argparser_allow_flag_negation) is set to `true`, this doubles with the effect of using `no-` as prefix for long option names.

#### 5.5.6. `ARGPARSER_ALLOW_FLAG_NEGATION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to allow the user to give long option names for flags with a prefixed `no-` to negate its value.  If [`ARGPARSER_ALLOW_FLAG_INVERSION`](#555-argparser_allow_flag_inversion) is set to `true`, this doubles with the effect of using `++` as prefix, instead of `--`.

#### 5.5.7. `ARGPARSER_ALLOW_OPTION_ABBREVIATION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give long option names in abbreviated form, *e.g.*, `--verb` for `--verbatim`, as long as no collision with *e.g.* `--verbose` arises. Short option names only span one character and thus cannot be abbreviated.

#### 5.5.8. `ARGPARSER_ALLOW_OPTION_MERGING`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give short option names in merged (concatenated) form, *e.g.*, `-ab1` or `-ab=1` for `-a -b 1`. The individual characters are interpreted as option names until an option has a number of required arguments greater than zero, *i.e.*, until an option is no flag. Long option names span multiple characters and thus cannot be merged in a meaningful way.

#### 5.5.9. `ARGPARSER_ARG_ARRAY_NAME`

- ***Type:*** *str* (String), but only characters allowed in a legit Bash variable identifier
- ***Allowed values:*** Any legit Bash variable identifier
- ***Default value:*** `"args"`
- ***Description:*** The name of an indexed array, under which the arguments are provided, and of an associative array, under which the parsed arguments can be accessed. The former stores the argument's identifier as key and its definition as value, but joined to one string by an [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1) character, the latter stores the identifier as key and its values as value. If [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args) is `true`, you usually don't need to access this array as the arguments will be set as variables.

#### 5.5.10. `ARGPARSER_ARG_DEF_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the definition of the arguments. This file may be used by multiple scripts if they share some arguments. It is not necessary to use all arguments from there, as you need to specify which arguments you want to use. It is possible to set additional argument definitions within the script, which could come handy when scripts share some arguments (from the file), but also use some own arguments (from the script), whose names have another meaning in the companion script.

#### 5.5.11. `ARGPARSER_ARG_DEF_FILE_HAS_HEADER`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether the arguments definition file has a header explaining the columns. This is only evaluated if an [`ARGPARSER_ARG_DEF_FILE`](#5510-argparser_arg_def_file) is given.

#### 5.5.12. `ARGPARSER_ARG_DEF_HAS_HEADER`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether the arguments definition in your script has a header explaining the columns.

#### 5.5.13. `ARGPARSER_ARG_DELIMITER_1`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2), no hyphen (`-`), plus sign (`+`), asterisk (`*`), or question mark (`?`)
- ***Default value:*** `"|"`
- ***Description:*** The primary delimiter that separates the fields in the arguments definition. Though you don't need to access this variable, you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

#### 5.5.14. `ARGPARSER_ARG_DELIMITER_2`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#5513-argparser_arg_delimiter_1), no hyphen (`-`), plus sign (`+`), asterisk (`*`), or question mark (`?`)
- ***Default value:*** `","`
- ***Description:*** The secondary delimiter that separates the elements of sequences in the arguments definition. Again, you don't need to access this variable, but you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

#### 5.5.15. `ARGPARSER_ARGPARSER_VERSION`

- ***Type:*** *str* (String)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The version number of the argparser to be used in the version message, using [semantic versioning](https://semver.org/ "semver.org"), *i.e.*, with the version numbers given by major version, minor version, and patch, separated by dots. This variable is read-only and *must not be set* by your script, else, an error is thrown. The argparser will declare it, but you can use it afterwards, if necessary (and [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars) is set to `false`).  
Besides the version message you (not your script's user) can call, the main purpose of `ARGPARSER_ARGPARSER_VERSION` is to simplify the transition to newer argparser versions. Whenever breaking changes are made, there will be scripts given in the repository that will try to automatically upgrade your code, as far as possible, to comply with new features.

#### 5.5.16. `ARGPARSER_ARGS`

- ***Type:*** *arr* (Indexed, later associative array)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The indexed array in which the argparser's options are stored, and later, the associative array for their values. This array *must not be set* by your script, else, an error is thrown. The argparser will declare it, but you can use it afterwards, if necessary (and [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars) is set to `false`).

#### 5.5.17. `ARGPARSER_CHECK_ARG_DEF`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the arguments definition is consistent, *i.e.*, if there is at most one optional positional argument, if there is at most one positional argument with an infinite number of accepted values, if any keyword argument has at least one short or long option name given, with a length of exactly one or at least two characters, and no duplicate names (within its own definition and among all other arguments), if the number of default values equals the number of required values, if the default values lie in the choice values, if flags have a default value of `true` or `false` and no choice values, and if the choice and default values accord to the data type. This may only need to be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the arguments definition at some point (not recommended as it may lead to code injection!), you should activate it.

#### 5.5.18. `ARGPARSER_CHECK_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the argparser environment variables accord to their definition. Again, this may only need to only be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the environment variables at some point (not recommended as it may lead to code injection!), you should activate it.

#### 5.5.19. `ARGPARSER_CONFIG_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the argparser configuration. The lines will be read into environment variables, but those that are already defined within your script or environment override the specification in the `ARGPARSER_CONFIG_FILE`. This file may be used by multiple scripts.

> [!CAUTION]
> The argparser reads the lines into variables without checking them! If the user can modify the `ARGPARSER_CONFIG_FILE`, this is prone to command injection!

#### 5.5.20. `ARGPARSER_COUNT_FLAGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to count flags instead of setting them to `true` or `false` based on the last prefix used on the command line. When `ARGPARSER_COUNT_FLAGS` is set to `false`, `-a -a +a` would result in `a` being set to `false`, since the last prefix was a plus sign. When `ARGPARSER_COUNT_FLAGS` is set to `true` instead, `a` would be set to `1`, as any `true` (hyphen) increases the count by `1` and any `false` (plus sign) decreases it by `1`. Flags that are absent from the command line are assigned `1` if their default value is `true`, and `-1` if their default value is `false`. This results in the same behavior when a flag is `true` per default and absent, or set with `-a` (yielding `a == 1`); or when a flag is `false` per default and absent, or set with `+a` (yielding `a == -1`). Counting flags can be helpful when, *e.g.*, different levels of verbosity are allowed. If [`ARGPARSER_ALLOW_OPTION_MERGING`](#558-argparser_allow_option_merging) is also set to `true`, the user can give `-vvv` on the command line for the third level of verbosity (given it's handled by your script).

#### 5.5.21. `ARGPARSER_DICTIONARY`

- ***Type:*** *dict* (Dictionary / associative array)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The associative array in which to store the translation from the [`ARGPARSER_TRANSLATION_FILE`](#5544-argparser_translation_file) for the [`ARGPARSER_LANGUAGE`](#5531-argparser_language). This array *must not be set* by your script, else, an error is thrown. The argparser will declare it, but you can use it afterwards, if necessary (and [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars) is set to `false`).

#### 5.5.22. `ARGPARSER_ERROR_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually not zero
- ***Default value:*** `1`
- ***Description:*** The exit code when errors occurred upon parsing.

#### 5.5.23. `ARGPARSER_ERROR_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold,reverse"`
- ***Description:*** The color and style specification to use for error messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 5.5.24. `ARGPARSER_HELP_ARG_GROUP`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"Help options"`
- ***Description:*** The name of the argument group holding all help options. This group is usually the last in the help message.

#### 5.5.25. `ARGPARSER_HELP_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a help message was requested using the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options)  or the `--help` flag.

#### 5.5.26. `ARGPARSER_HELP_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended help message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated help message (invoked with the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options)  or `--help`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

#### 5.5.27. `ARGPARSER_HELP_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the help file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_HELP_FILE` is given.

#### 5.5.28. `ARGPARSER_HELP_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the help file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.*, `#`) in the help file also in the help message. This is only evaluated if an [`ARGPARSER_HELP_FILE`](#5526-argparser_help_file) is given.

#### 5.5.29. `ARGPARSER_HELP_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"h,?"`
- ***Description:*** The short option names used to call the help message. This is only evaluated if [`ARGPARSER_ADD_HELP`](#552-argparser_add_help) is `true`.

#### 5.5.30. `ARGPARSER_HELP_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for help messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 5.5.31. `ARGPARSER_LANGUAGE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"en"`
- ***Description:*** The language in which to localize the help, usage, error, and warning messages.

#### 5.5.32. `ARGPARSER_MAX_COL_WIDTH_1`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `5`
- ***Description:*** The maximum column width of the first column in the generated help message. This column holds the short options of the arguments, hence, it usually can be rather narrow. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_1`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width).

#### 5.5.33. `ARGPARSER_MAX_COL_WIDTH_2`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `33`
- ***Description:*** The maximum column width of the second column in the generated help message. This column holds the long options of the arguments, hence, it usually should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_2`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width).

#### 5.5.34. `ARGPARSER_MAX_COL_WIDTH_3`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any non-negative integer, including `0`
- ***Default value:*** `0`
- ***Description:*** The maximum column width of the third column in the generated help message. This column holds the help text of the arguments, hence, it usually should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_3`. If it is less wide, the column is shrunk accordingly. A value of `0` disables this variable in favor of [`ARGPARSER_MAX_WIDTH`](#5535-argparser_max_width). For details, refer to `ARGPARSER_MAX_WIDTH`.

#### 5.5.35. `ARGPARSER_MAX_WIDTH`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `79`
- ***Description:*** The maximum width of the entire generated help message. The widths of the first two columns are controlled by [`ARGPARSER_MAX_COL_WIDTH_1`](#5532-argparser_max_col_width_1) and [`ARGPARSER_MAX_COL_WIDTH_2`](#5533-argparser_max_col_width_2), respectively, whose contents are always wrapped by line breaks to fit this width, and shrunk if less wide. For the third column, [`ARGPARSER_MAX_COL_WIDTH_3`](#5534-argparser_max_col_width_3) may be set to `0` to disable this behavior in favor of a fixed width, set by `ARGPARSER_MAX_WIDTH`. Thereby, the third column takes up as much space as left, *i.e.*, the help message's maximum width minus the actual (not maximum) widths of the first two columns.  
It is recommendable to have a total width of the help message of 79 characters. As one space is always inserted as separation between the first and second column, as well as between the second and third column, the sum of `ARGPARSER_MAX_COL_WIDTH_1`, `ARGPARSER_MAX_COL_WIDTH_2`, and `ARGPARSER_MAX_COL_WIDTH_3` should equal 77. As long options are longer than short options, the second column should be far wider than the first. The help text in the third column consists of human-readable words and is thus less bound to word wrapping restrictions. By this, it is easier to set the third column's width to 77 characters minus the total maximum width of the unwrapped first two columns to get an optimized help message layout&mdash;or use `ARGPARSER_MAX_WIDTH`.

#### 5.5.36. `ARGPARSER_POSITIONAL_ARG_GROUP`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"Positional arguments"`
- ***Description:*** The name of the argument group holding all positional arguments. This group is usually the first in the help message.

#### 5.5.37. `ARGPARSER_READ_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to read the arguments from the command line (*i.e.*, from `"$@"`) and parse them to the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) sets.

#### 5.5.38. `ARGPARSER_SCRIPT_ARGS`

- ***Type:*** *arr* (Indexed array)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The indexed array in which the argparser stores your script's command line upon parsing its own arguments. This array *must not be set* by your script, else, an error is thrown. The argparser will declare it, but you can use it afterwards, if necessary (and [`ARGPARSER_UNSET_ENV_VARS`](#5546-argparser_unset_env_vars) is set to `false`).

#### 5.5.39. `ARGPARSER_SCRIPT_NAME`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"${0##*/}"`
- ***Description:*** The name of your script as it should appear in the help, usage, version, error, and warning messages. By default, it is the name used upon invoking your script (`"$0"`), trimmed by everything before the last slash character (mimicking the behavior of [`basename`](https://man7.org/linux/man-pages/man1/basename.1.html "man7.org &rightarrow; man pages &rightarrow; basename(1)")). If, for example, you want to give your script a symlink, but don't want this symlink's name to be used in the help and usage messages, then you can provide a custom, canonicalized `ARGPARSER_SCRIPT_NAME`. Alternatively, if your script forms a sub-part of a larger program, it may be named `program_part.sh`, but should be called as `program name [ARGUMENTS]`. Then, `program.sh` could parse its positional argument `name` and call `program_part.sh`, but on the command line, you want to hide this implementation detail and refer to `program_part.sh` as `program name`, so you set `ARGPARSER_SCRIPT_NAME` accordingly.

#### 5.5.40. `ARGPARSER_SET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set the (read and parsed) arguments from the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) refers to as variables in the calling script's scope.

> [!CAUTION]
> The argparser performs no complex sanity checks for argument values! Automatically setting them as variables to the script is prone to command injection!

#### 5.5.41. `ARGPARSER_SET_ARRAYS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set arguments intended to have multiple values as indexed array. This is only evaluated if [`ARGPARSER_SET_ARGS`](#5540-argparser_set_args) is `true`. While it can be very helpful in a script to have the multiple values already set to an array that can be iterated over, the drawback is that arrays are hard to transfer to other scripts and may need to be serialized. Since they come in serialized form from the argparser, a temporary expansion to an array might be unnecessary.

#### 5.5.42. `ARGPARSER_SILENCE_ERRORS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of error messages. This should rarely be needed since the argparser still stops running after a critical failure (which is the reason for error messages), but it may clean up your output when logging. See also [`ARGPARSER_SILENCE_WARNINGS`](#5543-argparser_silence_warnings).

#### 5.5.43. `ARGPARSER_SILENCE_WARNINGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of warning messages. Like [`ARGPARSER_SILENCE_ERRORS`](#5542-argparser_silence_errors), this should rarely be needed, but as the argparser continues running after a non-critical failure (which is the reason for warning messages), these messages may not strictly be required for your script's user.

#### 5.5.44. `ARGPARSER_TRANSLATION_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a simplified YAML file holding the translation of auto-generated parts in the help, usage, error, and warning messages. This file can be used by multiple scripts. As a YAML file, it contains the translation in a key&ndash;value layout, separated by colons and using significant indentation. Each group key must specify the language identifier used for the [`ARGPARSER_LANGUAGE`](#5531-argparser_language). As many languages as desired can be given, which allows the localization for multiple languages with just one `ARGPARSER_TRANSLATION_FILE`. The rows can be in any order.

#### 5.5.45. `ARGPARSER_UNSET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) all command-line arguments given to the script. This is usually what you want, as the argparser re-sets these values in parsed form.

#### 5.5.46. `ARGPARSER_UNSET_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) the argparser environment variables from the environment. As long as you don't need these variables anymore or want to reset them prior to the next argparser invokation, this is usually what you want. This prevents accidental (but also deliberate) inheritance to child scripts when passing the entire environment to them.

#### 5.5.47. `ARGPARSER_UNSET_FUNCTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) the argparser functions from the environment. You should not need them separated from an argparser invokation, where they're automatically defined (set) upon sourcing it. By unsetting them, the namespace is kept clean.

#### 5.5.48. `ARGPARSER_USAGE_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a usage message was requested using the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options) or the `--usage` flag.

#### 5.5.49. `ARGPARSER_USAGE_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended usage message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated usage message (invoked with the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options) or `--usage`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

#### 5.5.50. `ARGPARSER_USAGE_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the usage file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_USAGE_FILE` is given.

#### 5.5.51. `ARGPARSER_USAGE_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the usage file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.*, `#`) in the usage file also in the usage message. This is only evaluated if an [`ARGPARSER_USAGE_FILE`](#5549-argparser_usage_file) is given.

#### 5.5.52. `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"long"` and `"short"`
- ***Default value:*** `"short"`
- ***Description:*** Whether to use short or long option names in usage messages. If an option doesn't have short option names, its long option names are used, and *vice versa*.

#### 5.5.53. `ARGPARSER_USAGE_MESSAGE_ORIENTATION`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"row"` and `"column"`
- ***Default value:*** `"row"`
- ***Description:*** Whether to output the positional and keyword arguments in usage messages in a row or in a column.

#### 5.5.54. `ARGPARSER_USAGE_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"u"`
- ***Description:*** The short option names used to call the usage message. This is only evaluated if [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage) is `true`.

#### 5.5.55. `ARGPARSER_USAGE_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for usage messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 5.5.56. `ARGPARSER_USE_LONG_OPTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to accept long option names upon parsing and creating the help and usage messages. If your script doesn't take any long option, it may be practical to disable also the long options the argparser sets, *viz.* `--help`, `--usage`, and `--version` (given that [`ARGPARSER_ADD_HELP`](#552-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version), respectively, are set). Additionally, the help message will only have two columns (the short option names and the help texts), then.

#### 5.5.57. `ARGPARSER_USE_SHORT_OPTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to accept short option names upon parsing and creating the help and usage messages. If your script doesn't take any short option, it may be practical to disable also the short options the argparser sets, *viz.* the [`ARGPARSER_HELP_OPTIONS`](#5529-argparser_help_options), the [`ARGPARSER_USAGE_OPTIONS`](#5554-argparser_usage_options), and the [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options) (given that [`ARGPARSER_ADD_HELP`](#552-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#553-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version), respectively, are set). Additionally, the help message will only have two columns (the long option names and the help texts), then.

#### 5.5.58. `ARGPARSER_USE_STYLES_IN_FILES`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to use the colors and styles from [`ARGPARSER_HELP_STYLE`](#5530-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#5555-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](#5562-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](#5523-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](#5563-argparser_warning_style) when `STDOUT`/`STDERR` is not a terminal (and thus perhaps a file). This is useful to get plain 7-bit ASCII text output for files, while in interactive sessions, the escape sequences offer more user-friendly formatting and possibilities for highlighting. By this, you can parse your files afterwards more easily. Still, using *e.g.* [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"), these escape sequences can be displayed from files, when included.

#### 5.5.59. `ARGPARSER_VERSION`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"1.0.0"`
- ***Description:*** The version number of your script to be used in the version message. Prefer using [semantic versioning](https://semver.org/ "semver.org"), *i.e.*, give version numbers by major version, minor version, and patch, separated by dots.

#### 5.5.60. `ARGPARSER_VERSION_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a version message was requested using the [`ARGPARSER_VERSION_OPTIONS`](#5561-argparser_version_options) or the `--version` flag.

#### 5.5.61. `ARGPARSER_VERSION_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"V"`
- ***Description:*** The short option names used to call the version message. This is only evaluated if [`ARGPARSER_ADD_VERSION`](#554-argparser_add_version) is `true`.

#### 5.5.62. `ARGPARSER_VERSION_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"bold"`
- ***Description:*** The color and style specification to use for version messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 5.5.63. `ARGPARSER_WARNING_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#5514-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold"`
- ***Description:*** The color and style specification to use for warning messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 5.5.64. `ARGPARSER_WRITE_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to write the arguments from [`ARGPARSER_ARG_ARRAY_NAME`](#559-argparser_arg_array_name) to STDOUT. This is required for running the argparser in a pipe to be able to access the parsed arguments. These are output as key&ndash;value pairs, separated by linefeeds.
