<!--
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
-->

### 5.11. Standalone usage

Although the usual way to run the Argparser is [sourcing](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source"), you can also invoke it directly. This allows you to query the Argparser's options, but, perhaps more importantly, to run it from shells other than Bash.

#### 5.11.1. Argparser introspection

By invoking the Argparser, you can obtain the help, usage, and version message for the Argparser itself, *e.g.* when you're looking for a certain option name, but don't want to or can't consult the manual. The invokation is identical to your script's:

<!-- <include command="argparser --help" lang="console"> -->
```console
$ argparser --help
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
```
<!-- </include> -->

When the first option of the Argparser-invoking command is `--debug` or [`ARGPARSER_DEBUG`](../reference/environment_variables/environment_variables.md#9420-argparser_debug) is set to `true`, the Argparser will write each command to be executed to `STDERR`, including the command's line number and function. This allows logging the internal workings for debugging purposes, and is not designed for normal usage, but rather deemed an "expert option".

#### 5.11.2. Invokation from other shells

The second, and perhaps more important way of standalone usage is included for compatibility with other shells. Since only Bash can successfully source Bash scripts (at least, when they rely on Bashisms, which is the case for the Argparser), the Argparser would only be usable from within Bash scripts. While this remains the central point of application, there is also a way to run the Argparser from other shell's scripts. As an example, let's have a look at the [`try_pipeline.sh`](../../tutorial/try_pipeline.sh) script:

<details open>

<summary>Contents of <code>try_pipeline.sh</code></summary>

<!-- <include command="sed '3,29d;/shellcheck/d' ../tutorial/try_pipeline.sh" lang="sh"> -->
```sh
#!/bin/sh

# Run the Argparser in standalone mode from POSIX sh, reading from and
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
    var_4 | d          |           | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice
    var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default
    var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default
    var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default
'

if [ "$1" = "-h" ] || [ "$1" = "--help" ] \
    || [ "$1" = "-u" ] || [ "$1" = "--usage" ] \
    || [ "$1" = "-V" ] || [ "$1" = "--version" ]
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
<!-- </include> -->

</details>

As you can see, the script is written POSIX conformantly and by this already executable by `sh` or `dash`. Since POSIX doesn't specify useful programming constructs like arrays, the arguments definition must be a single string, delimited by linefeeds. By passing this string to the Argparser via its `STDIN` stream (piping from [`printf`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf "gnu.org &rightarrow; Bash Builtins &rightarrow; printf") to `argparser`), it is possible to feed the arguments definition to the Argparser without requiring the usual [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#9410-argparser_arg_array_name). Just as when sourcing, the Argparser requires your script's command line as argument, separated from its own arguments by a double hyphen.

It is important to set [`ARGPARSER_WRITE_ARGS`](../reference/environment_variables/environment_variables.md#9465-argparser_write_args) to `true`. By this, the Argparser will write the parsed arguments as key&ndash;value pairs to its `STDOUT` stream, since setting them as variables to the environment would result in them being lost when the child process the Argparser is running in terminates.

In our example script, the whole pipeline is run in a subshell, such that `STDOUT` gets captured by `eval`. This facilitates the setting of the variables to the main environment, as the Argparser outputs one argument per line, with an `=` sign as delimiter between key and value. In other terms, the Argparser produces output which may be re-used as input to `eval`&mdash;here assuming that no special shell characters are included. For the purpose of this example, calls for the help, usage, and version message are caught in a separate branch to circumvent the parsing by `eval`&mdash;after all, these messages are also written to `STDOUT`, while the usual error and warning messages end in `STDERR`. Depending on your shell, you may find more sophisticated solutions that can also handle the occurrence of these help options among other (regular) options on the command line.

Another point to notice is the need to set the [`ARGPARSER_SCRIPT_NAME`](../reference/environment_variables/environment_variables.md#9438-argparser_script_name) prior running the Argparser, since from within its child process, it cannot access your script's name without requiring non-builtin commands like [`ps`](https://man7.org/linux/man-pages/man1/ps.1.html "man7.org &rightarrow; man pages &rightarrow; ps(1)"). This would violate the design decision to only use Bash builtins, both for speed (no forks) and portability (few dependencies).

In short, it is possible to run the Argparser in standalone mode from other shells, but this comes with the caveats of subprocesses&mdash;which the sourcing in Bash overcomes. Still, the only feature that your shell must support is calling processes in pipes or *via* process substitutions to pass data to the Argparser's `STDIN` and read its `STDOUT`. Since pipes are defined by POSIX, most shells should support this feature. It's just the *parsing* of the Argparser's output that may cause some headache.

[&#129092;&nbsp;5.10. Message styles](message_styles.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6. Comparison of command-line parsers&nbsp;&#129094;](../comparison/introduction.md)
