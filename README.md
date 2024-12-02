# Argparser

The argparser is a designed to be a simple, yet powerful command-line argument parser for your Bash scripts, superior to `getopt`/`getopts`. It is entirely written in pure Bash, without invoking external commands, reducing dependencies. It is inspired by the Python argparse module.

## Features

The argparser:

- parses a script's arguments
- gives proper error messages for wrongly set arguments
- assigns the values to the respective variables
- creates and prints a help or usage message
- can be configured to your needs by a set of environment variables

## Installation

> [!WARNING]
> Requires Bash 5 or higher (try `bash --version`). Tested with `bash 5.2.21` (`GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`).

No actual installation is necessary, as the argparser is just a Bash script that can be located in an arbitrary directory of your choice, like `/usr/local/bin`. Thus, the "installation" is as simple as cloning the repository in this very directory:

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

- `~/.profile` (local addition, for login shells)
- `~/.bashrc` (local addition, for non-login shells)
- `/etc/profile` (global addition, for login shells)
- `/etc/bash.bashrc` (global addition, for non-login shells)

Be wary not to forget the final `${PATH}` component in the above command, or else you will override the `PATH` for your active shell, meaning no other (non-builtin) command will be resolvable.

## Usage

From your script whose command-line arguments you want to be parsed, all you need to do is to source the argparser:

```bash
source argparser.sh
```

This is the simplest form of invokation. It will read the command line, parse the arguments, and set them to variables in your script.

More fine-grained control is provided by the longer form of the command:

```bash
source argparser.sh --action -- "$@"
```

with the `action` being either `read`, `set`, or `all`. If the `action` is `read`, then the argparser will only read the command-line arguments and parse them into an associative array you can access afterwards. If the `action` is `set`, the arguments from this array are set as variables to your script. *I.e.*, you need to `read` the arguments before you `set` them, but you can perform arbitrary steps in-between. If the `action` is `all`, both `read` and `set` will be executed.

Invoking

```bash
source argparser.sh --all -- "$@"
```

is exactly identical to invoking a bare

```bash
source argparser.sh
```

but less legible. Thus, the latter form is preferred.

