# Bash argparser

The argparser is a designed to be an easy-to-use, yet powerful command-line argument parser for your Bash scripts, superior to the traditionally used [`getopt`](https://www.man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)")/[`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") or a bare suite of conditionals in a `case..esac` statement. It is entirely written in pure Bash, without invoking external commands. Thus, using the argparser does not add additional dependencies to your script, especially not on differing versions of a program (like [`awk`](https://www.man7.org/linux/man-pages/man1/awk.1p.html "man7.org &rightarrow; man pages &rightarrow; awk(1p)")). Shells other than Bash are (currently) not supported. The argparser is inspired by the [Python argparse module](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module").

## Table of contents

<!-- <toc> -->
- [Bash argparser](#bash-argparser)
  - [Table of contents](#table-of-contents)
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Argument passing](#argument-passing)
    - [Argparser invokation](#argparser-invokation)
    - [Help and usage messages](#help-and-usage-messages)
    - [Help and usage message files](#help-and-usage-message-files)
    - [Arguments definition files](#arguments-definition-files)
    - [Help and usage message localization](#help-and-usage-message-localization)
    - [Version messages](#version-messages)
    - [Message styles](#message-styles)
  - [Include directives](#include-directives)
    - [`@All` directive](#all-directive)
    - [`@<ArgumentGroup>` directive](#argumentgroup-directive)
    - [`@Header` directive](#header-directive)
    - [`@Help` directive](#help-directive)
  - [Environment variables](#environment-variables)
    - [Overview over environment variables](#overview-over-environment-variables)
    - [`ARGPARSER_ADD_HELP`](#argparser_add_help)
    - [`ARGPARSER_ADD_USAGE`](#argparser_add_usage)
    - [`ARGPARSER_ADD_VERSION`](#argparser_add_version)
    - [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#argparser_allow_option_abbreviation)
    - [`ARGPARSER_ALLOW_OPTION_MERGING`](#argparser_allow_option_merging)
    - [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name)
    - [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file)
    - [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#argparser_arg_def_file_has_header)
    - [`ARGPARSER_ARG_DEF_HAS_HEADER`](#argparser_arg_def_has_header)
    - [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1)
    - [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2)
    - [`ARGPARSER_CHECK_ARG_DEFINITION`](#argparser_check_arg_definition)
    - [`ARGPARSER_CHECK_ENV_VARS`](#argparser_check_env_vars)
    - [`ARGPARSER_COUNT_FLAGS`](#argparser_count_flags)
    - [`ARGPARSER_ERROR_EXIT_CODE`](#argparser_error_exit_code)
    - [`ARGPARSER_ERROR_STYLE`](#argparser_error_style)
    - [`ARGPARSER_HELP_EXIT_CODE`](#argparser_help_exit_code)
    - [`ARGPARSER_HELP_FILE`](#argparser_help_file)
    - [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#argparser_help_file_include_char)
    - [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#argparser_help_file_keep_comments)
    - [`ARGPARSER_HELP_STYLE`](#argparser_help_style)
    - [`ARGPARSER_LANGUAGE`](#argparser_language)
    - [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1)
    - [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2)
    - [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3)
    - [`ARGPARSER_POSITIONAL_ARG_GROUP`](#argparser_positional_arg_group)
    - [`ARGPARSER_READ_ARGS`](#argparser_read_args)
    - [`ARGPARSER_SCRIPT_NAME`](#argparser_script_name)
    - [`ARGPARSER_SET_ARGS`](#argparser_set_args)
    - [`ARGPARSER_SET_ARRAYS`](#argparser_set_arrays)
    - [`ARGPARSER_SILENCE_ERRORS`](#argparser_silence_errors)
    - [`ARGPARSER_SILENCE_WARNINGS`](#argparser_silence_warnings)
    - [`ARGPARSER_TRANSLATION_FILE`](#argparser_translation_file)
    - [`ARGPARSER_UNSET_ARGS`](#argparser_unset_args)
    - [`ARGPARSER_UNSET_ENV_VARS`](#argparser_unset_env_vars)
    - [`ARGPARSER_UNSET_FUNCTIONS`](#argparser_unset_functions)
    - [`ARGPARSER_USAGE_EXIT_CODE`](#argparser_usage_exit_code)
    - [`ARGPARSER_USAGE_FILE`](#argparser_usage_file)
    - [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#argparser_usage_file_include_char)
    - [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#argparser_usage_file_keep_comments)
    - [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#argparser_usage_message_option_type)
    - [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#argparser_usage_message_orientation)
    - [`ARGPARSER_USAGE_STYLE`](#argparser_usage_style)
    - [`ARGPARSER_USE_STYLES_IN_FILES`](#argparser_use_styles_in_files)
    - [`ARGPARSER_VERSION`](#argparser_version)
    - [`ARGPARSER_VERSION_EXIT_CODE`](#argparser_version_exit_code)
    - [`ARGPARSER_VERSION_STYLE`](#argparser_version_style)
    - [`ARGPARSER_WARNING_STYLE`](#argparser_warning_style)
<!-- </toc> -->

## Features

The argparser:

- parses your script's **positional** and **keyword (option) arguments**
- allows **any number** of **short** and **long option names** for the same option (as aliases)
- gives proper **error** and **warning messages** for wrongly set arguments or unset mandatory options, according to a brief definition provided by your script
- assigns the positional and keyword arguments' values to **corresponding variables** in your script's scope
- can use parts of an arguments definition **shared across multiple scripts**
- creates and prints a verbose and customizable **help** or a brief **usage message**, as well as a short **version message**
- can give **localized** help and usage messages in any language you define
- can be widely **configured** to your needs by a set of environment variables and companion files to your script

## Installation

> [!WARNING]
> Requires Bash 5 or higher (try `bash --version`). Tested with `GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`.

No actual installation is necessary, as the argparser is just a Bash script that can be located in an arbitrary directory of your choice, like `/usr/local/bin`. Thus, the "installation" is as simple as cloning the repository in this very directory:

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Simon-Brandt/bash_argparser.git
```

To be able to refer to the argparser directly by its name, without providing the entire path (which enhances the portability of your script to other machines), you may want to add

```bash
PATH="/path/to/shell_argparser:${PATH}"
```

(replace the `/path/to` with your actual path) to either of the following files (see `info bash` or `man bash`):

- `~/.profile` (local addition, for login shells)
- `~/.bashrc` (local addition, for non-login shells)
- `/etc/profile` (global addition, for login shells)
- `/etc/bash.bashrc` (global addition, for non-login shells)

> [!CAUTION]
> Be wary not to forget the final `${PATH}` component in the above command, or else you will override the [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH")) for all future shell sessions, meaning no other (non-builtin) command will be resolvable, anymore.

## Usage

To give you an idea about the argparser's application, the following sections show some excerpts of scripts used for internal testing purposes, trying to guide you through the various features.

> [!NOTE]
> For the terminology in argument parsing, refer to the [Python optparse module documentation](https://docs.python.org/3/library/optparse.html#terminology "python.org &rightarrow; Python documentation &rightarrow; optparse module &rightarrow; terminology"). Additionally, for consistency with the positional arguments, options are herein partly referred to as keyword arguments.

### Argument passing

First, let's see how we can use the argparser to parse the arguments given to your script, here saved as `try_argparser.sh` in the CWD. You can uncover the script if you want to test and try it, but we'll come back to it in the next section. For now, only the output is relevant, when we call the script from the command line.

<details>

<summary>Contents of <code>try_argparser.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser.  As the arguments have multiple short and long
# options, override the default column widths for the help message.
ARGPARSER_MAX_COL_WIDTH_1=9
ARGPARSER_MAX_COL_WIDTH_2=33
ARGPARSER_MAX_COL_WIDTH_3=35

# Define the arguments.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
    "var_1:a,A:var-1,var-a:VAL_1:-:-:uint:1:Mandatory options:-:one value without default or choice"
    "var_2:b,B:var-2,var-b:VAL_2:-:-:int:+:Mandatory options:-:at least one value without default or choice"
    "var_3:c,C:var-3,var-c:VAL_3:-:A,B:char:+:Mandatory options:-:at least one value with choice"
    "var_4:d,D:var-4,var-d:VAL_4:A:A,B,C:char:1:Optional options:-:one value with default and choice"
    "var_5:e,E:var-5,var-e:VAL_5:E:-:str:1:Optional options:-:one value with default"
    "var_6:f,F:var-6,var-f:VAL_6:false:-:bool:0:Optional options:-:no value (flag) with default"
    "var_7:g,G:var-7,var-g:VAL_7:true:-:bool:0:Optional options:deprecated:no value (flag) with default"
)

source argparser

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
Usage: try_argparser.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]
                                           one positional argument with default
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
```

This already gives us plenty of information. Even though we don't know yet where it comes from (it's generated by the argparser, not hardcoded in the script), we can see that `try_argparser.sh` accepts two positional arguments and seven different options, (more or less) aptly named `--var-1` through `--var-7`. There are other names referring to the same options, but we'll come back to this later.

Now that we had a look at the options (or keyword arguments, to cope with the fact that some are mandatory), we know that some of them, `--var-4` through `--var-7`, as well as `pos_1`, to be precise, have default arguments. These are indicated by the square brackets in the help message, and since they are optional, we try not to care about them. Instead, we run `try_argparser.sh` as follows:

```console
$ bash try_argparser.sh 1 --var-1=1 --var-2=2 --var-3=A
Error: The argument "pos_2" requires 2 values, but has 1 given.

Usage: try_argparser.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
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

And now we got something that looks like the intended output. Even without fully understanding yet what the argparser does, you can see that we set *three* options and their arguments ([`IFS`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-IFS "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; IFS") whitespace&ndash;delimited) on the command-line invokation of `try_argparser.sh`, *viz.* `--var-1`, `--var-2`, and `--var-3`. Nonetheless, the script reports *seven* options to be given. This is due to `var_4` through `var_7` (note that the *identifiers* use underscores ("snake case"), while the *option names* use hyphens ("kebab-case"), here) having said default values that are used when the argument is not given on the command line. For `var_1` through `var_3`, the reported values are exactly what we specified, *i.e.*, `"1"`, `"2"`, and `"A"`, respectively.

Likewise, `pos_2` is reported to be `1,2`, so some sort of sequence of the two values we gave (more precise: the concatenation of the two values, joined by an [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2) character, as we'll see later), and `pos_1` has been assigned a default value of `2`.

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

That's exactly the same output as before. We set the three mandatory options with arguments, *viz.* `-a`, `-b`, and `-c`, but none is reported in the script's output. Then, we set a double hyphen (`--`) and two values, `1` and `2`. Thus, it is possible to give positional arguments after the special keyword argument `--`, *i.e.*, a double hyphen with no name behind. This is the usual way of saying "end of keyword arguments".

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

Setting `--` after the positional argument&ndash;only part has started (*i.e.*, after a previous `--`) makes this second `--` a positional argument. In contrast, setting `++` after `--` re-starts the usual parsing, so the following argument is parsed as keyword argument if it starts with a hyphen (or a plus sign, see below), and as positional argument, else.

Setting `--` after `++` stops the parsing (possibly again), while setting `++` after `++` means to parse a following non-hyphenated argument as positional, instead of as value to the previous keyword argument. You may rarely need the `++`, but a possible use case for scripts would be to gather command-line arguments or values from different processes, like *via* command/process substitution. Then, you can just combine the two streams, without needing to care whether both may set a `--`. Just join them with a `++` and the parsing occurs as expected.

As we saw in the two examples, options can have name aliases, *i.e.*, any number of synonymous option names pointing to the same entity (argument identifier in the arguments definition). Thereby, not only aliases with two hyphens (so-called long options) are possible, but also some with only one leading hyphen (short options). For fast command-line usage, short options are convenient to quickly write a command; but for scripts, the long options should be preferred as they carry more information due to their verbose name (like, what does `-v` mean&mdash;is it `--version`, `--verbose`, or even `--verbatim`?). The argparser allows an arbitrary number of short and/or long option names for a keyword argument to be defined, and options can be provided by any alias on the command line.

Further, long option names can be abbreviated, as long as no collision with other names arises (like when giving `--verb` in the example above). This requires [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#argparser_allow_option_abbreviation) to be set to `true`. In contrast, short option names may be merged with their value or other short option names (if they're flags, see below), given that [`ARGPARSER_ALLOW_OPTION_MERGING`](#argparser_allow_option_merging) is set to `true`. For the sake of an example without needing a novel script, we'll set the latter variable to the environment of the script execution by prefixing the assignments to the usual command line:

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

And since the option names only differ in their last character, it is impossible to abbreviate them without ambiguity:

```console
$ ARGPARSER_ALLOW_OPTION_ABBREVIATION=true bash try_argparser.sh --var-1 1 --var-2 2 --var -- 1 2
Error: The argument "--var" matches multiple options.

Usage: try_argparser.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

You may have noticed that we didn't use an equals sign (`=`) to delimit option names and their values, here. Though from the former examples it may seem as if it was related to the usage of short option names, for the argparser, it is completely arbitrary whether you use spaces or equals signs. Again, typing spaces is faster on the command line, but using the explicit equals sign makes a script's code more legible.

This has the additional advantage that it's clear to a user (reading *e.g.* your script's manual) that the value belongs to the option before, and that it's not a flag followed by a positional argument. As long as this user doesn't know that the argparser only treats values following option names as positional arguments when they're separated by a double hyphen, it may look confusing.

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

From the report for the `-b` option, an alias of `--var-2`, you can see that all three values&mdash;`2`, `3`, and `4`&mdash;are passed to `var_2`. Thus, it is possible to define keyword arguments to accept more than one value (just as `pos_2` already has shown for the positional arguments), with any given value being concatenated to the last given option name (or rather, the last hyphenated value). You can even call an argument multiple times, passing values at different positions to it, though it seems rather counterproductive (in terms of confusing and unnecessarily verbose) for usage in scripts. On the command line, however, it may save you to go back when you realize you forgot to type a value. Another use case even for scripts would again be the gathering of command-line arguments or values from different processes, combining the two streams without needing to care whether they pass mutually exclusive option names or the same.

As you can see from the `-c` option, you can also use commas (again actually [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2) characters) to pass multiple values at the same time. These have the same meaning as whitespace-delimited arguments, again with the exception of not interpreting hyphens as option names. As a stylistic advice, for scripts, use long options, the equals sign, and commas, as they tend to look clearer; whereas for simple command-line usage, take advantage of the short options and the ability to use spaces as delimiter, as both are faster to type.

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

Like the keyword arguments, also the positional arguments can be given on multiple locations, *viz.* right after the script name, anywhere after `--`, and right after `++`. These values are assigned to the defined positional arguments in their order of definition, with each of which taking as many values as defined. If there is an optional positional argument (*i.e.*, a default is given), it is only assigned a value from the command line if more values are given than necessary for the required arguments. This is the reason for `pos_1` now being set to `1` instead of `2` as hitherto; we implicitly set its value by adding a third positional argument.

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

Enter: flags. The options `-f`, aliased to `--var-6`, and `+g`, aliased to `++var-7`, are so-called flags: Their presence or absence on the command line changes their value in a boolean manner (though flags are less powerful than booleans since you can't calculate with them). As you can see in the reported values, `var_6` has changed its value from `false` to `true`, just by giving the flag's *name*, instead of a real value. This means that you can check whether a flag had been set by evaluating the corresponding variable's value to `true` or `false`. Note that these are just mnemonics, they have no boolean meaning (like upon testing in an `if..else` statement) for the weakly typed Bash interpreter.

Similarly, `var_7` has become `false` instead of the default `true`. Here, unusually, the option name was not introduced by a hyphen, but a plus sign. For flags only, it is possible to set the value to `true` by the normal hyphen, and to `false` by the plus sign, which, again, can be imagined as crossed hyphen. The default value is only taken when the flag is absent, else, their presence gives the value as `true` or `false`.

Precisely, giving `-g` or `--var-7` sets `var_7` to `true`, and giving `+g` or `++var-7` sets `var_7` to `false` (a crossed, *i.e.* negated, `true`). This behavior is used, for example, by the Bash [`set`](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html "gnu.org &rightarrow; The Set Builtin") builtin (like `set -x` to activate `xtrace` and `set +x` to deactivate it). Though the usage for long options is uncommon, it is enabled by the argparser for consistency, such that long option&ndash;only flags can be used along normal long option&ndash;only arguments.

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

Usage: try_argparser.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

The tiny change of the prefix for the `fgcA` compound argument made our whole attempt fail: Since `var_3` is not a flag, we can't use the boolean negation, here, and thus the argparser yields an error. So, although specifying `+fg` is no problem, the merged `c` makes the parsing fail. Were `g` also defined to accept a value, the argparser would have reported the error already here, since the following `cA` would have been seen as value to the option `+g`. This shows that care should be taken when merging option names.

### Argparser invokation

Now that you have seen how the argparser serves in parsing and interpreting the command-line arguments given to your script, it's time to explain what you need to do to employ the argparser in your script. As promised, here's the code of `try_argparser.sh` again. You can cover it if you already read it above (and memorize the lines of code&hellip;).

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser.  As the arguments have multiple short and long
# options, override the default column widths for the help message.
ARGPARSER_MAX_COL_WIDTH_1=9
ARGPARSER_MAX_COL_WIDTH_2=33
ARGPARSER_MAX_COL_WIDTH_3=35

# Define the arguments.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
    "var_1:a,A:var-1,var-a:VAL_1:-:-:uint:1:Mandatory options:-:one value without default or choice"
    "var_2:b,B:var-2,var-b:VAL_2:-:-:int:+:Mandatory options:-:at least one value without default or choice"
    "var_3:c,C:var-3,var-c:VAL_3:-:A,B:char:+:Mandatory options:-:at least one value with choice"
    "var_4:d,D:var-4,var-d:VAL_4:A:A,B,C:char:1:Optional options:-:one value with default and choice"
    "var_5:e,E:var-5,var-e:VAL_5:E:-:str:1:Optional options:-:one value with default"
    "var_6:f,F:var-6,var-f:VAL_6:false:-:bool:0:Optional options:-:no value (flag) with default"
    "var_7:g,G:var-7,var-g:VAL_7:true:-:bool:0:Optional options:deprecated:no value (flag) with default"
)

source argparser

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

The first section sets argparser-specific [environment variables](#environment-variables) to optimize the visual output, which we'll investigate later. Then, the arguments are defined, and finally, the argparser is called. This call is central to the script as it is the line that runs the argparser. So, most simply, from your script whose command-line arguments you want to be parsed, the main thing you need to do is to source the argparser ([sourcing](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") means in-place execution without forking):

```bash
source argparser
```

Alternatively, but not recommended for the lack of the command's clearness, you could use the synonymous [dot operator](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_002e "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; dot operator") inherited from the Bourne shell (which cannot run the argparser, which is a Bash script!):

```bash
. argparser
```

This is the simplest form of invoking the argparser. It will read your script's command line, parse the arguments, and set them to variables in your script. And this is the reason for sourcing instead of normal calling as in:

```bash
bash argparser
```

or:

```bash
./argparser
```

since you don't want the arguments to be set in a subprocess created after forking, as these will be gone when the argparser (and with it, the subprocess) exits.

You can obtain fine-grained control by the longer form of the command:

```bash
source argparser --action -- "$@"
```

with `action` being either `read`, `set`, or `all`. If `action` is `read`, then the argparser will only read the command-line arguments and parse them into an associative array you can access afterwards, denoted by the name the environment variable [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) refers to (per default, `"args"`). If the `action` is set to `set`, the options from this array are set as variables to your script. In other words, you need to `read` the arguments before you `set` them, but you can perform arbitrary steps in-between. This could come handy when you want to use the variable names the argparser sets for some task or want to manipulate the associative array prior having the values set. Finally, if the `action` is `all`, both `read` and `set` will be executed (in this order).

Due to the manner the [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") builtin is defined, you must explicitly state the `"$@"` to pass the arguments to the argparser. The `--` before is required to separate the argparser modification from the actual arguments&mdash;after all, it is not unlikely that some of your scripts might want to use one of the options `--read`, `--set`, or `--all`. To still be able to distinguish between an option for the argparser and an argument to your script, the double hyphen is used as delimiter.

Further, writing

```bash
source argparser --all -- "$@"
```

is almost identical to writing a bare

```bash
source argparser
```

but less legible. Thus, the latter form is preferred. There is one important exception to this rule, and that is configuration by environment variables. Specifying an `action` overrides the values of [`ARGPARSER_READ_ARGS`](#argparser_read_args) and [`ARGPARSER_SET_ARGS`](#argparser_set_args), which are else inherited from the sourcing script's environment (which, in turn, might inherit them from another calling script). Thus, to rule out any possible influence of the environment on `read` and `set`, the long invokation command is recommendable.

As stated, `read` sets an associative array to store the arguments in. For maximum control over the variables in your script's scope, you can configure its name via [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name), defaulting to `"args"`. In `try_argparser.sh`, we obtained the report by accessing exactly this associative array, looping over all variables known to the script that start with `var` or `pos`, respectively. At the same time, this variable name is used to provide the arguments definition.

While the single line `source argparser` provides the argparser's functionality by running it, the positional and keyword arguments need to be defined somewhere. Thus, prior to the argparser's invokation (and, in our case, after setting some environment variables to set the maximum column widths for the help message), the arguments are defined. Thereby, the indexed array `args` defines which command-line arguments are acceptable for the script, possibly giving an argument definition in an argparser-specific tabular manner. Alternatively, this definition could be given as a separate [arguments definition file](#arguments-definition-files), indicated as [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file).

The rationale for allowing `args` to store both the arguments alone and them along their definition gets clear when you realize that it's possible to share an arguments definition file across multiple scripts and only require a limited subset of the arguments for the current script. Then, you can give these arguments a common definition, identical for any script using them. Additionally, it is even possible to use an arguments definition file and definitions in `args` together, with the latter expanding on the former or overriding them, thus providing the opportunity to use arguments with the same name, but different definitions, in separate scripts. This offers great flexibility when writing wrapper scripts around pipelines, when you want to pass common arguments to different programs in your pipeline. Just define an argument within your wrapper script and pass its value to both programs.

The argument-defining entries in the indexed array named by [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name), defaulting to`"args"`, can be understood as some sort of key&ndash;value pair for each argument, but merged in one string (not as true keys and values in associative arrays). The key is a unique identifier for the argparser functions, and the name under which the argument's value can be obtained from the associative array `args`. The corresponding value provides the argument's definition to the argparser.

This argparser-specific tabular format consists of eleven columns, each separated from each other by an [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1) character, defaulting to a colon (`":"`). Multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2) character, defaulting to a comma (`","`). The columns are defined as follows:

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

If [`ARGPARSER_ARG_DEF_HAS_HEADER`](#argparser_arg_def_has_header) is set to `true`, then these names must be given as a header above all argument definitions. Providing a header has the advantage that the order of the columns does not matter, as long as the first column is the `id`. If you omit the header, the above order is mandatory.

Keyword arguments can have multiple short and/or long names, optional default values, and/or an arbitrary number of choice values. The same holds for positional arguments, which are identified by having neither short nor long option names. Generally, absence of a value is indicated by a hyphen (`"-"`). Since hyphens have a special meaning on the command line (as option names), using them for other purposes would lead to deep confusion among your script's users, and thus, they're reserved for the purpose of indicating absence.

As you saw above, the argparser will aggregate all arguments (values) given after a word starting with a hyphen (*i.e.*, an option name) to this option. If the number doesn't match the number of required values, an error is thrown instead of cutting the values. If an argument gets a wrong number of values, but has a default value, only a warning is thrown and the default value is taken.

Thereby, errors abort the script, while warnings just write a message to `STDERR`. Even after parsing or value checking errors occurred, the parsing or value checking continues and the argparser aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

### Help and usage messages

No matter how many keyword arguments are defined, as long as [`ARGPARSER_ADD_HELP`](#argparser_add_help) and [`ARGPARSER_ADD_USAGE`](#argparser_add_usage) are set to `true` (the default), the argparser interprets the flags `-h` and `--help` as call for a verbose help message and `-u` and `--usage` as call for a brief usage message. Then, these options are automatically added to the script's argument definition and override any same-named argument name (yielding an error message if [`ARGPARSER_CHECK_ARG_DEFINITION`](#argparser_check_arg_definition) is set to `true`). This is to ensure that the novice user of your script can do exactly what we did, above: trying the most common variants to get some help over how to use a program or script by typing

```bash
try_argparser.sh --help
```

or

```bash
try_argparser.sh -h
```

Of course,

```bash
help try_argparser.sh
```

won't work as the [`help`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-help "gnu.org &rightarrow; Bash Builtins &rightarrow; help") command only recognizes Bash builtins.

As a huge convenience, the argparser will build the help and usage messages from the defined arguments for your script, if either of the `-h`, `--help`, `-u`, or `--usage` options is given on the command line (even along with others). These messages indicate the short and/or long names, as well as the default and choice values. In the case of the help message, the argument group, the notes, and the help text from the arguments' definitions are printed, too.

As we already saw in upon the occasion of an error, our `try_argparser.sh` usage message looks as follows:

```console
$ bash try_argparser.sh --usage
Usage: try_argparser.sh [-h | -u | -V] [-d,-D={A,B,C}] [-e,-E=VAL_5] [-f,-F] [-g,-G] -a,-A=VAL_1 -b,-B=VAL_2... -c,-C={A,B}... [{1,2}] pos_2
```

The usage message clearly summarizes the arguments, including name aliases (always taking all short options, or, if absent, all long options, or *vice versa*), indicates whether they're optional or mandatory (optionals use square brackets), and specifies the choice values (in curly braces) and argument number (an ellipsis (`"..."`) for an infinite number). Short options precede long options, options with default precede those without, likewise for positionals, and keyword arguments precede positional arguments. All groups are sorted alphabetically by the first option name as key.

For a better overview when having lots of arguments, we can choose a columnar layout instead of the single row, using [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#argparser_usage_message_orientation):

```console
$ ARGPARSER_USAGE_MESSAGE_ORIENTATION=column bash try_argparser.sh --usage
Usage: try_argparser.sh [-h | -u | -V]
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

Additionally, we may choose to show the long options by [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#argparser_usage_message_option_type):

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
Usage: try_argparser.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1={1,2}]
                                           one positional argument with default
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
```

The help message details all short and long option names, their optionality (*i.e.*, whether there are default values), and their choice values, using the same syntax as in the usage message. Additionally, the help text and notes from the arguments definition are given. The arguments are separated by their groups, thus structuring the help message. First, the group for the positional arguments is given (indicated by [`ARGPARSER_POSITIONAL_ARG_GROUP`](#argparser_positional_arg_group)), then follow the keyword argument groups in alphabetical order. Finally, the default `--help`, `--usage`, and `--version` arguments (the latter for the [version message](#version-messages)) are given as separate, yet unnamed group.

The help message's structure aims at reproducing the commonly found structure in command-line programs. By setting [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1), [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2), and [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3) (as done in `try_argparser.sh`), the column widths may be adapted to your needs, recommendably totalling 77 characters (thus 79 characters including the separating spaces). Note that columns are automatically shrunk, when their content is narrower, but they're not expanded, when their content is wider. This is to guarantee that the help message, when *e.g.* sent as logging output, nicely fits in the space you have.

### Help and usage message files

The argparser is not only able to compile a help message, but can also be guided by a separate file. Using the [`ARGPARSER_HELP_FILE`](#argparser_help_file) environment variable, to a certain degree, you can customize the help message's look and structure by moving the blocks the message consists of around and enriching it by arbitrary text.

For demonstration, we take a stripped-down version of our `try_argparser.sh` script as `try_help_file.sh`, where we omit the alias names for the short and long options, for the sake of brevity.

<details open>

<summary>Contents of <code>try_help_file.sh</code></summary>

```bash
#!/bin/bash

# Source the argparser, reading the help message from a file.
ARGPARSER_HELP_FILE="${0%/*}/../auxfiles/help_message.txt"

# Define the arguments.
args=(
    "id:short_opts:long_opts:val_names:defaults:choices:type:arg_no:arg_group:notes:help"
    "pos_1:-:-:pos_1:2:1,2:int:1:Positional arguments:-:one positional argument with default and choice"
    "pos_2:-:-:pos_2:-:-:int:2:Positional arguments:-:two positional arguments without default or choice"
    "var_1:a:var-1:VAL_1:-:-:uint:1:Mandatory options:-:one value without default or choice"
    "var_2:b:var-2:VAL_2:-:-:int:+:Mandatory options:-:at least one value without default or choice"
    "var_3:c:var-3:VAL_3:-:A,B:char:+:Mandatory options:-:at least one value with choice"
    "var_4:d:-:VAL_4:A:A,B,C:char:1:Optional options:-:one value with default and choice"
    "var_5:-:var-5:VAL_5:E:-:str:1:Optional options:-:one value with default"
    "var_6:f:var-6:VAL_6:false:-:bool:0:Optional options:-:no value (flag) with default"
    "var_7:g:var-7:VAL_7:true:-:bool:0:Optional options:deprecated:no value (flag) with default"
)

source argparser
```

</details>

Additionally, we need a separate file, which we'll call `help_message.txt` and have passed as value to [`ARGPARSER_HELP_FILE`](#argparser_help_file). This plain-text file stores the help message's structure and can contain arbitrary additional content.

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
Usage: try_help_file.sh [OPTIONS] ARGUMENTS [--] [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

The following arguments are positional.
Positional arguments:
[pos_1={1,2}]
                      one positional argument with default and
                      choice (default: 2)
pos_2                 two positional arguments without default
                      or choice

The following options have no default value.
Mandatory options:
-a,   --var-1=VAL_1   one value without default or choice
-b,   --var-2=VAL_2   at least one value without default or
                      choice
-c,   --var-3={A,B}   at least one value with choice

The following options have a default value.
Optional options:
[-d={A,B,C}]
                      one value with default and choice
                      (default: A)
      [--var-5=VAL_5] one value with default (default: E)
[-f], [--var-6]       no value (flag) with default (default:
                      false)
[-g], [--var-7]       (DEPRECATED) no value (flag) with
                      default (default: true)

There are always three options for the help messages.
-h,   --help          display this help and exit
-u,   --usage         display the usage and exit
-V,   --version       display the version and exit
```

When you compare the structure of this help message with both the previous version and the help file, you see that there, you can include the sections from the auto-generated help message by prefixing their names with an [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#argparser_help_file_include_char) character, defaulting to an `"@"`. Generally speaking, an include directive, as the commands are referred to, like `@Section`, includes the section entitled `"Section"`.

The following section names (include directives) are supported, explained in greater detail in the reference below:

- [`@All`](#all-directive)
- [`@<ArgumentGroup>`](#argumentgroup-directive)
- [`@Header`](#header-directive)
- [`@Help`](#help-directive)

Thereby, `<ArgumentGroup>` can be the name of any argument group given in the arguments definition, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. `@Header` prints the header, `@Help` the help, usage, and version options (depending on which of them are defined by [`ARGPARSER_ADD_HELP`](#argparser_add_help), [`ARGPARSER_ADD_USAGE`](#argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#argparser_add_version)). Finally, the shorthand `@All` means to use the header, all argument groups, and the help options, in this order.

Further, lines starting with a `"#"` character in the help file aren't printed if [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#argparser_help_file_keep_comments) is set to `false` (the default). This allows you to comment your help file, perhaps to explain the structure&mdash;or just to write a header or footer with your name and debug email address inside.

The same as for help messages can be done for usage messages, using the [`ARGPARSER_USAGE_FILE`](#argparser_usage_file), [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#argparser_usage_file_include_char), and [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#argparser_usage_file_keep_comments) environment variables. However there, only the `@All` directive is supported, yet.

### Arguments definition files

In the previous sections, we always provided the arguments definition directly in the script, right before we sourced the argparser. However, it is possible to "outsource" the definition (or part of it) in a bespoke file that is referred to by the [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file) environment variable.

Using a separate arguments definition file allows you to share the definition across multiple scripts that use partially or entirely identical arguments, a common case in program suites or when wrapper scripts are used. Should some scripts require an argument to have the same name, but different definitions, they can be given in their respective scripts, in addition to the remainder from the file. Moreover, this attempt allows a separation of concerns, as we can move the arguments definition (static) away from their manipulation (dynamic). This shrinks our trial file once more, yielding `try_arg_def_file.sh`.

<details open>

<summary>Contents of <code>try_arg_def_file.sh</code></summary>

```bash
#!/bin/bash

# Set the argparser, reading the arguments definition from a file.
ARGPARSER_ARG_DEF_FILE="${0%/*}/../auxfiles/arguments.csv"

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

source argparser

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

You can (and should) add the header to explain the fields, or else need to set [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#argparser_arg_def_file_has_header) to `false`. Then, you can set your text editor to interpret the data as CSV file, possibly syntax-highlighting the columns with the given header or visually aligning the columns (as done by the [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv "Visual Studio Code &rightarrow; Marketplace &rightarrow; Rainbow CSV Extension") extension in [Visual Studio Code](https://code.visualstudio.com/ "Visual Studio Code")). Since the argparser strips leading and trailing whitespace off the fields, you can save the file with this alignment:

```console
$ cat arguments.csv
id    :short_opts :long_opts :val_names :defaults :choices :type :arg_no :arg_group            :notes      :help
pos_1 :-          :-         :pos_1     :2        :1,2     :int  :1      :Positional arguments :-          :one positional argument with default and choice
pos_2 :-          :-         :pos_2     :-        :-       :int  :2      :Positional arguments :-          :two positional arguments without default or choice
var_1 :a          :var-1     :VAL_1     :-        :-       :uint :1      :Mandatory options    :-          :one value without default or choice
var_2 :b          :var-2     :VAL_2     :-        :-       :int  :+      :Mandatory options    :-          :at least one value without default or choice
var_3 :c          :var-3     :VAL_3     :-        :A,B     :char :+      :Mandatory options    :-          :at least one value with choice
var_4 :d          :-         :VAL_4     :A        :A,B,C   :char :1      :Optional options     :-          :one value with default and choice
var_5 :-          :var-5     :VAL_5     :E        :-       :str  :1      :Optional options     :-          :one value with default
var_6 :f          :var-6     :VAL_6     :false    :-       :bool :0      :Optional options     :-          :no value (flag) with default
var_7 :g          :var-7     :VAL_7     :true     :-       :bool :0      :Optional options     :deprecated :no value (flag) with default
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

Likewise, the usage (and help) message is completely unaffected:

```console
$ bash try_arg_def_file.sh -u
Usage: try_arg_def_file.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```

### Help and usage message localization

It is even possible to localize your script's help and usage message. For the usage message, all you need is an [`ARGPARSER_TRANSLATION_FILE`](#argparser_translation_file), a simplified YAML file giving the translation of the auto-generated parts in the messages. For each section, you give the language identifier for the language you want the message to be translated to, *i.e.*, the [`ARGPARSER_LANGUAGE`](#argparser_language). For the usage message, this suffices, but in the help message, also non-auto-generated parts are included, especially each argument's help text. For them to be translated, you need a dedicated [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file) and possibly a localized [`ARGPARSER_HELP_FILE`](#argparser_help_file).

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
ARGPARSER_ARG_DEF_FILE="${0%/*}/../auxfiles/arguments_${LANG::2}.csv"
ARGPARSER_ARG_DEF_FILE_HAS_HEADER=false
ARGPARSER_HELP_FILE="${0%/*}/../auxfiles/help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="${0%/*}/../auxfiles/translation.yaml"

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

source argparser
```

</details>

You need to manually translate the arguments definition (only the argument groups and the help texts) in the new arguments definition file, here shown as using no header (stated by the [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#argparser_arg_def_file_has_header) environment variable):

```console
$ cat arguments_de.csv
pos_1 :- :-     :pos_1 :2     :1,2   :int  :1 :Positionale Argumente  :-          :ein positionales Argument mit Vorgabe und Auswahl
pos_2 :- :-     :pos_2 :-     :-     :int  :2 :Positionale Argumente  :-          :zwei positionale Argumente ohne Vorgabe oder Auswahl
var_1 :a :var-1 :VAL_1 :-     :-     :uint :1 :Erforderliche Optionen :-          :ein Wert ohne Vorgabe oder Auswahl
var_2 :b :var-2 :VAL_2 :-     :-     :int  :+ :Erforderliche Optionen :-          :mindestens ein Wert ohne Vorgabe oder Auswahl
var_3 :c :var-3 :VAL_3 :-     :A,B   :char :+ :Erforderliche Optionen :-          :mindestens ein Wert mit Auswahl
var_4 :d :-     :VAL_4 :A     :A,B,C :char :1 :Optionale Optionen     :-          :ein Wert mit Vorgabe und Auswahl
var_5 :- :var-5 :VAL_5 :E     :-     :str  :1 :Optionale Optionen     :-          :ein Wert mit Vorgabe
var_6 :f :var-6 :VAL_6 :false :-     :bool :0 :Optionale Optionen     :-          :kein Wert (Flag) mit Vorgabe
var_7 :g :var-7 :VAL_7 :true  :-     :bool :0 :Optionale Optionen     :deprecated :kein Wert (Flag) mit Vorgabe
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

```yaml
$ cat translation.yaml
# 1.    Define the translations for the arguments parsing.
---
Positional arguments:
  en: Positional arguments
  de: Positionale Argumente
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
  en: Mandatory arguments to long options are mandatory for short options too
  de: >
    Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich
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

Regarding the structure of the simplified and strictly line-oriented YAML file, the groups used as identifiers for the translations are given without indentation, followed by a colon. This creates a key in an associative array. The respective value is another associative array, this time holding the translation, with the language identifier as key and the translated string as value. The key must be indented by exactly two spaces, followed by a colon and another space. Then, either the translation can be given or a greater-than sign (`">"`). All lines given afterwards that are indented by exactly four spaces are concatenated and used as translated string. In the translation, you can (and should) use the format specifier `%s` to denote the positions that the argparser should use for the interpolation with variable values, which cannot be directly given in the translation.

You can optionally add line comments, though not in-line comments, and structure the file using empty lines or YAML blocks with three hyphens (`"---"`) or three dots (`"..."`). Since the purpose of the YAML file is to store a translation, not to serialize arbitrary data, more advanced features (like JSON-like in-line associative arrays) aren't supported by the argparser, and an error is thrown for unrecognized structures.

If a group identifier is missing, the argparser will emit a warning if and only if the state which uses the translation is reached, most commonly when the user requests the help message. In order not to miss a key, you can simply re-use the YAML file provided with the argparser.

Now, the argparser is provided with the arguments definition, help, and translation file for the current locale. Thus, the help message can be generated in localized form, according to the user's `LANG`.

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
Aufruf: try_localization.sh [OPTIONEN] ARGUMENTE [--] [pos_1] pos_2

Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich.

Die folgenden Argumente sind positional.
Positionale Argumente:
[pos_1={1,2}]
                      ein positionales Argument mit Vorgabe
                      und Auswahl (Vorgabe: 2)
pos_2                 zwei positionale Argumente ohne Vorgabe
                      oder Auswahl

Die folgenden Optionen haben keinen Vorgabewert.
Erforderliche Optionen:
-a,   --var-1=VAL_1   ein Wert ohne Vorgabe oder Auswahl
-b,   --var-2=VAL_2   mindestens ein Wert ohne Vorgabe oder
                      Auswahl
-c,   --var-3={A,B}   mindestens ein Wert mit Auswahl

Die folgenden Optionen haben einen Vorgabewert.
Optionale Optionen:
[-d={A,B,C}]
                      ein Wert mit Vorgabe und Auswahl
                      (Vorgabe: A)
      [--var-5=VAL_5] ein Wert mit Vorgabe (Vorgabe: E)
[-f], [--var-6]       kein Wert (Flag) mit Vorgabe (Vorgabe:
                      falsch)
[-g], [--var-7]       (VERALTET) kein Wert (Flag) mit Vorgabe
                      (Vorgabe: wahr)

Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
-h,   --help          diese Hilfe anzeigen und beenden
-u,   --usage         den Aufruf anzeigen und beenden
-V,   --version       die Version anzeigen und beenden
```

Likewise, the usage message is localized:

```console
$ LANG=de_DE.UTF-8 bash try_localization.sh -u
Aufruf: try_localization.sh [-h | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```

### Version messages

Besides the `-h`, `--help`, `-u`, and `--usage` flags, there is a third option intended to help the user, `-V` and `--version`. This option compiles a brief version message for your script, showing its canonical name (the [`ARGPARSER_SCRIPT_NAME`](#argparser_script_name)) and the version number (the [`ARGPARSER_VERSION`](#argparser_version)). Just as for the help and usage messages, you can disable the version message (and its corresponding flags) by setting [`ARGPARSER_ADD_VERSION`](#argparser_add_version) to `false`. Note that the short option name is an uppercase `V`, such that you can use the lowercase `v` (as `-v`) for your purposes, like `--verbatim` or `--verbose`. This is in line with the common behavior of command-line programs.

The output version message is very simple:

```console
$ bash try_argparser.sh -V
try_argparser.sh v1.0.0
```

### Message styles

It is possible to customize the appearance of error, warning, help, usage, and version messages using the respective environment variable, *viz.*, [`ARGPARSER_ERROR_STYLE`](#argparser_error_style), [`ARGPARSER_WARNING_STYLE`](#argparser_warning_style), [`ARGPARSER_HELP_STYLE`](#argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#argparser_usage_style), and [`ARGPARSER_VERSION_STYLE`](#argparser_version_style). Using [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters"), messages can be colorized and stylized. This is especially useful to quickly see errors when logging, but requires that the terminal or text editor, with which you opened the log file, supports interpreting the escape codes. This is, *e.g.*, supported by `less --raw-control-chars <filename>`.

When [`ARGPARSER_USE_STYLES_IN_FILES`](#argparser_use_styles_in_files) is set to `false`, the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, keeping files plain 7-bit ASCII for simpler parsing. Note that, when your arguments definition or help file includes non-ASCII characters (as is usual for almost any language other than English varieties), the output contains these characters as well.

A number of colors and styles is available. You don't need to remember the SGR codes, they're only internally used and given here for reference of what to expect from the keywords for the colors and styles. Further note that the actual RGB/Hex color values will depend on the output device.

| color                                   | SGR code |
|-----------------------------------------|----------|
| $\small\textsf{\color{black}black}$     | `30`     |
| $\small\textsf{\color{red}red}$         | `31`     |
| $\small\textsf{\color{green}green}$     | `32`     |
| $\small\textsf{\color{orange}yellow}$   | `33`     |
| $\small\textsf{\color{blue}blue}$       | `34`     |
| $\small\textsf{\color{magenta}magenta}$ | `35`     |
| $\small\textsf{\color{cyan}cyan}$       | `36`     |
| $\small\textsf{\color{lightgray}white}$ | `37`     |

| style         | SGR code |
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

## Include directives

The following section names (include directives) are supported in the help and usage files (with `"@"` being the default character of the [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#argparser_help_file_include_char) and [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#argparser_usage_file_include_char)):

- [`@All`](#all-directive)
- [`@<ArgumentGroup>`](#argumentgroup-directive)
- [`@Header`](#header-directive)
- [`@Help`](#help-directive)

Thereby, `<ArgumentGroup>` can be the name of any argument group given in the arguments definition, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`.

### `@All` directive

The `@All` directive comprises all include directives in the following order: [`@Header`](#header-directive), [`@<ArgumentGroup>`](#argumentgroup-directive), and [`@Help`](#help-directive), separated from each other by a blank line.

Consequently, the help message generated from the [`ARGPARSER_HELP_FILE`](#argparser_help_file) with the following content:

```text
@All
```

is exactly identical to the one from the following content:

```text
@Header

@<ArgumentGroup>

@Help
```

(note the blank lines), and indentical to the auto-generated help message.

### `@<ArgumentGroup>` directive

The `@<ArgumentGroup>` directive prints the help text for the respective `"<ArgumentGroup>"`, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. Their order in the auto-generated help message would be alphabetical. Thus, if you have reasons for another structure, you need an [`ARGPARSER_HELP_FILE`](#argparser_help_file), denoting all arguments groups in the order preferred by you.

### `@Header` directive

The `@Header` directive prints the line `Usage: <script_name> ...` (with `<script_name>` replaced by [`ARGPARSER_SCRIPT_NAME`](#argparser_script_name), defaulting to your script's name) and a note that mandatory arguments to long options are mandatory for short options too. This should be given just before all arguments.

### `@Help` directive

The `@Help` directive prints the help text for the `--help`, `--usage`, and `--version` flags (if added to the arguments definition by [`ARGPARSER_ADD_HELP`](#argparser_add_help), [`ARGPARSER_ADD_USAGE`](#argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#argparser_add_version)). Usually, you want to give this at the very end of all options.

## Environment variables

The argparser defines a large set of environment variables, each following the naming pattern `"ARGPARSER_*"`. They are used to control the behavior of the argument parsing, help and usage message generation, and much more. Note that, if for some reason you're script or environment is using a variable with the same name as one of the argparser variables, the argparser might not work as expected. If you want to be 100&#8239;% safe, you can unset any variable following the given pattern prior setting any desired argparser variables and sourcing the argparser&mdash;with the caveat that in turn the program that set the variable might not work, anymore.

### Overview over environment variables

| Variable name                                                                 | Allowed values or type[^1][^2][^3] | Default value            |
|-------------------------------------------------------------------------------|------------------------------------|--------------------------|
| [`ARGPARSER_ADD_HELP`](#argparser_add_help)                                   | *bool*                             | `true`                   |
| [`ARGPARSER_ADD_USAGE`](#argparser_add_usage)                                 | *bool*                             | `true`                   |
| [`ARGPARSER_ADD_VERSION`](#argparser_add_version)                             | *bool*                             | `true`                   |
| [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](#argparser_allow_option_abbreviation) | *bool*                             | `false`                  |
| [`ARGPARSER_ALLOW_OPTION_MERGING`](#argparser_allow_option_merging)           | *bool*                             | `false`                  |
| [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name)                       | *str*[^4]                          | `"args"`                 |
| [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file)                           | *filepath* \| `""`                 | `""`                     |
| [`ARGPARSER_ARG_DEF_FILE_HAS_HEADER`](#argparser_arg_def_file_has_header)     | *bool*                             | `true`                   |
| [`ARGPARSER_ARG_DEF_HAS_HEADER`](#argparser_arg_def_has_header)               | *bool*                             | `true`                   |
| [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1)                     | *char*                             | `":"`[^5]                |
| [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2)                     | *char*                             | `","`[^5]                |
| [`ARGPARSER_CHECK_ARG_DEFINITION`](#argparser_check_arg_definition)           | *bool*                             | `false`                  |
| [`ARGPARSER_CHECK_ENV_VARS`](#argparser_check_env_vars)                       | *bool*                             | `false`                  |
| [`ARGPARSER_COUNT_FLAGS`](#argparser_count_flags)                             | *bool*                             | `false`                  |
| [`ARGPARSER_DICTIONARY`](#argparser_dictionary)                               | *dict*                             | *None* (unset)           |
| [`ARGPARSER_ERROR_EXIT_CODE`](#argparser_error_exit_code)                     | *int*                              | `1`                      |
| [`ARGPARSER_ERROR_STYLE`](#argparser_error_style)                             | *str*                              | `"red,bold,reverse"`     |
| [`ARGPARSER_HELP_EXIT_CODE`](#argparser_help_exit_code)                       | *int*                              | `0`                      |
| [`ARGPARSER_HELP_FILE`](#argparser_help_file)                                 | *filepath* \| `""`                 | `""`                     |
| [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](#argparser_help_file_include_char)       | *char*                             | `"@"`                    |
| [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](#argparser_help_file_keep_comments)     | *bool*                             | `false`                  |
| [`ARGPARSER_HELP_STYLE`](#argparser_help_style)                               | *str*                              | `"italic"`               |
| [`ARGPARSER_LANGUAGE`](#argparser_language)                                   | *str*                              | `"en"`                   |
| [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1)                     | *uint*                             | `5`[^6]                  |
| [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2)                     | *uint*                             | `33`[^6]                 |
| [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3)                     | *uint*                             | `39`[^6]                 |
| [`ARGPARSER_POSITIONAL_ARG_GROUP`](#argparser_positional_arg_group)           | *str*                              | `"Positional arguments"` |
| [`ARGPARSER_READ_ARGS`](#argparser_read_args)                                 | *bool*                             | `true`                   |
| [`ARGPARSER_SCRIPT_NAME`](#argparser_script_name)                             | *str*                              | `"${0##*/}"`             |
| [`ARGPARSER_SET_ARGS`](#argparser_set_args)                                   | *bool*                             | `true`                   |
| [`ARGPARSER_SET_ARRAYS`](#argparser_set_arrays)                               | *bool*                             | `true`                   |
| [`ARGPARSER_SILENCE_ERRORS`](#argparser_silence_errors)                       | *bool*                             | `false`                  |
| [`ARGPARSER_SILENCE_WARNINGS`](#argparser_silence_warnings)                   | *bool*                             | `false`                  |
| [`ARGPARSER_TRANSLATION_FILE`](#argparser_translation_file)                   | *filepath* \| `""`                 | `""`                     |
| [`ARGPARSER_UNSET_ARGS`](#argparser_unset_args)                               | *bool*                             | `true`                   |
| [`ARGPARSER_UNSET_ENV_VARS`](#argparser_unset_env_vars)                       | *bool*                             | `true`                   |
| [`ARGPARSER_UNSET_FUNCTIONS`](#argparser_unset_functions)                     | *bool*                             | `true`                   |
| [`ARGPARSER_USAGE_EXIT_CODE`](#argparser_usage_exit_code)                     | *int*                              | `0`                      |
| [`ARGPARSER_USAGE_FILE`](#argparser_usage_file)                               | *filepath* \| `""`                 | `""`                     |
| [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](#argparser_usage_file_include_char)     | *char*                             | `"@"`                    |
| [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](#argparser_usage_file_keep_comments)   | *bool*                             | `false`                  |
| [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#argparser_usage_message_option_type) | *str*                              | `"short"`                |
| [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](#argparser_usage_message_orientation) | *str*                              | `"row"`                  |
| [`ARGPARSER_USAGE_STYLE`](#argparser_usage_style)                             | *str*                              | `"italic"`               |
| [`ARGPARSER_USE_STYLES_IN_FILES`](#argparser_use_styles_in_files)             | *bool*                             | `false`                  |
| [`ARGPARSER_VERSION`](#argparser_version)                                     | *str*                              | `"1.0.0"`                |
| [`ARGPARSER_VERSION_EXIT_CODE`](#argparser_version_exit_code)                 | *int*                              | `0`                      |
| [`ARGPARSER_VERSION_STYLE`](#argparser_version_style)                         | *str*                              | `"bold"`                 |
| [`ARGPARSER_WARNING_STYLE`](#argparser_warning_style)                         | *str*                              | `"red,bold"`             |

[^1]: Bash is weakly typed, hence the denoted types are just a guidance.
[^2]: Strings can optionally be enclosed by quotes.
[^3]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^4]: In fact, any legit Bash variable identifier.
[^5]: Values must be different from each other.
[^6]: Sum of values is recommended to be 77.

### `ARGPARSER_ADD_HELP`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add `-h` and `--help` as flags to call the help message.

### `ARGPARSER_ADD_USAGE`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add `-u` and `--usage` as flags to call the usage message.

### `ARGPARSER_ADD_VERSION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add `-V` and `--version` as flags to call the version message.

### `ARGPARSER_ALLOW_OPTION_ABBREVIATION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give long option names in abbreviated form, *e.g.*, `--verb` for `--verbatim`, as long as no collision with *e.g.* `--verbose` arises. Short option names only span one character and thus cannot be abbreviated.

### `ARGPARSER_ALLOW_OPTION_MERGING`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give short option names in merged (concatenated) form, *e.g.*, `-ab1` or `-ab=1` for `-a -b 1`. The individual characters are interpreted as option names until an option has a number of required arguments greater than zero, *i.e.*, until an option is no flag. Long option names span multiple characters and thus cannot be merged in a meaningful way.

### `ARGPARSER_ARG_ARRAY_NAME`

- ***Type:*** *str* (String), but only characters allowed in a legit Bash variable identifier
- ***Allowed values:*** Any legit Bash variable identifier
- ***Default value:*** `"args"`
- ***Description:*** The name of an indexed array, under which the arguments are provided, and of an associative array, under which the parsed arguments can be accessed. The former stores the argument's identifier as key and its definition as value, but joined to one string by an [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1) character, the latter stores the identifier as key its values as value. If [`ARGPARSER_SET_ARGS`](#argparser_set_args) is `true`, you usually don't need to access this array as the arguments will be set as variables.

### `ARGPARSER_ARG_DEF_FILE`

- ***Type:*** *filepath* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the definition of the arguments. This file may be used by multiple scripts if they share some arguments. It is not necessary to use all arguments from there, as you need to specify which arguments you want to use. It is possible to set additional argument definitions within the script, which could come handy when scripts share some arguments (from the file), but also use some own arguments (from the script), whose names have another meaning in the companion script.

### `ARGPARSER_ARG_DEF_FILE_HAS_HEADER`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether the arguments definition file has a header explaining the columns. This is only evaluated if an [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file) is given.

### `ARGPARSER_ARG_DEF_HAS_HEADER`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether the arguments definition in your script has a header explaining the columns.

### `ARGPARSER_ARG_DELIMITER_1`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2), no hyphen (`-`), no plus sign (`+`)
- ***Default value:*** `":"`
- ***Description:*** The primary delimiter that separates the fields in the arguments definition. Though you don't need to access this variable, you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_ARG_DELIMITER_2`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1), no hyphen (`-`), no plus sign (`+`)
- ***Default value:*** `","`
- ***Description:*** The secondary delimiter that separates the elements of sequences in the arguments definition. Again, you don't need to access this variable, but you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_CHECK_ARG_DEFINITION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the arguments definition is consistent, *i.e.*, if there is at most one optional positional argument, if there is at most one positional argument with an infinite number of accepted values, if any keyword argument has at least one short or long option name given, with a length of exactly one or at least two characters, and no duplicate names (within its own definition and among all other arguments), if the number of default values equals the number of required values, if the default values lie in the choice values, if flags have a default value of `true` or `false` and no choice values, and if the choice and default values accord to the data type. This should only be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the arguments definition at some point (not recommended as it may lead to code injection!), you should activate it.

### `ARGPARSER_CHECK_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the argparser environment variables accord to their definition. Again, this should only be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the environment variables at some point (not recommended as it may lead to code injection!), you should activate it.

### `ARGPARSER_COUNT_FLAGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to count flags instead of setting them to `true` or `false` based on the last prefix used on the command line. When `ARGPARSER_COUNT_FLAGS` is set to `false`, `-a -a +a` would result in `a` being set to `false`, since the last prefix was a plus sign. When `ARGPARSER_COUNT_FLAGS` is set to `true` instead, `a` would be set to `1`, as any `true` (hyphen) increases the count by `1` and any `false` (plus sign) decreases it by `1`. Flags that are absent from the command line are assigned `1` if their default value is `true`, and `-1` if their default value is `false`. This results in the same behavior when a flag is `true` per default and absent, or set with `-a` (yielding `a = 1`); or when a flag is `false` per default and absent, or set with `+a` (yielding `a = -1`). Counting flags can be helpful when, *e.g.*, different levels of verbosity are allowed. If [`ARGPARSER_ALLOW_OPTION_MERGING`](#argparser_allow_option_merging) is also set to `true`, the user can give `-vvv` on the command line for the third level of verbosity (given it's handled by your script).

### `ARGPARSER_DICTIONARY`

- ***Type:*** *dict* (Dictionary / Associative array)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The associative array in which to store the translation from the [`ARGPARSER_TRANSLATION_FILE`](#argparser_translation_file) for the [`ARGPARSER_LANGUAGE`](#argparser_language). This array *must not be set* by your script, else, an error is thrown. The argparser will declare it, but you can use it afterwards, if necessary (and [`ARGPARSER_UNSET_ENV_VARS`](#argparser_unset_env_vars) is set to `false`).

### `ARGPARSER_ERROR_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually not zero
- ***Default value:*** `1`
- ***Description:*** The exit code when errors occurred upon parsing.

### `ARGPARSER_ERROR_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any comma-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold,reverse"`
- ***Description:*** The color and style specification to use for error messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

### `ARGPARSER_HELP_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a help message was requested using the `-h` or `--help` flag.

### `ARGPARSER_HELP_FILE`

- ***Type:*** *filepath* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended help message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated help message (invoked with the flag `-h` or `--help`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

### `ARGPARSER_HELP_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_HELP_FILE`](#argparser_help_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_HELP_FILE`](#argparser_help_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the help file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_HELP_FILE` is given.

### `ARGPARSER_HELP_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the help file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.* `#`) in the help file also in the help message. This is only evaluated if an [`ARGPARSER_HELP_FILE`](#argparser_help_file) is given.

### `ARGPARSER_HELP_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any comma-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for help messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

### `ARGPARSER_LANGUAGE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"en"`
- ***Description:*** The language in which to localize the help and usage messages.

### `ARGPARSER_MAX_COL_WIDTH_1`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `5`
- ***Description:*** The maximum column width of the first column in the generated help message. This column holds the short options of the arguments, hence, it can be rather narrow. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_1`. If it is less wide, the column is shrunk accordingly.  
It is recommendable to have a total width of the help message of 79 characters. As one space is always inserted as separation between the first and second, as well as the second and third column, the sum of `ARGPARSER_MAX_COL_WIDTH_1`, [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2), and [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3) should equal 77. As long options are longer than short options, the second column should be far wider than the first. The help text in the third column consists of human-readable words and is thus less bound to word wrapping restrictions. By this, it is easier to set the third column's width to 77 characters minus the total width of the unwrapped first two columns to get an optimized help message layout.

### `ARGPARSER_MAX_COL_WIDTH_2`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `33`
- ***Description:*** The maximum column width of the second column in the generated help message. This column holds the long options of the arguments, hence, it should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_2`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1).

### `ARGPARSER_MAX_COL_WIDTH_3`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `39`
- ***Description:*** The maximum column width of the third column in the generated help message. This column holds the help text of the arguments, hence, it should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_3`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1).

### `ARGPARSER_POSITIONAL_ARG_GROUP`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"Positional arguments"`
- ***Description:*** The name of the argument group holding all positional arguments. This group is the first in the help message.

### `ARGPARSER_READ_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to read the arguments from the command line (*i.e.*, from `"$@"`) and parse them to the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) sets. Setting `ARGPARSER_READ_ARGS` is the same as calling `source argparser --read -- "$@"`. If set along [`ARGPARSER_SET_ARGS`](#argparser_set_args), it is the same as calling `source argparser --all -- "$@"` or a bare `source argparser`.  
The main difference is that, if you `export` (or `declare -x`) the variables to child processes (like scripts called from your master script), they will inherit these environment variables. If, in your child script, you use a bare `source argparser`, *i.e.*, without specifying an action to the argparser, the setting from the inherited environment variables will be used. You can always override them by specifying an action. By this, you may set the environment variables in your master script and use the settings in some child scripts, with the others setting their own action.

### `ARGPARSER_SCRIPT_NAME`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"${0##*/}"`
- ***Description:*** The name of your script as it should appear in the help, usage, and version messages. By default, it is the name used upon invoking your script (`"$0"`), trimmed by everything before the last slash character (mimicking the behavior of `basename`). If, for example, you want to give your script a symlink, but don't want this symlink's name to be used in the help and usage messages, then you can provide a custom, canonicalized `ARGPARSER_SCRIPT_NAME`. Alternatively, if your script forms a sub-part of a larger program, it may be named `program_part.sh`, but should be called as `program name [ARGUMENTS]`. Then, `program.sh` could parse its positional argument `name` and call `program_part.sh`, but on the command line, you want to hide this implementation detail and refer to `program_part.sh` as `program name`, so you set `ARGPARSER_SCRIPT_NAME` accordingly.

### `ARGPARSER_SET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set the (read and parsed) arguments from the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) refers to as variables in the calling script's scope. Setting `ARGPARSER_SET_ARGS` is the same as calling `source argparser --set -- "$@"`. If set along [`ARGPARSER_READ_ARGS`](#argparser_read_args), it is the same as calling `source argparser --all -- "$@"` or a bare `source argparser`. For details, refer to [`ARGPARSER_READ_ARGS`](#argparser_read_args).

> [!CAUTION]
> The argparser performs no complex sanity checks for argument values! Automatically setting them as variables to the script is prone to command injection!

### `ARGPARSER_SET_ARRAYS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set arguments intended to have multiple values as indexed array. This is only evaluated if [`ARGPARSER_SET_ARGS`](#argparser_set_args) is `true`. While it can be very helpful in a script to have the multiple values already set to an array that can be iterated over, the drawback is that arrays are hard to transfer to other scripts and may need to be serialized. Since they come in serialized form from the argparser, a temporary expansion to an array would be unnecessary.

### `ARGPARSER_SILENCE_ERRORS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of error messages. This should rarely be needed since the argparser still stops running after a critical failure (which is the reason for error messages), but may clean up your output when logging. See also [`ARGPARSER_SILENCE_WARNINGS`](#argparser_silence_warnings).

### `ARGPARSER_SILENCE_WARNINGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of warning messages. Like [`ARGPARSER_SILENCE_ERRORS`](#argparser_silence_errors), this should rarely be needed, but as the argparser continues running after a non-critical failure (which is the reason for warning messages), these messages may not strictly be required for your script's user.

### `ARGPARSER_TRANSLATION_FILE`

- ***Type:*** *filepath* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a simplified YAML file holding the translation of auto-generated parts in the help and usage messages. This file can be used by multiple scripts. As a YAML file, it contains the translation in a key&ndash;value layout, separated by colons and using significant indentation. Each group key must specify the language identifier used for the [`ARGPARSER_LANGUAGE`](#argparser_language). As many languages as desired can be given, which allows the localization for multiple languages with just one `ARGPARSER_TRANSLATION_FILE`. The rows can be in any order.

### `ARGPARSER_UNSET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) all command-line arguments given to the script. This is usually what you want, as the argparser re-sets these values in parsed form.

### `ARGPARSER_UNSET_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) argparser environment variables from the environment. As long as you don't need these variables anymore or want to reset them prior to the next argparser invokation, this is usually what you want. This prevents accidental (but also deliberate) inheritance to child scripts when passing the entire environment to them.

### `ARGPARSER_UNSET_FUNCTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) argparser functions from the environment. You should not need them separate from an argparser invokation, where they're automatically defined (set) upon sourcing it. By unsetting them, the namespace is kept clean.

### `ARGPARSER_USAGE_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a usage message was requested using the `-u` or `--usage` flag.

### `ARGPARSER_USAGE_FILE`

- ***Type:*** *filepath* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended usage message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated usage message (invoked with the flag `-u` or `--usage`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

### `ARGPARSER_USAGE_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_USAGE_FILE`](#argparser_usage_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_USAGE_FILE`](#argparser_usage_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the usage file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_USAGE_FILE` is given.

### `ARGPARSER_USAGE_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the usage file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.* `"#`) in the usage file also in the usage message. This is only evaluated if an [`ARGPARSER_USAGE_FILE`](#argparser_usage_file) is given.

### `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"long"` and `"short"`
- ***Default value:*** `"short"`
- ***Description:*** Whether to use short or long option names in usage messages. If an option doesn't have short option names, its long option names are used, and *vice versa*.

### `ARGPARSER_USAGE_MESSAGE_ORIENTATION`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"row"` and `"column"`
- ***Default value:*** `"row"`
- ***Description:*** Whether to output the positional and keyword arguments in usage messages in a row or in a column.

### `ARGPARSER_USAGE_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any comma-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for usage messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

### `ARGPARSER_USE_STYLES_IN_FILES`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to use the colors and styles from [`ARGPARSER_ERROR_STYLE`](#argparser_error_style), [`ARGPARSER_WARNING_STYLE`](#argparser_warning_style), [`ARGPARSER_HELP_STYLE`](#argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#argparser_usage_style), and [`ARGPARSER_VERSION_STYLE`](#argparser_version_style) when `STDOUT`/`STDERR` is not a terminal (and thus perhaps a file). This is useful to get plain 7-bit ASCII text output for files, while in interactive sessions, the escape sequences offer more user-friendly formatting and highlighting possibilities. By this, you can parse your files afterwards more easily. Still, using *e.g.* `less --raw-control-chars <filename>`, these escape sequences can be displayed from files, when included.

### `ARGPARSER_VERSION`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"1.0.0"`
- ***Description:*** The version number of your script to be used in the version message. Prefer using [semantic versioning](https://semver.org/ "semver.org"), *i.e.*, give version numbers by major version, minor version, and patch, separated by dots.

### `ARGPARSER_VERSION_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a version message was requested using the `-V` or `--version` flag.

### `ARGPARSER_VERSION_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any comma-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"bold"`
- ***Description:*** The color and style specification to use for version messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

### `ARGPARSER_WARNING_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any comma-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold"`
- ***Description:*** The color and style specification to use for warning messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").
