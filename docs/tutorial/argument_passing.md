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

### 5.1. Argument passing

First, let's see how we can use the Argparser to parse the arguments given to your script, here saved as [`try_argparser.sh`](../../tutorial/try_argparser.sh) in the [tutorial](../../tutorial) directory. You can uncover the script if you want to test and try it, but we'll come back to it in the next section. For now, only the output is relevant, when we call the script from the command line.

<details>

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

#### 5.1.1. Positional and keyword arguments

When you (as a user) have to deal with unknown scripts or programs, maybe the first thing to try is to run the script with the `--help` flag. As we're currently seeing `try_argparser.sh` as sort of a "black box", we assume not to know any implementation detail. So we're trying to run:

<!-- <include command="bash ../tutorial/try_argparser.sh --help" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh --help
Usage: try_argparser.sh [OPTIONS] ARGUMENTS -- [pos_1] pos_2

Mandatory arguments to long options are mandatory for short options too.

Positional arguments:
[pos_1=                                     one positional argument with
    {1,2}]                                  default and choice (default: 2)
pos_2                                       two positional arguments without
                                            default or choice

Mandatory options:
-a, -A,    --var-1=VAL_1, --var-a=VAR_A     one value without default or choice
-b, -B,    --var-2=VAL_2...,                at least one value without default
           --var-b=VAR_B...                 or choice
-c, -C,    --var-3={A,B}...,                at least one value with choice
           --var-c={A,B}...

Optional options:
[-d, -D],  [--var-4={A-C}], [--var-d={A-C}] one value with default and choice
                                            (default: "A")
[-e, -E],  [--var-5=VAL_5], [--var-e=VAR_E] one value with default (default:
                                            "E")
[-f, -F],  [--var-6, --var-f]               no value (flag) with default
                                            (default: false)
[-g, -G],  [--var-7, --var-g]               (DEPRECATED) no value (flag) with
                                            default (default: true)

Help options:
[-h, -?],  [--help]                         display this help and exit
                                            (default: false)
[-u],      [--usage]                        display the usage and exit
                                            (default: false)
[-V],      [--version]                      display the version and exit
                                            (default: false)
```
<!-- </include> -->

This already gives us plenty of information. Even though we don't know yet where it comes from (it's generated by the Argparser, not hardcoded in the script), we can see that `try_argparser.sh` accepts two positional arguments and seven different options, (more or less) aptly named `--var-1` through `--var-7`. There are other names referring to the same options, but we'll come back to this later.

Now that we had a look at the options (or keyword arguments, to cope with some being mandatory), we know that some of them, `--var-4` through `--var-7`, as well as `pos_1`, to be precise, have default arguments. These are indicated by the square brackets in the help message and by the "default" keyword in their help texts. Since they are optional, we try not to care about them. Instead, we run `try_argparser.sh` as follows:

<!-- <include command="bash ../tutorial/try_argparser.sh 1 --var-1=1 --var-2=2 --var-3=A" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh 1 --var-1=1 --var-2=2 --var-3=A
try_argparser.sh: Error: The argument "pos_2" requires 2 values, but has 1
                         given.

Usage: try_argparser.sh [-h,-? | -u | -V]
                        [-d,-D={A-C}]
                        [-e,-E=VAL_5,E]
                        [-f,-F]
                        [-g,-G]
                        -a,-A=VAL_1,A
                        -b,-B=VAL_2,B...
                        -c,-C={A,B}...
                        [{1,2}]
                        pos_2
```
<!-- </include> -->

This gives us an error message&mdash;certainly not what we wanted. Trying to understand the reason, we see that we guesstimated that there should be one value for the positional argument `pos_2` (we chose a literal `1`), but the error message tells us it should be two. Further, the Argparser tries to help us by giving a line with the general usage for `try_argparser.sh`, but the error message seems clear enough for us, here. So we try it again, this time using `1` and `2` as positional arguments:

<!-- <include command="bash ../tutorial/try_argparser.sh 1 2 --var-1=1 --var-2=2 --var-3=A" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh 1 2 --var-1=1 --var-2=2 --var-3=A
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