There is one important exception to this rule, and that is configuration by environment variables. Specifying an `action` overrides the values of [`ARGPARSER_READ_ARGS`](#argparser_read_args) and [`ARGPARSER_SET_ARGS`](#argparser_set_args), which are else inherited from the sourcing script's environment (which, in turn, might inherit them from another calling script). Thus, to rule out any possible influence of the environment on `read` and `set`, the long invokation command is recommendable.

As stated, `read` sets an associative array to store the arguments in. For maximum control over the variables in your script's scope, you can configure its name via [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name), defaulting to `"args"`.

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

As you can see, you need to source the argparser, possibly after adjusting some of the argparser environment variables (here to prevent the auto-reading from the non-existent arguments definition file and to set the maximum column widths for the help message), and then define the arguments. Even though you may choose another way, as long as the input to `argparser_main` keeps the same structure, this is the recommended way.

The argument-defining associative array consists of a key (which is nothing more than a unique identifier for the argparser functions) and a value. The latter consists of seven columns, each separated by a colon (":") from each other. The first column defines the short options (one hyphen), the second the long options (two hyphens), the third the default value, the fourth the choice values for options with a limited set of values to choose from, the fifth the number of required values (either numerical from 0 to infinity or "+", meaning to accept as many values as given, at least one), the sixth the argument group for grouping of arguments in the help text, and the seventh the help text for the `--help` flag.

Arguments can have multiple short and/or long names, a default value and/or an arbitrary number of choice values.

The argparser will aggregate all values given after a word starting with a hyphen to this argument. If the number doesn't match the number of required values, an error is thrown instead of cutting the values. If an argument gets a wrong number of values, but has a default value, only a warning is thrown and the default value is taken.

Even after errors occurred, the parsing continues and aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

No matter how many arguments are defined (even with the same name), the argparser interprets the arguments `-u` and `--usage` as call for a usage message and `-h` and `--help` as call for a help message. These arguments are always added to the script's argument definition.

Further, all values given after `--` are interpreted as values to positional arguments, and, if `${ARGPARSER_SET_ARGS}` is set to `true`, are assigned to the script's `$@`, with the previous values being discarded.

As many arguments may be given as desired (*i.e.*, the same argument can be called multiple times), with the values given afterwards being all assigned to the respective argument.

The argparser will build the help and usage messages from the arguments, indicating the short and long names, the default and choice values, as well as the argument group, and print the help text from the arguments' definitions.

## Environment variables

### Overview

| Variable name                                                     | Allowed values or type[^1][^2][^3] | Default value     |
|-------------------------------------------------------------------|------------------------------------|-------------------|
| [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name)           | *str*[^4]                          | `"args"`          |
| [`ARGPARSER_ARG_DEF_FILE`](#argparser_arg_def_file)               | *filepath* \| `""`                 | `"arguments.lst"` |
| [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1)         | *char*                             | `"\|"`[^5]        |
| [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2)         | *char*                             | `":"`[^5]         |
| [`ARGPARSER_ARG_DELIMITER_3`](#argparser_arg_delimiter_3)         | *char*                             | `","`[^5]         |
| [`ARGPARSER_ARG_GROUP_DELIMITER`](#argparser_arg_group_delimiter) | *char*                             | `"#"`[^5]         |
| [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1)         | *int*                              | `5`[^6]           |
| [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2)         | *int*                              | `33`[^6]          |
| [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3)         | *int*                              | `39`[^6]          |
| [`ARGPARSER_POSITIONAL_NAME`](#argparser_positional_name)         | *str*                              | `"Positional"`    |
| [`ARGPARSER_READ_ARGS`](#argparser_read_args)                     | *bool*                             | `true`            |
| [`ARGPARSER_SET_ARGS`](#argparser_set_args)                       | *bool*                             | `true`            |
| [`ARGPARSER_SET_ARRAYS`](#argparser_set_arrays)                   | *bool*                             | `true`            |
| [`ARGPARSER_UNSET_ARGS`](#argparser_unset_args)                   | *bool*                             | `true`            |
| [`ARGPARSER_UNSET_ENV_VARS`](#argparser_unset_env_vars)           | *bool*                             | `true`            |

[^1]: Bash is weakly typed, hence the denoted types are just a guidance.
[^2]: Strings can optionally be enclosed by quotes.
[^3]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^4]: In fact, any legit Bash variable identifier.
[^5]: Values must be different from each other.
[^6]: Values must be positive integers of a reasonable magnitude (recommended sum: 77).

### `ARGPARSER_ARG_ARRAY_NAME`

- ***Type:*** *str* (String), but only characters allowed in a legit Bash variable identifier
- ***Allowed values:*** Any legit Bash variable identifier
- ***Default value:*** `"args"`
- ***Description:*** The name of an associative array, under which the parsed arguments can be accessed. The array stores the argument's identifier as key and its values as value. If [`ARGPARSER_SET_ARGS`](#argparser_set_args) is `true`, you usually don't need to access this array as the arguments will be set as variables.

### `ARGPARSER_ARG_DEF_FILE`

- ***Type:*** *filepath* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `"arguments.lst"`
- ***Description:*** The path to a file holding the definition of the arguments. This file may be used by multiple scripts if they share some arguments. It is not necessary to use all arguments from there, as you need to specify which arguments you want to use. It is possible to set additional argument definitions within the script, which could come handy when scripts share some arguments (from the file), but also use some own arguments (from the script), whose names have another meaning in the companion script.

### `ARGPARSER_ARG_DELIMITER_1`

- ***Type:***  *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2), [`ARGPARSER_ARG_DELIMITER_3`](#argparser_arg_delimiter_3), or [`ARGPARSER_ARG_GROUP_DELIMITER`](#argparser_arg_group_delimiter)
- ***Default value:*** `"|"`
- ***Description:*** The primary delimiter that internally separates the arguments' keys and values from each other. Though you don't need to access this variable, you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_ARG_DELIMITER_2`

- ***Type:***  *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1), [`ARGPARSER_ARG_DELIMITER_3`](#argparser_arg_delimiter_3), or [`ARGPARSER_ARG_GROUP_DELIMITER`](#argparser_arg_group_delimiter)
- ***Default value:*** `":"`
- ***Description:*** The secondary delimiter that separates the fields in the arguments definition. Again, you don't need to access this variable, but you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_ARG_DELIMITER_3`

- ***Type:***  *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1), [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2), or [`ARGPARSER_ARG_GROUP_DELIMITER`](#argparser_arg_group_delimiter)
- ***Default value:*** `","`
- ***Description:*** The tertiary delimiter that separates the elements of sequences in the arguments definition. Also here, you don't need to access this variable, but you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_ARG_GROUP_DELIMITER`

- ***Type:***  *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#argparser_arg_delimiter_1), [`ARGPARSER_ARG_DELIMITER_2`](#argparser_arg_delimiter_2), or [`ARGPARSER_ARG_DELIMITER_3`](#argparser_arg_delimiter_3)
- ***Default value:*** `"#"`
- ***Description:*** The delimiter that internally separates argument groups from each other. Once more, you don't need to access this variable, but you must ensure that it is set to a character or glyph that does not occur in the arguments definition or their values.

### `ARGPARSER_MAX_COL_WIDTH_1`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `5`
- ***Description:*** The maximum column width of the first column in the generated help message. This column holds the short options of the arguments, hence, it can be rather narrow. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_1`. If it is less wide, the column is shrunk accordingly.  
It is recommendable to have a total width of the help message of 79 characters. As one space is always inserted as seperation between the first and second, as well as the second and third column, the sum of `ARGPARSER_MAX_COL_WIDTH_1`, [`ARGPARSER_MAX_COL_WIDTH_2`](#argparser_max_col_width_2), and [`ARGPARSER_MAX_COL_WIDTH_3`](#argparser_max_col_width_3) should equal 77. As long options are longer than short options, the second column should be far wider than the first. The help text in the third column consists of human-readable words and is thus less bound to word wrapping restrictions. By this, it is easier to set the third column's width to 77 characters minus the total width of the first two columns to get an optimized help message layout.

### `ARGPARSER_MAX_COL_WIDTH_2`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `33`
- ***Description:*** The maximum column width of the second column in the generated help message. This column holds the long options of the arguments, hence, it should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_2`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1).

### `ARGPARSER_MAX_COL_WIDTH_3`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `39`
- ***Description:*** The maximum column width of the third column in the generated help message. This column holds the help text of the arguments, hence, it should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_3`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_COL_WIDTH_1`](#argparser_max_col_width_1).

### `ARGPARSER_POSITIONAL_NAME`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string not used as argument identifier in the argument definition
- ***Default value:*** `"Positional"`
- ***Description:*** A unique key to store the positional arguments in the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) sets. This name can be arbitrary, as long as it is not used as an identifier of any argument in the argument definition. Note, however, that you might want to use the associative array in you code and then might want to give the `ARGPARSER_POSITIONAL_NAME` a descriptive name.

### `ARGPARSER_READ_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false` (case-sensitive)
- ***Default value:*** `true`
- ***Description:*** Whether to read the arguments from the command line (*i.e.*, from `"$@"`) and parse them to the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) sets. Setting `ARGPARSER_READ_ARGS` is the same as calling `source argparser.sh --read -- "$@"`. If set along [`ARGPARSER_SET_ARGS`](#argparser_set_args), it is the same as calling `source argparser.sh --all -- "$@"` or a bare `source argparser.sh`.  
The main difference is that, if you `export` (or `declare -x`) the variables to subshells (like scripts called from your master script), they will inherit these environment variables. If, in your child script, you use a bare `source argparser.sh`, *i.e.*, without specifying an action to the argparser, the setting from the inherited environment variables will be used. You can always override them by specifying an action. By this, you may set the environment variables in your master script and use the settings in some child scripts, with the others setting their own action.

### `ARGPARSER_SET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false` (case-sensitive)
- ***Default value:*** `true`
- ***Description:*** Whether to set the (read and parsed) arguments from the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#argparser_arg_array_name) sets to variables in the calling acript's scope. Setting `ARGPARSER_SET_ARGS` is the same as calling `source argparser.sh --set -- "$@"`. If set along [`ARGPARSER_READ_ARGS`](#argparser_read_args), it is the same as calling `source argparser.sh --all -- "$@"` or a bare `source argparser.sh`. For details, refer to [`ARGPARSER_READ_ARGS`](#argparser_read_args).

### `ARGPARSER_SET_ARRAYS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false` (case-sensitive)
- ***Default value:*** `true`
- ***Description:*** Whether to set arguments intended to have multiple values as indexed array. This is only evaluated if [`ARGPARSER_SET_ARGS`](#argparser_set_args) is `true`. While it can be very helpful in a script to have the multiple values already set to an array that can be iterated over, the drawback is that arrays are hard to transfer to other scripts and may need to be serialized.

### `ARGPARSER_UNSET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false` (case-sensitive)
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) all command-line arguments to the script. This is usually what you want, as the argparser re-sets these values in parsed form. Else, keyword arguments will be included as positional-like arguments. This is only evaluated if [`ARGPARSER_SET_ARGS`](#argparser_set_args) is `true`.

### `ARGPARSER_UNSET_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false` (case-sensitive)
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) argparser environment variables from the environment. As long as you don't need these variables anymore or want to reset them prior to the next argparser invokation, this is usually what you want. This prevents accidental (but also deliberate) inheritance to child scripts when passing the entire environment to them.
