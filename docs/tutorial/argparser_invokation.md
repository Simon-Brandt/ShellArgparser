### 4.2. Argparser invokation

Now that you have seen how the Argparser serves in parsing and interpreting the command-line arguments given to your script, it's time to explain what you need to do to employ the Argparser in your script. As promised, here's the code of `try_argparser.sh` again. You can cover it if you already read it above (and memorize the lines of code&hellip;).

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

<!-- <include command="sed '3,10d;/shellcheck/d' ../tutorial/try_argparser.sh" lang="bash"> -->
```bash
#!/bin/bash

# Source the Argparser.  As the arguments have multiple short and long
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

As you can see, there are three sections in the code that are specific to the Argparser. The accession at the end only serves us to gain insights into the values of the arguments and are not necessary to include&mdash;you would replace this by the actual workings of your script.

The first section sets Argparser-specific [environment variables](../reference/environment_variables/introduction.md#84-environment-variables) to optimize the visual output, which we'll investigate later. Then, the arguments are defined, and finally, the Argparser is called. This call is central to the script as it is the line that runs the Argparser. So, most simply, from your Bash script whose command-line arguments you want to be parsed, the main thing you need to do is to [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") the Argparser (sourcing means in-place execution without forking):

```bash
source argparser -- "$@"
```

Shells other than Bash require a slightly different approach, the [standalone usage](standalone_usage.md#411-standalone-usage) in a pipe, but most things still hold for this case. As a result of the Argparser's configurability (see below), it is necessary to give cour script's command line after a double hyphen, *i.e.*, using `-- "$@"`.

Alternatively to `source`, but not recommended for the lack of the command's clearness, you could use the synonymous [dot operator](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_002e "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; dot operator") inherited from the Bourne shell (which cannot run the Argparser, which is a Bash script!):

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

since you don't want the arguments to be set in a subprocess created after forking, as these will be gone when the Argparser (and with it, the subprocess) exits. Still, this is the required way for other shells, which make use of the Argparser's ability to write the arguments to STDOUT, if [`ARGPARSER_WRITE_ARGS`](../reference/environment_variables/environment_variables.md#8462-argparser_write_args) is set to `true`.

As stated, the Argparser sets an associative array to store the arguments in. For maximum control over the variables in your script's scope, you can configure its name via [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#849-argparser_arg_array_name), defaulting to `"args"`. In `try_argparser.sh`, we obtained the report by accessing exactly this associative array, looping over all variables known to the script that start with `var` or `pos`, respectively. At the same time, this variable name is used to provide the arguments definition.

While the single line `source argparser -- "$@"` provides the Argparser's functionality by running it, the positional and keyword arguments need to be defined somewhere. Thus, prior to the Argparser's invokation (and, in our case, after setting some environment variables to set the maximum column widths for the help message), the arguments are defined. Thereby, the indexed array `args` defines which command-line arguments are acceptable for the script, possibly giving an argument definition in an Argparser-specific tabular manner. Alternatively, this definition could be given as a separate [arguments definition file](arguments_definition_files.md#44-arguments-definition-files), indicated as [`ARGPARSER_ARG_DEF_FILE`](../reference/environment_variables/environment_variables.md#8410-argparser_arg_def_file).

The rationale for allowing `args` to store both the arguments alone and them along their definition gets clear when you realize that it's possible to share an arguments definition file across multiple scripts and only require a limited subset of the arguments for the current script. Then, you can give these arguments a common definition, identical for any script using them. Additionally, it is even possible to use an arguments definition file and definitions in `args` together, with the latter expanding on the former or overriding them, thus providing the opportunity to use arguments with the same name, but different definitions, in separate scripts. This offers great flexibility when writing wrapper scripts around pipelines, when you want to pass common arguments to different programs in your pipeline. Just define an argument within your wrapper script and pass its value to both programs.

The argument-defining entries in the indexed array named by [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#849-argparser_arg_array_name), defaulting to `"args"`, can be understood as some sort of key&ndash;value pair for each argument, but merged in one string (not as true keys and values in associative arrays). The key is a unique identifier for the Argparser functions, and the name under which the argument's value can be obtained from the associative array `args`. The corresponding value provides the argument's definition to the Argparser.

This Argparser-specific tabular format consists of eleven columns, each separated from each other by an [`ARGPARSER_ARG_DELIMITER_1`](../reference/environment_variables/environment_variables.md#8411-argparser_arg_delimiter_1) character, defaulting to a pipe (`"|"`). Multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](../reference/environment_variables/environment_variables.md#8412-argparser_arg_delimiter_2) character, defaulting to a comma (`","`). The columns are defined as follows:

- `id`: the unique argument identifier (like `var_1`)
- `short_opts`: the short options (one hyphen, like `-a` and `-A` for `var_1`, default: `""`)
- `long_opts`: the long options (two hyphens, like `--var-1` and `--var-a` for `var_1`, default: `""`)
- `val_names`: the value names for the help message, instead of uppercased short/long option names (like `VAL_1` for `var_1`, default: `""`)
- `defaults`: the default values (like `"A"` for `var_4`, default: `""`)
- `choices`: the choice values for options with a limited set of values to choose from (like `"A-C"`, *i.e.*, `"A"`, `"B"`, and `"C"` for `var_4`, default: `""`)
- `type`: the data type the argument shall have and will be tested on (like `"char"` for `var_4`, default: `"str"`)
- `arg_no`: the number of required values (either numerical from `0` to infinity or `"+"`, meaning to accept as many values as given, at least one, like `1` for `var_4`, default: `1`)
- `arg_group`: the argument group for grouping of keyword arguments in the help text (like `"Optional options"` for `var_4`, default: [`ARGPARSER_POSITIONAL_ARG_GROUP`](../reference/environment_variables/environment_variables.md#8434-argparser_positional_arg_group))
- `notes`: additional notes to the Argparser, currently only `"deprecated"` is supported (like for `var_7`, default: `""`)
- `help`: the help text for the `--help` flag (like `"one value with default and choice"` for `var_4`, default: `""`)

These names must be given as a header above all argument definitions. Providing a header has the advantage that the order of the columns does not matter, and in the future, additional columns can be added or removed without breaking your code.

Moreover, when using a header, you can omit any column but the `id`. Then, the default values listed above are used, allowing for a briefer arguments definition. For example, if no argument is deprecated, there is no need to still include the `notes` column, which would be empty, then. Likewise, for scripts with only positional arguments, the `short_opts` and `long_opts` columns are empty and can be neglected. If you don't have default or choice values, you may opt to skip the `defaults` and `choices` columns. Still, while technically possible, it is not overly useful to omit the `help` column, since this is the most important source of information for your script's users (besides the manual), particularly since the default value for it is the empty string. And even though *e.g.* the `arg_no` column has a default value of `1`, it may render the arguments definition more legible to include it nonetheless.

Keyword arguments can have multiple short and/or long option names, optional default values, and/or an arbitrary number of choice values. The same holds for positional arguments, which are identified by having neither short nor long option names. Generally, absence of a value is indicated by the empty string (`""`). This allows the usage of hyphens, besides their special meaning on the command line (as option names), for the convention of regarding files given as `"-"` as sign to read from STDIN.

As you saw above, the Argparser will aggregate all arguments (values) given after a word starting with a hyphen (*i.e.*, an option name) to this option. If the number doesn't match the number of required values, an error is thrown instead of cutting the values. If an argument gets a wrong number of values, but has a default value, only a warning is thrown and the default value is taken.

Thereby, errors abort the script, while warnings just write a message to `STDERR`. Even after parsing or value checking errors occurred, the parsing or value checking continues and the Argparser aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

[&#129092;&nbsp;4.1. Argument passing](argument_passing.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.3. Argparser configuration&nbsp;&#129094;](argparser_configuration.md)