And now we got something that looks like the intended output (and yes, it is). Even without fully understanding yet what the Argparser does, you can see that we set *three* options and their arguments ([`IFS`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-IFS "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; IFS") whitespace&ndash;delimited) on the command-line invocation of `try_argparser.sh`, *viz.* `--var-1`, `--var-2`, and `--var-3`. Nonetheless, the script reports *seven* options to be given. This is due to `var_4` through `var_7` (note that the *identifiers* use underscores ("snake case"), while the *option names* use hyphens ("kebab case"), here) having said default values that are used when the argument is not given on the command line. For `var_1` through `var_3`, the reported values are exactly what we specified, *i.e.*, `"1"`, `"2"`, and `"A"`, respectively.

Likewise, `pos_2` is reported to be `"1,2"`, so some sort of sequence of the two values we gave (more precisely: the concatenation of the two values, joined by an [`ARGPARSER_ARG_DELIMITER_2`](../reference/environment_variables/environment_variables.md#9413-argparser_arg_delimiter_2) character, as we'll see later), and `pos_1` has been assigned a default value of `"2"`. Note that the quotes here are added by `try_argparser.sh` upon printing the values; internally, they are unquoted.

#### 5.1.2. Special options

From the help message above, we know that there are also short versions of the keyword arguments, and that it's possible to give positional arguments after a `--`, fitting with our command-line experience. So, let's see what happens with the following type of call:

<!-- <include command="bash ../tutorial/try_argparser.sh -a 1 -b 2 -c A -- 1 2" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh -a 1 -b 2 -c A -- 1 2
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

That's exactly the same output as before. We set the three mandatory options with arguments, *viz.* `-a 1`, `-b 2`, and `-c A`, but none is reported in the script's output. Then, we set a double hyphen (`--`) and two values, `1` and `2`. Thus, it is possible to give positional arguments after the special keyword argument `--`, *i.e.*, a double hyphen with no name behind. This is the usual way of saying "end of keyword arguments".

There is an Argparser-specific additional feature, intended to facilitate the mixing of positional and keyword arguments: the special keyword argument `++`:

<!-- <include command="bash ../tutorial/try_argparser.sh -a 1 -b 2 -- 1 2 ++ -c A" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh -a 1 -b 2 -- 1 2 ++ -c A
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

Two plus signs together are interpreted by the Argparser as sign to re-start the parsing of keyword arguments. You can imagine the plus signs as crossed hyphens, thus negating their meaning (as is done for flags in a later example).

Setting `--` after the positional argument&ndash;only part has started (*i.e.*, after a previous `--`) makes this second `--` a positional argument. In contrast, setting `++` after `--` re-starts the usual parsing, so the following argument is parsed as a keyword argument if it starts with a hyphen (or a plus sign for flags, see below), and as a positional argument, else.

Setting `--` after `++` stops the parsing (possibly again), while setting `++` after `++` means to parse a following non-hyphenated argument as positional, instead of as value to the previous keyword argument. You may rarely need the `++`, but a possible use case for scripts would be to gather command-line arguments or values from different processes, like *via* command/process substitution. Then, you can just combine the two streams, without needing to care whether both may set a `--`. Just join them with a `++` and the parsing occurs as expected.

#### 5.1.3. Option name aliases and modifications

As we saw in the examples, options can have name aliases, *i.e.*, any number of synonymous option names pointing to the same entity (argument identifier in the arguments definition). Thereby, not only aliases with two hyphens (so-called long options) are possible, but also some with only one leading hyphen (short options). For fast command-line usage, short options are convenient to quickly write a command; but for scripts, the long options should be preferred as they carry more information due to their verbose name (like, what does `-v` mean&mdash;is it `--version`, `--verbose`, or even `--verbatim`?). The Argparser allows an arbitrary number of short and/or long option names for a keyword argument to be defined, and options can be provided by any alias on the command line.

Further, long option names can be abbreviated, as long as no collision with other names arises (like when giving `--verb` in the example above). This requires [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](../reference/environment_variables/environment_variables.md#948-argparser_allow_option_abbreviation) to be set to `true`. In contrast, short option names may be merged with their value or other short option names (if they're flags, see below), given that [`ARGPARSER_ALLOW_OPTION_MERGING`](../reference/environment_variables/environment_variables.md#949-argparser_allow_option_merging) is set to `true`. For the sake of an example without needing a novel script, we'll set the latter variable to the environment of the script execution by prefixing the assignments to the usual command line:

<!-- <include command="ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh -a1 -b2 -cA -- 1 2" lang="console"> -->
```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh -a1 -b2 -cA -- 1 2
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

That's again the same output, somehow suggesting it may be hardcoded in the script&mdash;fortunately, such tricks aren't needed. But as you saw, there is no whitespace between the short option names and the values.

And since the long option names only differ in their last character, here, it is impossible to abbreviate them without ambiguity:

<!-- <include command="ARGPARSER_ALLOW_OPTION_ABBREVIATION=true bash ../tutorial/try_argparser.sh --var-1 1 --var-2 2 --var A -- 1 2" lang="console"> -->
```console
$ ARGPARSER_ALLOW_OPTION_ABBREVIATION=true bash ../tutorial/try_argparser.sh --var-1 1 --var-2 2 --var A -- 1 2
try_argparser.sh: Error: The argument "-c,-C,--var-3,--var-c" is mandatory, but
                         not given.

Usage: try_argparser.sh [-h,-? | -u | -V]
                        [-d,-D={A-C}]
                        [-e,-E=VAL_5,E]
                        [-f,-F]
                        [-g,-G]
                        -a,-A=VAL_1,A
                        -b,-B=VAL_2,B...
                        -c,-C={A,B}...
                        [{1,2}]
                        pos_2
```
<!-- </include> -->

#### 5.1.4. Argument value delimiters and intermixing

You may have noticed that we didn't use an equals sign (`=`) to delimit option names and their values, here. Though from the former examples it may seem as if it was related to the usage of short option names, for the Argparser, it is completely arbitrary whether you use spaces or equals signs. Again, typing spaces is faster on the command line, but using the explicit equals sign makes a script's code more legible.

This has the additional advantage that it's clear to a user (reading *e.g.* your script's manual) that the value belongs to the option before, and that it's not a flag followed by a positional argument. This may confuse even further since setting [`ARGPARSER_ALLOW_ARG_INTERMIXING`](../reference/environment_variables/environment_variables.md#945-argparser_allow_arg_intermixing) to `false` instructs the Argparser to treat values following option names only as positional arguments when they're separated by a double hyphen or doubled plus sign, rendering the latter interpretation only in some cases valid, but not even in all.

Moreover, using an equals sign is the only way of providing arguments starting with a hyphen to an option, since a whitespace-separated word would be interpreted as (possibly nonexistent) option name. By this, you can give negative numbers on the command line.

Let's have a look at another example invocation:

<!-- <include command="bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 3 -c A,B -b 4" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 3 -c A,B -b 4
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
<!-- </include> -->

Two things have changed in the invocation call: The `-b` option now appears twice, with the first of which being followed by two values instead of one. Then, the `-c` option has its value given as `A,B` (note the comma).

From the report for the `-b` option, an alias of `--var-2` for the option `var_2`, you can see that all three values&mdash;`2`, `3`, and `4`&mdash;are passed to `var_2`. Thus, it is possible to define keyword arguments to accept more than one value (just as `pos_2` already has shown for the positional arguments), with any given value being concatenated to the last given option name (or rather, the last hyphenated value, a difference important for nonexistent option names). You can even call an argument multiple times, passing values at different positions to it, though it seems rather counterproductive (in terms of confusing and unnecessarily verbose) for usage in scripts. On the command line, however, it may save you to go back when you realize you forgot to type a value. Another use case even for scripts would again be the gathering of command-line arguments or values from different processes, combining the two streams without needing to care whether they pass mutually exclusive option names or the same.

As you can see from the `-c` option, you can also use commas (again actually [`ARGPARSER_ARG_DELIMITER_2`](../reference/environment_variables/environment_variables.md#9413-argparser_arg_delimiter_2) characters) to pass multiple values at the same time. These have the same meaning as whitespace-delimited arguments, again with the exception of not interpreting hyphens as option names. As a stylistic advice, for scripts, use long options, the equals sign, and commas, as they tend to look clearer; whereas for simple command-line usage, take advantage of the short options and the ability to use spaces as delimiter, as both are faster to type.

Generally, the Argparser will aggregate all arguments (values) given after a word starting with a hyphen (*i.e.*, an option name) to this option. If the number doesn't match the number of required values, there are two possible outcomes: If [`ARGPARSER_ALLOW_ARG_INTERMIXING`](../reference/environment_variables/environment_variables.md#945-argparser_allow_arg_intermixing) is set to `true` (the default) the Argparser treats the new value as positional argument. For arguments with an arbitrary number of accepted values (those with a `"+"` or `"*"` as arguments count, see [below](argparser_invocation.md#522-arguments-definition-and-retrieval)), there can never be more values given than accepted. For arguments taking either zero or one values (`"?"` as arguments count), the Argparser will give one value to the keyword argument, and starting from the second value, treat them as positional arguments. For all other (numerical) argument counts, the Argparser will assign as many values to the keyword argument as this count states, and treat all subsequent values as positional arguments. When, in turn, there are now too many positional arguments or this argument intermixing is disabled in its entirety (*i.e.*, `ARGPARSER_ALLOW_ARG_INTERMIXING` is `false`), the Argparser throws an error instead of cutting the values. If an argument gets a wrong number of values, but has a default value, only a warning is thrown and it takes the default value.

Thereby, [errors](error_and_warning_messages.md#59-error-and-warning-messages) abort the script, while [warnings](error_and_warning_messages.md#59-error-and-warning-messages) just write a message to `STDERR`. Even after parsing or value checking errors occurred, the parsing or value checking continues and the Argparser aggregates the error messages until the end, when all are printed, to simplify the correction of multiple mistakes.

Regarding the positional arguments, we'll try the following:

<!-- <include command="bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A -- 3" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A -- 3
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
<!-- </include> -->

Like the keyword arguments, also the positional arguments can be given on multiple locations, *viz.* right after the script name, after keyword arguments having taken all required values, anywhere after a `--`, and right after a `++`. These values are assigned to the defined positional arguments in their order of definition, with each of which taking as many values as defined. If there is an optional positional argument (*i.e.*, a default value is given), it is only assigned a value from the command line if more values are given than necessary for the required arguments. This is the reason for `pos_1` now being set to `1` instead of `2` as hitherto; we explicitly set its value by adding a third positional argument.

It may be worth noting that, if a positional argument accepts an infinite number of values, it gets all remaining values, meaning that no positional argument can be defined or given after it. Moreover, it is impossible to parse the presence or absence of multiple optional positional arguments, only their presence or absence altogether is parsable. Thus, use a positional argument taking two values for this purpose. Likewise, both having an optional positional argument and a positional argument accepting an infinite number of values is impossible. For keyword arguments, no such restrictions exist, as they're delimited by the option names.

#### 5.1.5. Flags

Since there were some additional options given in the help message, let's have a look at another example invocation:

<!-- <include command="bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A -f +g" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A -f +g
try_argparser.sh: Warning: The argument "-g,-G,--var-7,--var-g" is deprecated
                           and will be removed in the future.
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
<!-- </include> -->

Enter: flags. The options `-f`, aliased to `--var-6`, and `+g`, aliased to `++var-7`, are so-called flags: Their presence or absence on the command line changes their value in a Boolean manner (though flags are less powerful than Booleans since you can't calculate with them). As you can see in the reported values, `var_6` has changed its value from `false` to `true`, just by giving the flag's *name*, instead of a real value. This means that you can check whether a flag had been set by evaluating the corresponding variable's value to `true` or `false`. Note that these are just mnemonics, they have no Boolean meaning (like upon testing in an [`if..else`](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#index-if "gnu.org &rightarrow; Conditional Constructs &rightarrow; if") statement) for the weakly typed Bash interpreter.

Similarly, `var_7` has become `false` instead of the default `true`. Here, unusually, the option name was not introduced by a hyphen, but a plus sign. For flags only, and only when [`ARGPARSER_ALLOW_FLAG_INVERSION`](../reference/environment_variables/environment_variables.md#946-argparser_allow_flag_inversion) is set to `true` (the default), it is possible to set the value to `true` by the normal hyphen, and to `false` by the plus sign, which, again, can be imagined as crossed hyphen. The default value is only taken when the flag is absent, else, their presence gives the value as `true` or `false`.

Precisely, giving `-g` or `--var-7` sets `var_7` to `true`, and giving `+g` or `++var-7` sets `var_7` to `false` (a crossed, *i.e.* negated, `true`). This behavior is used, for example, by the Bash [`set`](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html "gnu.org &rightarrow; The Set Builtin") builtin (like `set -x` to activate `xtrace` and `set +x` to deactivate it). Though the usage for long options is uncommon, it is enabled by the Argparser for consistency, such that long option&ndash;only flags can be used along normal long option&ndash;only arguments.

Further, when [`ARGPARSER_ALLOW_FLAG_NEGATION`](../reference/environment_variables/environment_variables.md#947-argparser_allow_flag_negation) is set to `true` (the default), flags can also be given by prepending their long option name by `no-`, *i.e.*, `--var-7` would become `--no-var-7`. This negates the flag's value as well, doubling its effect for `++no-var-7`&mdash;which would be a very obfuscated of saying `--var-7`.

Another interesting fact, unrelated to flags, is that the Argparser output a warning that `-g,-G,--var-7,--var-g` would be deprecated. This shows us that we can define arguments, and years later, when we want to change the command-line interface, we can set the obsolete arguments as deprecated, allowing the user to gradually adapt to the changes in his workflows employing your script. A common application would be the renaming of an option or the entire removal of its function.

Taking one final set of example invocations, we can see how the option merging works for flags:

<!-- <include command="ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A +fg" lang="console"> -->
```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A +fg
try_argparser.sh: Warning: The argument "-g,-G,--var-7,--var-g" is deprecated
                           and will be removed in the future.
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
<!-- </include> -->

We merged `var_6` and `var_7` in one call, `+fg`, thus setting them both to `false`.

<!-- <include command="ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -fgcA" lang="console"> -->
```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -fgcA
try_argparser.sh: Warning: The argument "-g,-G,--var-7,--var-g" is deprecated
                           and will be removed in the future.
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
<!-- </include> -->

Now, we gave them together with `var_3` and its value, and we see that the flags are set to `true`, owing to the hyphen, and that `-c` correctly interprets the following `A` as value, not as option `-A` (which would be an alias for `var_1`).

<!-- <include command="ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 +fgcA" lang="console"> -->
```console
$ ARGPARSER_ALLOW_OPTION_MERGING=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 +fgcA
try_argparser.sh: Error: The option "-c,-C,--var-3,--var-c" is no flag and thus
                         cannot be given with a "+" or "no-" prefix.

try_argparser.sh: Warning: The argument "-g,-G,--var-7,--var-g" is deprecated
                           and will be removed in the future.

Usage: try_argparser.sh [-h,-? | -u | -V]
                        [-d,-D={A-C}]
                        [-e,-E=VAL_5,E]
                        [-f,-F]
                        [-g,-G]
                        -a,-A=VAL_1,A
                        -b,-B=VAL_2,B...
                        -c,-C={A,B}...
                        [{1,2}]
                        pos_2
```
<!-- </include> -->

The tiny change of the prefix for the `fgcA` compound argument made our whole attempt fail: Since `var_3` is not a flag, we can't use the Boolean negation, here, and thus the Argparser yields an error. So, although specifying `+fg` is no problem, the merged `c` makes the parsing fail. Were `g` also defined to accept a value, the Argparser would have reported the error already here, since the following `cA` would have been seen as value to the option `+g`. This shows that care should be taken when merging option names.

When we set [`ARGPARSER_COUNT_FLAGS`](../reference/environment_variables/environment_variables.md#9418-argparser_count_flags) to `true`, the Argparser offers another great application of flags: counting. Suppose we want our script to support a varying level of verbosity for the `-v,--verbose` flag. Then, we could activate flag counting. Instead of reporting `true` or `false` values, the Argparser would count the number of the flag's occurrences on the command line, while respecting their prefixes. Together with short option merging, we could give `-vvv` for the third level of verbosity&mdash;the respective variable would be set to `3`. If, instead, we set `-v -v +v` (or `--verbose --verbose ++verbose`), it would be set to `1`. That is, for each hyphen prefix (affirmative version), the Argparser adds `1` to the initial value of `0`. For each plus-sign or `--no-` prefix (negated version), the Argparser subtracts `1`, and `0 + 1 + 1 - 1` is `1`, yielding our observed result. Without flag counting, the Argparser would report `false`, since the flag's last prefix (which "wins", *i.e.*, takes precedence) is a plus sign.

Let's investigate this with an example:

<!-- <include command="ARGPARSER_COUNT_FLAGS=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A +f -g --var-7" lang="console"> -->
```console
$ ARGPARSER_COUNT_FLAGS=true bash ../tutorial/try_argparser.sh 1 2 -a 1 -b 2 -c A +f -g --var-7
try_argparser.sh: Warning: The argument "-g,-G,--var-7,--var-g" is deprecated
                           and will be removed in the future.
The keyword argument "var_1" is set to "1".
The keyword argument "var_2" is set to "2".
The keyword argument "var_3" is set to "A".
The keyword argument "var_4" is set to "A".
The keyword argument "var_5" is set to "E".
The keyword argument "var_6" is set to "-1".
The keyword argument "var_7" is set to "2".
The positional argument "pos_1" on index 1 is set to "2".
The positional argument "pos_2" on index 2 is set to "1,2".
```
<!-- </include> -->

As you can see, `var_6` is reported to be `-1`, since it only given once, with a plus-sign prefix. `var_7`, in constrast, is `2`, because it was set twice with a hyphen prefix, once as short `-g` and once as long `--var-7`.

Flags that are absent from the command line are assigned their default value as usual, while converting `true` to `1` and `false` to `-1`. By this, a flag that has not been given and is `true` by default appears to have been given&mdash;it is `1`. When `false` by default, it is `-1`. Now, when `true` by default and given with a hyphen prefix, it is *also* `1`; and `-1` when given with a plus-sign prefix. When `false` by default and given with a hyphen prefix, it is *again* `1`; and `-1` when given with a plus-sign prefix. By this, the default values are converted to the same counts as if the flag had been given on the command line with the respective prefix, just as usual for `true` and `false`.

This behavior is unintuitive when considering `false` like in programming languages, where it is `0`; or like in Bash, where `true` is `0` and `false` any positive integer. For the Argparser, `false` must have the exact "arithmetic inverse" to `true`, such that a truthy value can completely absorb a falsy value. For convenience, the simplest integer fulfilling this requirement has been chosen, which is `1`. Thus, when counting flags, `true` is `1` and `false` is `-1`.

Allowing both types of prefixes to cancel out each other again comes in helpful when combining arguments from multiple sources on the same command line, or when typing multiple arguments and realizing that you set a flag too often. Both use cases should be rather rare in everyday usage, so the main advantage of flag counting, and indeed its reason of introduction to the Argparser, is the support of multiple levels of control for flag-controlled options, like the verbosity.

[&#129092;&nbsp;Table of contents (Tutorial)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.2. Argparser invocation&nbsp;&#129094;](argparser_invocation.md)
