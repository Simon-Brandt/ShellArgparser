### 5.6. Help and usage message files

The Argparser is not only able to compile a help message, but can also be guided by a separate file. Using the [`ARGPARSER_HELP_FILE`](../reference/environment_variables/environment_variables.md#9423-argparser_help_file) environment variable pointing to this file, to a certain degree, you can customize the help message's look and structure by moving the blocks the message consists of around and enriching it by arbitrary text. Again, we use a simplified script as [`try_help_file.sh`](../../tutorial/try_help_file.sh) without alias names for the short and long options.

<details open>

<summary>Contents of <code>try_help_file.sh</code></summary>

<!-- <include command="sed '3,29d;/shellcheck/d' ../tutorial/try_help_file.sh" lang="bash"> -->
```bash
#!/bin/bash

# Source the Argparser, reading the help message from a file.
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
    "var_4 | d          |           | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"
```
<!-- </include> -->

</details>

Additionally, we need a separate file, which we'll call [`help_message.txt`](../../resources/help_message.txt) and have passed as value to [`ARGPARSER_HELP_FILE`](../reference/environment_variables/environment_variables.md#9423-argparser_help_file). This plain-text file stores the help message's structure and can contain arbitrary additional content.

<!-- <include command="sed '1,14d' ../resources/help_message.txt" lang="console"> -->
```console
$ sed '1,14d' ../resources/help_message.txt
# Print the header.
A brief header summarizes the way how to interpret the help message.
@Header

# Print the positional arguments.
The following arguments are positional.
@Positional arguments

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
<!-- </include> -->

Now, we get the following help message:

<!-- <include command="bash ../tutorial/try_help_file.sh -h" lang="console"> -->
```console
$ bash ../tutorial/try_help_file.sh -h
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
<!-- </include> -->

When you compare the structure of this help message with both the previous version and the help file, you see that there, you can include the sections from the auto-generated help message by prefixing their names with an [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](../reference/environment_variables/environment_variables.md#9424-argparser_help_file_include_char) character, defaulting to an `"@"`. Generally speaking, an include directive, as the commands are referred to, like `@Section`, includes the section named `"Section"`.

The following section names (include directives) are supported, explained in greater detail in the [reference](../reference/include_directives.md#93-include-directives) below:

- [`@All`](../reference/include_directives.md#931-all-directive)
- [`@<ArgumentGroup>`](../reference/include_directives.md#932-argumentgroup-directive)
- [`@Description`](../reference/include_directives.md#933-description-directive)
- [`@Header`](../reference/include_directives.md#934-header-directive)
- [`@Help`](../reference/include_directives.md#935-help-directive)
- [`@Remark`](../reference/include_directives.md#936-remark-directive)
- [`@Usage`](../reference/include_directives.md#937-usage-directive)

Thereby, `<ArgumentGroup>` can be the name of any argument group given in the arguments definition, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. `@Description` prints the [`ARGPARSER_HELP_DESCRIPTION`](../reference/environment_variables/environment_variables.md#9421-argparser_help_description), `@Help` prints the help, usage, and version options (depending on which of them are defined by [`ARGPARSER_ADD_HELP`](../reference/environment_variables/environment_variables.md#942-argparser_add_help), [`ARGPARSER_ADD_USAGE`](../reference/environment_variables/environment_variables.md#943-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](../reference/environment_variables/environment_variables.md#944-argparser_add_version)), `@Remark` prints the remark that mandatory arguments to long options are mandatory for short options too, and `@Usage` prints the usage line. Finally, the shorthand `@All` means to print the usage line, the description, the remark, all argument groups, and the help options, in this order, while `@Header` prints the usage line, the description, and the remark.

Further, lines starting with a `"#"` character in the help file aren't printed if [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](../reference/environment_variables/environment_variables.md#9425-argparser_help_file_keep_comments) is set to `false` (the default). This allows you to comment your help file, perhaps to explain the structure&mdash;or just to write a header or footer with your name and debug email address inside.

The same as for help messages can be done for usage messages, using the [`ARGPARSER_USAGE_FILE`](../reference/environment_variables/environment_variables.md#9445-argparser_usage_file), [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](../reference/environment_variables/environment_variables.md#9446-argparser_usage_file_include_char), and [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](../reference/environment_variables/environment_variables.md#9447-argparser_usage_file_keep_comments) environment variables. However there, only the `@All` directive is supported, yet.

[&#129092;&nbsp;5.5. Help and usage messages](help_and_usage_messages.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.7. Help and usage message localization&nbsp;&#129094;](help_and_usage_message_localization.md)
