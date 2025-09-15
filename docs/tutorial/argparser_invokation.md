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

### 5.2. Argparser invokation

Now that you have seen how the Argparser serves in parsing and interpreting the command-line arguments given to your script, it's time to explain what you need to do to employ the Argparser in your script. As promised, here's the code of [`try_argparser.sh`](../../tutorial/try_argparser.sh) again. You can cover it if you already read it above (and memorize the lines of code&hellip;).

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

<!-- <include command="sed '3,28d;/shellcheck/d' ../tutorial/try_argparser.sh" lang="bash"> -->
```bash
#!/usr/bin/env bash

# Define the arguments.
args=(
    "id    | short_opts | long_opts   | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |             | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |             | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a,A        | var-1,var-a | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b,B        | var-2,var-b | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c,C        | var-3,var-c | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d,D        | var-4,var-d | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice                 "
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

As you can see, there are two to three sections in the code that are specific to the Argparser. The accession at the end only serves us to gain insights into the values of the arguments and are not necessary to include&mdash;you would replace this by the actual workings of your script.

The first section (here omitted as not necessary) sets Argparser-specific [environment variables](../reference/environment_variables/introduction.md#94-environment-variables) to optimize the visual output, which we'll investigate later. Then, the arguments are defined, and finally, the Argparser is called.

#### 5.2.1. Argparser sourcing

This call is central to the script as it is the line that runs the Argparser. So, most simply, from your Bash script whose command-line arguments you want to be parsed, the main thing you need to do is to [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") the Argparser (sourcing means in-place execution without forking):

```bash
source argparser -- "$@"
```

Shells other than Bash require a slightly different approach, the [standalone usage](standalone_usage.md#5112-invokation-from-other-shells) in a pipe, but most things still hold for this case. As a result of the Argparser's configurability (see below), it is necessary to give cour script's command line after a double hyphen, *i.e.*, using `-- "$@"`.

Alternatively to `source`, but not recommended for the lack of the command's clearness, you could use the synonymous [dot operator](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_002e "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; dot operator") inherited from the Bourne shell (which shell could not run the Argparser, being a Bash script):

```bash
. argparser -- "$@"
```

This is the simplest form of invoking the Argparser. It will read your script's command line, parse the arguments, and set them to variables in your script. And this is the reason for sourcing instead of normal calling as in:

```bash
bash argparser
```

or:

```bash
./argparser
```

since you don't want the arguments to be set in a subprocess created after forking, as these will be gone when the Argparser (and with it, the subprocess) exits. Still, this is the required way for other shells, which make use of the Argparser's ability to write the arguments to `STDOUT`, if [`ARGPARSER_WRITE_ARGS`](../reference/environment_variables/environment_variables.md#9463-argparser_write_args) is set to `true`.

#### 5.2.2. Arguments definition and retrieval

As stated, the Argparser sets an associative array to store the arguments in. For maximum control over the variables in your script's scope, you can configure its name via [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#9410-argparser_arg_array_name), defaulting to `"args"`. In `try_argparser.sh`, we obtained the report by accessing exactly this associative array, looping over all variables known to the script that start with `var` or `pos`, respectively. At the same time, this variable name is used to provide the arguments definition.

While the single line `source argparser -- "$@"` provides the Argparser's functionality by running it, the positional and keyword arguments need to be defined somewhere. Thus, prior to the Argparser's invokation (and, in our case, after setting some environment variables to set the maximum column widths for the help message), the arguments are defined. Thereby, the indexed array `args` defines which command-line arguments are acceptable for the script, possibly giving an argument definition in an Argparser-specific tabular manner. Alternatively, this definition could be given as a separate [arguments definition file](arguments_definition_files.md#54-arguments-definition-files), indicated as [`ARGPARSER_ARG_DEF_FILE`](../reference/environment_variables/environment_variables.md#9411-argparser_arg_def_file).

The rationale for allowing `args` to store both the arguments alone and them along their definition gets clear when you realize that it's possible to share an arguments definition file across multiple scripts and only require a limited subset of the arguments for the current script. Then, you can give these arguments a common definition, identical for any script using them. Additionally, it is even possible to use an arguments definition file and definitions in `args` together, with the latter expanding on the former or overriding them, thus providing the opportunity to use arguments with the same name, but different definitions, in separate scripts. This offers great flexibility when writing wrapper scripts around pipelines, when you want to pass common arguments to different programs in your pipeline. Just define an argument within your wrapper script and pass its value to both programs.

The argument-defining entries in the indexed array named by [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#9410-argparser_arg_array_name), defaulting to `"args"`, can be understood as some sort of key&ndash;value pair for each argument, but merged in one string (not as true keys and values in associative arrays). The key is a unique identifier for the Argparser functions, and the name under which the argument's value can be obtained from the associative array `args`. The corresponding value provides the argument's definition to the Argparser.

This Argparser-specific tabular format consists of eleven columns, each separated from each other by an [`ARGPARSER_ARG_DELIMITER_1`](../reference/environment_variables/environment_variables.md#9412-argparser_arg_delimiter_1) character, defaulting to a pipe (`"|"`). Multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](../reference/environment_variables/environment_variables.md#9413-argparser_arg_delimiter_2) character, defaulting to a comma (`","`). The columns are defined as follows:

- `id`: the unique argument identifier (like `var_1`)
- `short_opts`: the short options (one hyphen, like `-a` and `-A` for `var_1`, default: `""`)
- `long_opts`: the long options (two hyphens, like `--var-1` and `--var-a` for `var_1`, default: `""`)
- `val_names`: the value names for the help and usage message, instead of uppercased short/long option names (like `VAL_1` for `var_1`, default: `""`)
- `defaults`: the default values (like `"A"` for `var_4`, default: `""`)
- `choices`: the choice values for options with a limited set of values to choose from (like `"A-C"`, *i.e.*, `"A"`, `"B"`, and `"C"` for `var_4`, default: `""`)
- `type`: the data type the argument shall have and will be tested on (like `"char"` for `var_4`, default: `"str"`)
- `arg_no`: the number of required values (any positive integer, `0`, or either of `"+"`, `"*"`, or `"?"`, meaning to accept a variable number of arguments (1 to infinity, 0 to infinity, or 0 to 1), like `1` for `var_4`, default: `1`)
- `arg_group`: the argument group for grouping of keyword arguments in the help text (like `"Optional options"` for `var_4`, default: [`ARGPARSER_POSITIONAL_ARG_GROUP`](../reference/environment_variables/environment_variables.md#9436-argparser_positional_arg_group))
- `notes`: additional notes to the Argparser, currently only `"deprecated"` is supported (like for `var_7`, default: `""`)
- `help`: the help text for the `--help` flag (like `"one value with default and choice"` for `var_4`, default: `""`)

These names must be given as a header above all argument definitions. Providing a header has the advantage that the order of the columns does not matter, and in the future, additional columns can be added or removed without breaking your code.

Moreover, when using a header, you can omit any column but the `id`. Then, the default values listed above are used, allowing for a briefer arguments definition. For example, if no argument is deprecated, there is no need to still include the `notes` column, which would be empty, then. Likewise, for scripts with only positional arguments, the `short_opts` and `long_opts` columns are empty and can be neglected. If you don't have default or choice values, you may opt to skip the `defaults` and `choices` columns. Still, while technically possible, it is not overly useful to omit the `help` column, since this is the most important source of information for your script's users (besides the manual), particularly since the default value for it is the empty string. And even though *e.g.* the `arg_no` column has a default value of `1`, it may render the arguments definition more legible to include it nonetheless.

Arguments can have multiple short and/or long option names, optional default values, and/or an arbitrary number of choice values (excluding `true` and `false`, which are reserved for their need in flags). Positional and keyword arguments are told apart by identifying all arguments having neither short nor long option names as positional, and all others as keyword arguments. Generally, absence of a value is indicated by the empty string (`""`). This allows the usage of hyphens, besides their special meaning on the command line (as option names), for the convention of regarding files given as `"-"` as sign to read from `STDIN`.

To simplify the creation of the arguments definition, the Argparser offers a special *modus operandi*, started when [`ARGPARSER_CREATE_ARG_DEF`](../reference/environment_variables/environment_variables.md#9419-argparser_create_arg_def) is set to `true` (or `--create-arg-def` is given on the Argparser's [command-line invokation](argparser_configuration.md#532-command-line-options)). This invokes a question and answer&ndash;like loop where you can input the arguments definition. The Argparser automatically formats it in such a way that all fields in a column have the same width, creating a nice-looking and ready-to-use arguments definition. This data will be written to a file specified by you, including the setting of the needed environment variables (particularly a non-standard [`ARGPARSER_ARG_DELIMITER_1`](../reference/environment_variables/environment_variables.md#9412-argparser_arg_delimiter_1)) and formatted either for Bash or POSIX sh. Should you don't want to use a temporary file for the data, you can just specify *e.g.* `/dev/stdout` as file to write to. In both cases, you can then copy the output to your script and directly test everything to work. It is highly recommended to set [`ARGPARSER_CHECK_ARG_DEF`](../reference/environment_variables/environment_variables.md#9415-argparser_check_arg_def) to `true` for the initial test runs, as the Argparser does not check them when creating the arguments definition.

[&#129092;&nbsp;5.1. Argument passing](argument_passing.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.3. Argparser configuration&nbsp;&#129094;](argparser_configuration.md)
