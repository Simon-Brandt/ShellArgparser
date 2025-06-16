# Shell Argparser

The argparser is designed to be an easy-to-use, yet powerful command-line argument parser for your shell scripts. It is mainly targeting Bash, but other shells are supported, as well.

Applying the argparser should lead to shorter and more concise code than the traditional [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)") and [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") allow. More importantly, the user-friendliness of argparser-powered command-line parsing is far superior thanks to a wide range of checked conditions with meaningful error messages. The argparser is inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module.

## Features

- Parsing of positional and keyword (option) arguments
- Any number of short and long option names for the same option (as aliases)
- Default and choice values, type checking, deprecation note
- Error and warning messages for wrongly or not set arguments
- Assignment of arguments' values to corresponding script variables
- Automatic creation of help, usage, and version message
- Full internationalization / localization support
- Inheritable arguments definition across multiple scripts
- Large configurability by environment variables and companion files to your script

## Quick start

Being a plain Bash script, not invoking external commands, the argparser does not add further dependencies to your script, apart from Bash and the argparser itself. Bash >4.0 is known to be required, but testing occurred solely on Bash 5.2. Thus, please file an issue if you encounter errors for versions earlier than 5.2.

No installation of the argparser is necessary, just clone the repository and add its location to the `PATH` variable. Alternatively, you may move the [argparser executable](argparser) into a directory which is already covered by your `PATH`. All other files within the repository serve documentation and testing purposes, and you don't need to keep them.

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Simon-Brandt/ShellArgparser.git

# Adjust the PATH.
PATH="/path/to/ShellArgparser:${PATH}"
```

There is ample documentation in the [docs](docs) directory, which you should consult to learn all the functionality the argparser provides.

A very simple quick-start script may look like this:

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

<!-- <include command="sed '3,10d;/shellcheck/d' tutorial/try_argparser.sh" lang="bash"> -->
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
<!-- </include> -->

</details>

First, you need to define the arguments your script shall accept, in a tabular manner. Then, you [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") the argparser with the current command line (sourcing means in-place execution without forking). Upon this, the argparser will parse your script's command line, check the arguments for validity, set default values, and assign the values to variables in your script's environment. Many of these steps can be customized by [environment variables](docs/reference/environment_variables/overview.md). The script's remainder just prints the optional and required keyword and positional arguments, and is not a part of the argparser invokation.
