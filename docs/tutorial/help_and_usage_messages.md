### 4.5. Help and usage messages

No matter how many keyword arguments are defined, as long as [`ARGPARSER_ADD_HELP`](../reference/environment_variables/environment_variables.md#842-argparser_add_help) and [`ARGPARSER_ADD_USAGE`](../reference/environment_variables/environment_variables.md#843-argparser_add_usage) are set to `true` (the default), the Argparser interprets the flags from the [`ARGPARSER_HELP_OPTIONS`](../reference/environment_variables/environment_variables.md#8428-argparser_help_options) (default: `-h` and `-?`) and `--help` as call for a verbose help message and the flags from the [`ARGPARSER_USAGE_OPTIONS`](../reference/environment_variables/environment_variables.md#8453-argparser_usage_options) (default: `-u`) and `--usage` as call for a brief usage message. Then, these options are automatically added to the script's arguments definition and override any same-named argument name (yielding an error message if [`ARGPARSER_CHECK_ARG_DEF`](../reference/environment_variables/environment_variables.md#8415-argparser_check_arg_def) is set to `true`). This is to ensure that the novice user of your script can do exactly what we did, above: trying the most common variants to get some help over how to use a program or script by typing

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

As a huge convenience, the Argparser will build the help and usage messages from the defined arguments for your script, if either of the `ARGPARSER_HELP_OPTIONS`, `--help`, `ARGPARSER_USAGE_OPTIONS`, or `--usage` options is given on the command line (even along with others, with the help message taking precedence over the usage message). These messages indicate the short and/or long names, as well as the default and choice values. In the case of the help message, the argument group, the notes, and the help text from the arguments' definitions are printed, too.

#### 4.5.1. Help messages

Now, we can investigate the help message, just as we did above, with the very same result:

<!-- <include command="bash ../tutorial/try_argparser.sh --help" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh --help
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
```
<!-- </include> -->

The help message details all short and long option names, their optionality (*i.e.*, whether there are default values), and their choice values, using the same syntax as in the usage message (square brackets for optional arguments, curly braces for choice values). Additionally, the help text and notes from the arguments definition are given. The arguments are separated by their groups, thus structuring the help message. First, the group for the positional arguments is given (indicated by [`ARGPARSER_POSITIONAL_ARG_GROUP`](../reference/environment_variables/environment_variables.md#8435-argparser_positional_arg_group)), then follow the keyword argument groups in alphabetical order. Finally, the default `--help`, `--usage`, and `--version` arguments (the latter for the [version message](version_messages.md#48-version-messages)) are given as separate, yet unnamed group.

The help message's structure aims at reproducing the commonly found structure in command-line programs. By setting [`ARGPARSER_MAX_COL_WIDTH_1`](../reference/environment_variables/environment_variables.md#8431-argparser_max_col_width_1), [`ARGPARSER_MAX_COL_WIDTH_2`](../reference/environment_variables/environment_variables.md#8432-argparser_max_col_width_2), or [`ARGPARSER_MAX_COL_WIDTH_3`](../reference/environment_variables/environment_variables.md#8433-argparser_max_col_width_3) (as done in `try_argparser.sh`), the column widths may be adapted to your needs, recommendably totalling 77 characters (thus 79 characters including the separating spaces). Note that columns are automatically shrunk, when their content is narrower, but they're not expanded, when their content is wider. This is to guarantee that the help message, when *e.g.* sent as logging output, nicely fits in the space you have.

Alternatively, you may want to set [`ARGPARSER_MAX_WIDTH`](../reference/environment_variables/environment_variables.md#8434-argparser_max_width). By this, the help message will have a defined width, independent of shrunk columns. This is achieved by expanding the third column (with the help text) to the remaining width. For this to work, [`ARGPARSER_MAX_COL_WIDTH_3`](../reference/environment_variables/environment_variables.md#8433-argparser_max_col_width_3) must be set to `0`.

#### 4.5.2. Usage messages

As we already saw upon the occasion of an error, our [`try_argparser.sh`](../../tutorial/try_argparser.sh) usage message looks as follows:

<!-- <include command="bash ../tutorial/try_argparser.sh --usage" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh --usage
Usage: try_argparser.sh [-h,-? | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```
<!-- </include> -->

The usage message clearly summarizes the arguments, including name aliases (always taking all short options, or, if absent, all long options, or *vice versa*, see below), indicates whether they're optional or mandatory (optionals use square brackets), and specifies the choice values (in curly braces) and, partially, the argument number (an ellipsis, *i.e.*, `"..."`, for an infinite number). Short options precede long options, options with default precede those without, likewise for positionals, and keyword arguments precede positional arguments. All of these groups are sorted alphabetically by the first option name as key. The help, usage, and [version](version_messages.md#48-version-messages) options precede all groups.

For a better overview when having lots of arguments, we can choose a columnar layout instead of the single row, using [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../reference/environment_variables/environment_variables.md#8452-argparser_usage_message_orientation):

<!-- <include command="ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash ../tutorial/try_argparser.sh --usage" lang="console"> -->
```console
$ ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash ../tutorial/try_argparser.sh --usage
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
<!-- </include> -->

Additionally, we may choose to show the long options by [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../reference/environment_variables/environment_variables.md#8451-argparser_usage_message_option_type):

<!-- <include command="ARGPARSER_USAGE_MESSAGE_OPTION_TYPE=long ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash ../tutorial/try_argparser.sh --usage" lang="console"> -->
```console
$ ARGPARSER_USAGE_MESSAGE_OPTION_TYPE=long ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash ../tutorial/try_argparser.sh --usage
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
<!-- </include> -->

Of course, you would normally give these environment variables in your script and wouldn't rely on the user to give them on the command line&mdash;especially not, when he's looking for *how to use* the script.

[&#129092;&nbsp;4.4. Arguments definition files](arguments_definition_files.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.6. Help and usage message files&nbsp;&#129094;](help_and_usage_message_files.md)
