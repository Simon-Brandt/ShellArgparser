### 4.4. Arguments definition files

In the previous sections, we always provided the arguments definition directly in the script, right before we sourced the Argparser. However, it is possible to "outsource" the definition (or part of it) in a bespoke file that is referred to by the [`ARGPARSER_ARG_DEF_FILE`](../reference/environment_variables/environment_variables.md#8410-argparser_arg_def_file) environment variable.

Using a separate arguments definition file allows you to share the definition across multiple scripts that use partially or entirely identical arguments, a common case in program suites or when wrapper scripts are used. Should some scripts require an argument to have the same name, but different definitions, they can be given in their respective scripts, in addition to the remainder from the file. Moreover, this attempt allows a separation of concerns, as we can move the arguments definition (static) away from their manipulation (dynamic). This shrinks our trial file once more, yielding [`try_arg_def_file.sh`](../../tutorial/try_arg_def_file.sh).

<details open>

<summary>Contents of <code>try_arg_def_file.sh</code></summary>

<!-- <include command="sed '3,11d;/shellcheck/d' ../tutorial/try_arg_def_file.sh" lang="bash"> -->
```bash
#!/bin/bash

# Set the Argparser, reading the arguments definition from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_ARG_DEF_FILE="${dir}/arguments.csv"

# Set the arguments.
args=(
    id
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

At the same time, we need an arguments definition file, herein aptly called [`arguments.csv`](../../resources/arguments.csv). Its structure is identical to the arguments definition we previously used, allowing you to easily move a definition between your script and the separate file.

Again, you need to add the header to explain the fields. Then, you can set your text editor to interpret the data as CSV file, possibly syntax-highlighting the columns with the given header or aligning the columns (as done by the [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv "Visual Studio Code &rightarrow; Marketplace &rightarrow; Rainbow CSV Extension") extension in [Visual Studio Code](https://code.visualstudio.com/ "Visual Studio Code")). Since the Argparser strips leading and trailing whitespace off the fields, you can also save the file with this alignment:

<!-- <include command="cat ../resources/arguments.csv" lang="console"> -->
```console
$ cat ../resources/arguments.csv
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
```
<!-- </include> -->

When passing the usual argument names and values, we see that all arguments are still recognized:

<!-- <include command="bash ../tutorial/try_arg_def_file.sh 1 2 -a 1 -b 2 -c A" lang="console"> -->
```console
$ bash ../tutorial/try_arg_def_file.sh 1 2 -a 1 -b 2 -c A
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

Likewise, the [usage (and help) message](help_and_usage_messages.md#45-help-and-usage-messages) is completely unaffected:

<!-- <include command="bash ../tutorial/try_arg_def_file.sh -u" lang="console"> -->
```console
$ bash ../tutorial/try_arg_def_file.sh -u
Usage: try_arg_def_file.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```
<!-- </include> -->

[&#129092;&nbsp;4.3. Argparser configuration](argparser_configuration.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.5. Help and usage messages&nbsp;&#129094;](help_and_usage_messages.md)
