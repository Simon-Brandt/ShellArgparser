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

### 9.1. Arguments definition

The arguments definition that the Argparser uses to parse the arguments and to create the help and usage messages shows a tabular structure with eleven columns. These columns are delimited by an [`ARGPARSER_ARG_DELIMITER_1`](environment_variables/environment_variables.md#9411-argparser_arg_delimiter_1) character each, by default a pipe (`"|"`). Since fields can be surrounded by an arbitrary number of spaces, visual alignment as true table is possible.

Additionally, a header must be given, using the identifiers shown below. By this, the order of the columns is arbitrary, but there should be little reason to deviate from the default order. Still, it is possible to omit columns, whose fields are then populated by default values.

The values in multi-value fields are delimited by an [`ARGPARSER_ARG_DELIMITER_2`](environment_variables/environment_variables.md#9412-argparser_arg_delimiter_2) character, by default a comma (`","`). The absence of a value is indicated by the empty string, resulting after trimming spaces. That is, a field consisting of only spaces means absence.

<!-- <toc title="Table of contents (Arguments definition)"> -->
#### Table of contents (Arguments definition)

1. [Argument ID (`id`)](#911-argument-id-id)
1. [Short option names (`short_opts`)](#912-short-option-names-short_opts)
1. [Long option names (`long_opts`)](#913-long-option-names-long_opts)
1. [Value names (`val_names`)](#914-value-names-val_names)
1. [Default values (`defaults`)](#915-default-values-defaults)
1. [Choice values (`choices`)](#916-choice-values-choices)
1. [Data type (`type`)](#917-data-type-type)
1. [Argument count (`arg_no`)](#918-argument-count-arg_no)
1. [Argument group (`arg_group`)](#919-argument-group-arg_group)
1. [Notes (`notes`)](#9110-notes-notes)
1. [Help text (`help`)](#9111-help-text-help)
<!-- </toc> -->

#### 9.1.1. Argument ID (`id`)

The argument identifier must be a valid variable identifier in Bash syntax (at least when [`ARGPARSER_SET_ARGS`](environment_variables/environment_variables.md#9436-argparser_set_args) is set to `true`, else, the ID is only used as key in associative arrays). These are defined as a word beginning with an alphabetic character or an underscore, followed by an arbitrary number of alphanumeric characters or underscores. In Bash's extglob syntax, the regular expression for verification may look like `[[:alpha:]_]*([[:word:]])`, assuming C locale.

#### 9.1.2. Short option names (`short_opts`)

The short option names must comprise exactly one character, thereby, no leading hyphen may be given. Multiple short option names that shall be treated as aliases for the same option must be separated by an [`ARGPARSER_ARG_DELIMITER_2`](environment_variables/environment_variables.md#9412-argparser_arg_delimiter_2) character. Bash is case-sensitive, so is the checking for option names. Thus, you would need to provide both `a` and `A` as short option names if you want both to be recognized. This distinction effectively allows doubling the number of available short option names defined as letters (`a-z` and `A-Z`).

#### 9.1.3. Long option names (`long_opts`)

The long option names must comprise more than one character, thereby, no leading hyphen may be given. Multiple long option names that shall be treated as aliases for the same option must be separated by an [`ARGPARSER_ARG_DELIMITER_2`](environment_variables/environment_variables.md#9412-argparser_arg_delimiter_2) character.

#### 9.1.4. Value names (`val_names`)

The value names are used as substitute for the uppercased option names in help and usage messages for non-flag options, *i.e.*, those requiring at least one argument. Setting a value name may render the help message clearer or more concise, like when having an option `--in-file` whose argument just needs to be shown as `FILE`. If no value name is given, or less than there are short or long option names, the remaining argument texts are filled with the respective option name in "screaming snake&ndash;cased" form, *i.e.*, uppercased with underscores instead of hyphens. For positional arguments, the value name is the only name that can be shown, thus, it is required in this case.

#### 9.1.5. Default values (`defaults`)

Positional and keyword arguments may have default values, which are assigned to the variables if the arguments aren't given on the command line. For flags and flag-like arguments (with an argument count of `0`, `*` or `?`), the default value must be either `true` or `false`.

#### 9.1.6. Choice values (`choices`)

It is possible to restrict the range of acceptable values for an argument to a set indicated by the choice values. If [default values](#915-default-values-defaults) are given, they must lie within the choice values. The choice values are delimited by [`ARGPARSER_ARG_DELIMITER_2`](environment_variables/environment_variables.md#9412-argparser_arg_delimiter_2) characters, while each item may be given as range in the form `1-9` or `A-Z-2`. The first hyphen-delimited value is the start character, the second the stop character (both inclusive), and the optional third value the step size, defaulting to `1`. The start and stop characters must be either integers, floats, or alphabetical characters (from the `[:alpha:]` POSIX character class), the step an integer or float (an integer for character sequences). `true` and `false` may not be given as choice values.

#### 9.1.7. Data type (`type`)

The Argparser defines several data types an argument may have. Using the regular expressions denoted below, the argument's value is compared to the data type. Still, Bash is weakly typed, and by this, the existence of a data type does not change the behavior of the variable. Nonetheless, you can use the type-checked value for certain computations, later on. It is mandatory that all default and choice values accord to the data type. The following data types are distinguished by the Argparser:

- *bool* (Boolean): either `true` or `false`, to be used for flags (not flag-like arguments)
- *char* (character): a string with length one (extglob regex: `[[:print:]]`)
- *float* (floating-point number): digits, possibly with a period in-between, optionally with a leading plus sign or a leading hyphen as minus sign (extglob regex: `?([+-])+([[:digit:]]).*([[:digit:]]` or `?([+-])*([[:digit:]]).+([[:digit:]])`)
- *file* (filepath): a filepath, currently unchecked
- *int* (integer): digits without period in-between, optionally with a leading plus sign or a leading hyphen as minus sign (extglob regex: `?([+-])+([[:digit:]])`)
- *str* (string): anything not fitting into the other data types, unchecked
- *uint* (unsigned integer): digits with neither a period in-between nor a leading sign (extglob regex: `+([[:digit:]])`)

#### 9.1.8. Argument count (`arg_no`)

The argument count defines the number of values a keyword or positional argument may accept. Independent of this count, the Argparser will aggregate any non-hyphenated value to the previous keyword argument, or, if none is given yet, add it to the positional arguments. The argument count may be given as natural number (*i.e.*, as unsigned integer), including `0` as sign for flags, or as plus sign (`+`), asterisk (`*`), or question mark (`?`). The latter mean to accept as many values as given, at least one, or at least zero, or zero to one, respectively.  These mirror a feature in the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module, which reflects their meaning in Perl-compatible regular expressions (PCRE).

#### 9.1.9. Argument group (`arg_group`)

The argument groups serve to group some arguments in the help message. One group shall comprise all positional arguments (if any is defined) and is named by [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables/environment_variables.md#9433-argparser_positional_arg_group). Any other argument group shall only contain keyword arguments (options), and is sorted alphabetically in the help message. In the future, argument groups might be expanded to allow actual grouping of arguments upon parsing, such that options may only be given together or mutually exclusively.

#### 9.1.10. Notes (`notes`)

The notes are intended to give additional information about arguments that don't warrant the introduction of a new column in the arguments definition. This is usually true for notes that are rarely used, where thus the column's fields would be mostly empty. Currently, only `"deprecated"` is supported, but this is expected to change. This token advises the Argparser to treat an argument as deprecated, emitting a warning when it is given on the command line. Since command-line interfaces are prone to change over time, this warning allows you to gradually change your CLI, introducing replacement option names or even removing the functionality prior to removing the argument itself. By this, your script's users can slowly adapt to the new CLI.

#### 9.1.11. Help text (`help`)

The help text should consist of a terse summary of the argument's function, like turning a feature on or off (which may be accomplished by flags), what a file is used for (like for input or output), or how your script's output may be modified. A help text can take any form, but be wary of it being wrapped to fit the width of the third column in the help message (if [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables/environment_variables.md#9431-argparser_max_col_width_3) is non-zero) or the total line length ([`ARGPARSER_MAX_WIDTH`](environment_variables/environment_variables.md#9432-argparser_max_width)). Help messages are no replacement for the manual, so the help text shouldn't be overly verbose.

[&#129092;&nbsp;Table of contents (Reference)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9.2. Colors and styles&nbsp;&#129094;](colors_and_styles.md)
