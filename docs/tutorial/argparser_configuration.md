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

### 5.3. Argparser configuration

The Argparser accepts over 50 options for configuring the argument parsing, checking their values and the consistency of the arguments definition, creating the various message types (see below), and accessing the required companion files. These options are available as [environment variables](../reference/environment_variables/introduction.md#94-environment-variables). By this, you can set them directly in your script, and even [`export`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-export "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; export") them to child processes. Thus, you can set these variables once and use them throughout your script suite.

Still, it is likely that, after some time or for a specific project, you'll settle with a certain set of options that you'll want to reuse for all or many scripts. Then, setting the environment variables in any script becomes a tedious task, wasting space in each script. Additionally, should you want to change a value, you'd need to change it in any file.

For this reason, the Argparser also supports configuration by a config file (see the example [`options.cfg`](../../resources/options.cfg)), given by the [`ARGPARSER_CONFIG_FILE`](../reference/environment_variables/environment_variables.md#9416-argparser_config_file) environment variable, or by command-line options.

#### 5.3.1. Configuration file

The Argparser configuration file contains the options in a key&ndash;value syntax and can be shared by multiple scripts, which only need to point to the same configuration file. The options have the same name as the environment variables, with a stripped leading `"ARGPARSER_"` and being written in lowercase, and with underscores replaced by hyphens. *I.e.*, the "screaming snake case" is replaced by the "kebab case".

The keys and values must be separated by an equals sign (`=`), but can be surrounded by spaces, allowing for a table-like arrangement. Further, empty or commented lines (those starting with a hashmark, *i.e.*, `#`) are ignored, and thus can be used to explain certain values. In-line comments aren't supported to simplify the parsing of values containing a hashmark. It is possible to quote strings, but not necessary, which allows the one-by-one replacement of values from scripts to the configuration file and *vice versa*.

Thereby, you can override options from the file with some given in your script. Should an option be defined in neither place, a default is used. This allows you to list only necessary options in your configuration file and let the Argparser set everything else.

Now, let's have a look at the configuration file (or at least, at the first ten lines to save some space):

<!-- <include command="head --lines=10 ../resources/options.cfg" lang="console"> -->
```console
$ head --lines=10 ../resources/options.cfg
add-help                  = true
add-usage                 = true
add-version               = true
allow-flag-inversion      = true
allow-flag-negation       = true
allow-option-abbreviation = false
allow-option-merging      = false
arg-array-name            = "args"
arg-def-file              = ""
arg-delimiter-1           = "|"
```
<!-- </include> -->

For demonstration, we take a stripped-down version of our [`try_argparser.sh`](../../tutorial/try_argparser.sh) script as [`try_config_file.sh`](../../tutorial/try_config_file.sh), where we omit the alias names for the short and long options, for the sake of brevity. Note that using [`readlink`](https://man7.org/linux/man-pages/man1/readlink.1.html "man7.org &rightarrow; man pages &rightarrow; readlink(1)") is only required here to cope with the configuration file residing in the [resources](../../resources) directory, it is not necessary if you use absolute paths or store the configuration file alongside your script in the same directory&mdash;or won't invoke your script from multiple working directories.

<details open>

<summary>Contents of <code>try_config_file.sh</code></summary>

<!-- <include command="sed '3,29d;/shellcheck/d' ../tutorial/try_config_file.sh" lang="bash"> -->
```bash
#!/usr/bin/env bash

# Source the Argparser, reading the configuration from a file.
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
    "var_4 | d          |           | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice                 "
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
<!-- </include> -->

</details>

The script can now be invoked as any other script, yielding the same results:

<!-- <include command="bash ../tutorial/try_config_file.sh 1 2 -a 1 -b 2 -c A" lang="console"> -->
```console
$ bash ../tutorial/try_config_file.sh 1 2 -a 1 -b 2 -c A
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
<!-- </include> -->

#### 5.3.2. Command-line options

Further, all environment variables can also be given as command-line parameters upon sourcing the Argparser. Thereby, the options have the same name as in the configuration file ("kebab case"), and are only valid for the given Argparser call.

You can give the options right before your script's command line and the delimiting double hyphen. The Argparser interprets all options given before the first double hyphen as options belonging to the Argparser, the remainder is interpreted as your script's command line. This especially means that you cannot use the double hyphen to delimit positional arguments for the Argparser&mdash;but since none are supported (apart from your script's command line), an error would be given, anyways.

Due to the manner the [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") builtin is defined, the Argparser cannot distinguish whether it was sourced with arguments, so mandates them in any case. This means that you must explicitly state the `-- "$@"` to pass the arguments to the Argparser, even if you don't use any option. The `--` is required to separate the Argparser modification from the actual arguments&mdash;after all, it is not too unlikely that some of your scripts might want to use one of the Argparser options for themselves. To still be able to distinguish between an option for the Argparser and an argument to your script, the double hyphen is used as delimiter.

So the general call would look like this:

```bash
source argparser [--option...] -- "$@"
```

with `option` being any environment variable's transformed name.

#### 5.3.3. Option inheritance

Since the Argparser parses its options like it does for your script's ones (by non-recursively sourcing itself), the same special syntax regarding flags is used. That means, if you set `++set-args` as option, then the Argparser will only read the command-line arguments, parsing them into an associative array you can access afterwards, denoted by the name the environment variable [`ARGPARSER_ARG_ARRAY_NAME`](../reference/environment_variables/environment_variables.md#949-argparser_arg_array_name) refers to (per default, `"args"`)&mdash;but it won't set them as variables to your script.  The opposite holds for the option `++read-args`, which deactivates the reading. Finally, if `--read-args` and `--set-args` are set, the arguments will both be read and set (in this order). Since the default value for both options is `true`, these actions are also carried out when only one option or none is given.

Not surprisingly, you need to read the arguments before you set them, but you can perform arbitrary steps in-between. This could come handy when you want to use the variable names the Argparser sets for some task or want to manipulate the associative array prior having the values set.

If you [`export`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-export "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; export") (or [`declare -x`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-declare "gnu.org &rightarrow; Bash Builtins &rightarrow; declare")) environment variables like [`ARGPARSER_READ_ARGS`](../reference/environment_variables/environment_variables.md#9434-argparser_read_args) and [`ARGPARSER_SET_ARGS`](../reference/environment_variables/environment_variables.md#9436-argparser_set_args) to child processes (like scripts called from your master script), they will inherit these variables. If, in your child script, you use a bare `source argparser -- "$@"`, *i.e.*, without specifying an option to the Argparser, the settings from the inherited environment variables will be used. However, you can always override them by specifying an Argparser option. By this, you may set the environment variables in your master script and use the settings in some child scripts, with the others setting their own options. Thus, to rule out any possible influence of the environment on reading and setting, using the two respective option flags might be recommendable for certain use cases.

[&#129092;&nbsp;5.2. Argparser invokation](argparser_invokation.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.4. Arguments definition files&nbsp;&#129094;](arguments_definition_files.md)
