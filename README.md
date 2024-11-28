# Argparser

The argparser is a designed to be a simple, yet powerful argument parser for your Bash scripts. It is entirely written in pure Bash, without invoking external commands, reducing dependencies.

## Features

The argparser:

* parses a script's arguments
* gives proper error messages for wrongly set arguments
* assigns the values to the respective variables
* creates and prints a help or usage message
* can be configured to your needs by a set of environment variables

## Installation

> [!WARNING]
> Requires Bash 5 or higher (try `bash --version`). Tested with `bash 5.2.21` (`GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`).

No actual installation isn necessary, as the argparser is just a Bash script that can be located in an arbitrary directory of your choice, like `/usr/local/bin`.  Thus, the "installation" is as simple as cloning the repository in this very directory:

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Steinedieb/shell_argparser.git
```

To be able to refer to the argparser directly by its name, without providing the entire path (which enhances the portability of your script), you may want to add

```bash
export PATH="/path/to/shell_argparser:${PATH}"
```

(replace the `/path/to` with your actual path) to either of the following files (see `man bash`):

* `~/.profile` (local addition, for login shells)
* `~/.bashrc` (local addition, for non-login shells)
* `/etc/profile` (global addition, for login shells)
* `/etc/bash.bashrc` (global addition, for non-login shells)

Be wary not to forget the final `${PATH}` component in the above command, or else you will override the `PATH` for your active shell, meaning no other (non-builtin) command will be resolvable.

## Usage

Source the argparser with `source argparser.sh` (or `source argparser.sh --action -- "$@"`, with `action` being either `read`, `set`, or `all`) inside the script whose arguments need to be parsed.  If `${ARGPARSER_READ_ARGS}` is set to `true` (which per default is), the arguments will be parsed upon sourcing, else, the respective functions need to be called.  If `${ARGPARSER_SET_ARGS}` is set to `true` (which per default is), the arguments will be set to variables upon sourcing, else, the associative array `${args}` needs to be accessed.

## Example usage

```bash
# 1.    Source the argparser without reading the arguments from a file.
#       As the arguments have multiple short and long options, override
#       the default column widths for the help message.
export ARGPARSER_ARG_DEF_FILE=""
export ARGPARSER_MAX_COL_WIDTH_1=9
export ARGPARSER_MAX_COL_WIDTH_2=33
export ARGPARSER_MAX_COL_WIDTH_3=35

# 2.    Define the arguments.
args=(
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
)

declare -A args_definition
args_definition=(
    [var_1]="a,A:var_1,var_A:-:-:1:Arguments:one value without default or choice"
    [var_2]="b,B:var_2,var_B:-:-:+:Arguments:at least one value without default or choice"
    [var_3]="c,C:var_3,var_C:-:A,B:+:Arguments:at least one value with choice"
    [var_4]="d,D:-:A:A,B,C:1:Options:one value with default and choice"
    [var_5]="-:var_5,var_E:E:-:1:Options:one value with default"
    [var_6]="f,F:var_6,var_F:false:-:0:Options:no value (flag) with default"
)
source argparser.sh

# 3.    The arguments can now be accessed as keys and values of the
#       associative array "args".  Further, they are set as variables
#       to the environment.  If positional arguments were given, they
#       are set to $@.
for arg in "${!args[@]}"; do
    printf "The variable \"%s\" equals \"%s\".\n" "${arg}" "${args[${arg}]}"
done | sort

if [[ -n "$1" ]]; then
    printf "%s\n" "$@"
fi
```

As you can see, you need to source the argparser, possibly after adjusting some of the argparser environment variables (here to prevent the auto-reading from the non-existent arguments definition file and to set the maximum column widths for the help message), and then define the arguments.  Even though you may choose another way, as long as the input to `argparser_main` keeps the same structure, this is the recommended way.

The argument-defining associative array consists of a key (which is nothing more than a unique identifier for the argparser functions) and a value.  The latter consists of seven columns, each separated by a colon (":") from each other.  The first column defines the short options (one hyphen), the second the long options (two hyphens), the third the default value, the fourth the choice values for options with a limited set of values to choose from, the fifth the number of required values (either numerical from 0 to infinity or "+", meaning to accept as many values as given, at least one), the sixth the argument group for grouping of arguments in the help text, and the seventh the help text for the `--help` flag.

Arguments can have multiple short and/or long names, a default value and/or an arbitrary number of choice values.

The argparser will aggregate all values given after a word starting with a hyphen to this argument.  If the number doesn't match the number of required values, an error is thrown instead of cutting the values.  If an argument gets a wrong number of values, but has a default value, only a warning is thrown and the default value is taken.

Even after errors occurred, the parsing continues and aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

No matter how many arguments are defined (even with the same name), the argparser interprets the arguments `-u` and `--usage` as call for a usage message and `-h` and `--help` as call for a help message.  These arguments are always added to the script's argument definition.

Further, all values given after `--` are interpreted as values to positional arguments, and, if `${ARGPARSER_SET_ARGS}` is set to `true`, are assigned to the script's `$@`, with the previous values being discarded.

As many arguments may be given as desired (*i.e.*, the same argument can be called multiple times), with the values given afterwards being all assigned to the respective argument.

The argparser will build the help and usage messages from the arguments, indicating the short and long names, the default and choice values, as well as the argument group, and print the help text from the arguments' definitions.

## Environment variables

| Variable name | Allowed values or type[^1] | Default value |
| --- | --- | --- |
| `ARGPARSER_ACTION` | `"read"` \| `"set"` \| `"all"` | `"all"` |
| `ARGPARSER_ARG_ARRAY_NAME` | *str*[^2] | `"args"` |
| `ARGPARSER_ARG_DEF_FILE` | *filepath* \| `""` | `"arguments.lst"` |
| `ARGPARSER_ARG_DELIMITER_1` | *str* | `"\|"`[^3] |
| `ARGPARSER_ARG_DELIMITER_2` | *str* | `":"`[^3] |
| `ARGPARSER_ARG_DELIMITER_3` | *str* | `","`[^3] |
| `ARGPARSER_ARG_GROUP_DELIMITER` | *str* | `"#"`[^3] |
| `ARGPARSER_READ_ARGS` | *bool* | `true` |
| `ARGPARSER_SET_ARGS` | *bool* | `true` |
| `ARGPARSER_SET_ARRAYS` | *bool* | `true` |
| `ARGPARSER_UNSET_ARGS` | *bool* | `true` |
| `ARGPARSER_MAX_COL_WIDTH_1` | *int* | `5` |
| `ARGPARSER_MAX_COL_WIDTH_2` | *int* | `33` |
| `ARGPARSER_MAX_COL_WIDTH_3` | *int* | `39` |
| `ARGPARSER_POSITIONAL_NAME` | *str*[^4] | `"Positional"` |

[^1]: Bash is weakly typed, hence the denoted types are just a guidance.
[^2]: In fact, any legit Bash variable identifier.
[^3]: Values must be different from each other.
[^4]: Strings can optionally be enclosed by quotes.
