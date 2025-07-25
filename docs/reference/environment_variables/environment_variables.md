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

#### 9.4.2. `ARGPARSER_ADD_HELP`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_HELP_OPTIONS`](#9426-argparser_help_options) and `--help` as flags to call the help message.

#### 9.4.3. `ARGPARSER_ADD_USAGE`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_USAGE_OPTIONS`](#9450-argparser_usage_options) and `--usage` as flags to call the usage message.

#### 9.4.4. `ARGPARSER_ADD_VERSION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to add the [`ARGPARSER_VERSION_OPTIONS`](#9457-argparser_version_options) and `--version` as flags to call the version message.

#### 9.4.5. `ARGPARSER_ALLOW_FLAG_INVERSION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to allow the user to give flags with a prefixed `+` instead of `-` (for short option names) or `++` instead of `--` (for long option names) to negate their value. If [`ARGPARSER_ALLOW_FLAG_NEGATION`](#946-argparser_allow_flag_negation) is set to `true`, this doubles with the effect of using `no-` as prefix for long option names.

#### 9.4.6. `ARGPARSER_ALLOW_FLAG_NEGATION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to allow the user to give long option names for flags with a prefixed `no-` to negate their value.  If [`ARGPARSER_ALLOW_FLAG_INVERSION`](#945-argparser_allow_flag_inversion) is set to `true`, this doubles with the effect of using `++` as prefix, instead of `--`.

#### 9.4.7. `ARGPARSER_ALLOW_OPTION_ABBREVIATION`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give long option names in abbreviated form, *e.g.*, `--verb` for `--verbatim`, as long as no collision with *e.g.* `--verbose` arises. Short option names only span one character and thus cannot be abbreviated.

#### 9.4.8. `ARGPARSER_ALLOW_OPTION_MERGING`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to allow the user to give short option names in merged (concatenated) form, *e.g.*, `-ab1` or `-ab=1` for `-a -b 1`. The individual characters are interpreted as option names until an option has a number of required arguments greater than zero, *i.e.*, until an option is no flag. Long option names span multiple characters and thus cannot be merged in a meaningful way.

#### 9.4.9. `ARGPARSER_ARG_ARRAY_NAME`

- ***Type:*** *str* (String), but only characters allowed in a legit Bash variable identifier
- ***Allowed values:*** Any legit Bash variable identifier
- ***Default value:*** `"args"`
- ***Description:*** The name of an indexed array, under which the arguments are provided, and of an associative array, under which the parsed arguments can be accessed after calling the Argparser. The former stores the argument's identifier as key and its definition as value, but joined to one string by an [`ARGPARSER_ARG_DELIMITER_1`](#9411-argparser_arg_delimiter_1) character, the latter stores the identifier as key and its values as value. If [`ARGPARSER_SET_ARGS`](#9436-argparser_set_args) is `true`, you usually don't need to access this array as the arguments will be set as variables.

#### 9.4.10. `ARGPARSER_ARG_DEF_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the definition of the arguments. This file may be used by multiple scripts if they share some arguments. It is not necessary to use all arguments from there, as you need to specify which arguments you want to use. It is possible to set additional argument definitions within the script, which could come handy when scripts share some arguments (from the file), but also use some own arguments (from the script), whose names have another meaning in the companion script.

#### 9.4.11. `ARGPARSER_ARG_DELIMITER_1`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2), no hyphen (`-`), plus sign (`+`), asterisk (`*`), or question mark (`?`)
- ***Default value:*** `"|"`
- ***Description:*** The primary delimiter that separates the fields in the arguments definition. It must be set to a character or glyph that does not occur in the arguments definition or their values.

#### 9.4.12. `ARGPARSER_ARG_DELIMITER_2`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as [`ARGPARSER_ARG_DELIMITER_1`](#9411-argparser_arg_delimiter_1), no hyphen (`-`), plus sign (`+`), asterisk (`*`), or question mark (`?`)
- ***Default value:*** `","`
- ***Description:*** The secondary delimiter that separates the elements of sequences in the arguments definition. It must be set to a character or glyph that does not occur in the arguments definition or their values.

#### 9.4.13. `ARGPARSER_ARGS`

- ***Type:*** *arr* (Indexed, later associative array)
- ***Allowed values:*** *None*
- ***Default value:*** *None* (unset)
- ***Description:*** The indexed array in which the Argparser's options are stored, and later, the associative array for their values. This variable is for internal usage and *must not be set* in the configuration file, else, an error is thrown.

#### 9.4.14. `ARGPARSER_CHECK_ARG_DEF`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the arguments definition is consistent, *i.e.*, if there is at most one optional positional argument, if there is at most one positional argument with an infinite number of accepted values, if any keyword argument has at least one short or long option name given, with a length of exactly one or at least two characters, and no duplicate names (within its own definition and among all other arguments), if the number of default values equals the number of required values, if the default values lie in the choice values, if flags have a default value of `true` or `false` and no choice values, and if the choice and default values accord to the data type. This may only need to be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the arguments definition at some point (not recommended as it may lead to code injection!), you should activate it.

#### 9.4.15. `ARGPARSER_CHECK_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to check if the Argparser environment variables accord to their definition. Again, this may only need to be turned on (set to `true`) for testing purposes, while in production environments, keeping it deactivated saves some (minimal) computation time. Still, if the user can modify the environment variables at some point (not recommended as it may lead to code injection!), you should activate it.

#### 9.4.16. `ARGPARSER_CONFIG_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the Argparser configuration. The lines will be read into environment variables, but those that are already defined within your script or environment override the specification in the `ARGPARSER_CONFIG_FILE`. This file may be used by multiple scripts.

> [!CAUTION]
> The Argparser reads the lines into variables without checking them! If the user can modify the `ARGPARSER_CONFIG_FILE` (either the variable's value or the referenced file), this is prone to command injection!

#### 9.4.17. `ARGPARSER_COUNT_FLAGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to count flags instead of setting them to `true` or `false` based on the last prefix used on the command line. When `ARGPARSER_COUNT_FLAGS` is set to `false`, `-a -a +a` would result in `a` being set to `false`, since the last prefix was a plus sign. When `ARGPARSER_COUNT_FLAGS` is set to `true` instead, `a` would be set to `1`, as any `true` (hyphen) increases the count by `1` and any `false` (plus sign) decreases it by `1`. Flags that are absent from the command line are assigned `1` if their default value is `true`, and `-1` if their default value is `false`. This results in the same behavior when a flag is `true` per default and absent, or set with `-a` (yielding `a == 1`); or when a flag is `false` per default and absent, or set with `+a` (yielding `a == -1`). Counting flags can be helpful when, *e.g.*, different levels of verbosity are allowed. If [`ARGPARSER_ALLOW_OPTION_MERGING`](#948-argparser_allow_option_merging) is also set to `true`, the user can give `-vvv` on the command line for the third level of verbosity (given it's handled by your script).

#### 9.4.18. `ARGPARSER_ERROR_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually not zero
- ***Default value:*** `1`
- ***Description:*** The exit code when errors occurred upon parsing.

#### 9.4.19. `ARGPARSER_ERROR_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold,reverse"`
- ***Description:*** The color and style specification to use for error messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 9.4.20. `ARGPARSER_HELP_ARG_GROUP`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"Help options"`
- ***Description:*** The name of the argument group holding all help options. This group is usually the last in the help message.

#### 9.4.21. `ARGPARSER_HELP_DESCRIPTION`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `""`
- ***Description:*** The script's description, briefly indicating its purpose, to be shown in the help message.

#### 9.4.22. `ARGPARSER_HELP_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a help message was requested using the [`ARGPARSER_HELP_OPTIONS`](#9426-argparser_help_options)  or the `--help` flag.

#### 9.4.23. `ARGPARSER_HELP_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended help message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated help message (invoked with the [`ARGPARSER_HELP_OPTIONS`](#9426-argparser_help_options)  or `--help`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

#### 9.4.24. `ARGPARSER_HELP_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_HELP_FILE`](#9423-argparser_help_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_HELP_FILE`](#9423-argparser_help_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the help file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_HELP_FILE` is given.

#### 9.4.25. `ARGPARSER_HELP_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the help file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.*, `#`) in the help file also in the help message. This is only evaluated if an [`ARGPARSER_HELP_FILE`](#9423-argparser_help_file) is given.

#### 9.4.26. `ARGPARSER_HELP_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"h,?"`
- ***Description:*** The short option names used to call the help message. This is only evaluated if [`ARGPARSER_ADD_HELP`](#942-argparser_add_help) is `true`.

#### 9.4.27. `ARGPARSER_HELP_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for help messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 9.4.28. `ARGPARSER_LANGUAGE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"en"`
- ***Description:*** The language in which to localize the help, usage, error, and warning messages. This is only evaluated if an [`ARGPARSER_TRANSLATION_FILE`](#9440-argparser_translation_file) is given.

#### 9.4.29. `ARGPARSER_MAX_COL_WIDTH_1`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `5`
- ***Description:*** The maximum column width of the first column in the generated help message. This column holds the short options of the arguments, hence, it usually can be rather narrow. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_1`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_WIDTH`](#9432-argparser_max_width).

#### 9.4.30. `ARGPARSER_MAX_COL_WIDTH_2`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `33`
- ***Description:*** The maximum column width of the second column in the generated help message. This column holds the long options of the arguments, hence, it usually should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_2`. If it is less wide, the column is shrunk accordingly. For details, refer to [`ARGPARSER_MAX_WIDTH`](#9432-argparser_max_width).

#### 9.4.31. `ARGPARSER_MAX_COL_WIDTH_3`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any non-negative integer, including `0`
- ***Default value:*** `0`
- ***Description:*** The maximum column width of the third column in the generated help message. This column holds the help text of the arguments, hence, it usually should be rather wide. The column's content gets wrapped by line breaks if its width exceeds the `ARGPARSER_MAX_COL_WIDTH_3`. If it is less wide, the column is shrunk accordingly. A value of `0` disables this variable in favor of [`ARGPARSER_MAX_WIDTH`](#9432-argparser_max_width). For details, refer to `ARGPARSER_MAX_WIDTH`.

#### 9.4.32. `ARGPARSER_MAX_WIDTH`

- ***Type:*** *uint* (Unsigned integer)
- ***Allowed values:*** Any positive integer
- ***Default value:*** `79`
- ***Description:*** The maximum width of the entire generated help message. The widths of the first two columns are controlled by [`ARGPARSER_MAX_COL_WIDTH_1`](#9429-argparser_max_col_width_1) and [`ARGPARSER_MAX_COL_WIDTH_2`](#9430-argparser_max_col_width_2), respectively, whose contents are always wrapped by line breaks to fit this width, and shrunk if less wide. For the third column, [`ARGPARSER_MAX_COL_WIDTH_3`](#9431-argparser_max_col_width_3) may be set to `0` to disable this behavior in favor of a fixed width, set by `ARGPARSER_MAX_WIDTH`. Thereby, the third column takes up as much space as left, *i.e.*, the help message's maximum width minus the actual (not maximum) widths of the first two columns.  
It is recommendable to have a total width of the help message of 79 characters. As one space is always inserted as separation between the first and second column, as well as between the second and third column, the sum of `ARGPARSER_MAX_COL_WIDTH_1`, `ARGPARSER_MAX_COL_WIDTH_2`, and `ARGPARSER_MAX_COL_WIDTH_3` should equal 77. As long options are longer than short options, the second column should be far wider than the first. The help text in the third column consists of human-readable words and is thus less bound to word wrapping restrictions. By this, it is easier to set the third column's maximum width to 77 characters minus the total maximum width of the unwrapped first two columns to get an optimized help message layout&mdash;or use `ARGPARSER_MAX_WIDTH` for an actual, not maximum, width.

#### 9.4.33. `ARGPARSER_POSITIONAL_ARG_GROUP`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"Positional arguments"`
- ***Description:*** The name of the argument group holding all positional arguments. This group is usually the first in the help message.

#### 9.4.34. `ARGPARSER_READ_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to read the arguments from the command line (*i.e.*, from `"$@"`) and parse them to the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#949-argparser_arg_array_name) sets.

#### 9.4.35. `ARGPARSER_SCRIPT_NAME`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"${0##*/}"`
- ***Description:*** The name of your script as it should appear in the help, usage, version, error, and warning messages. By default, it is the name used upon invoking your script (`"$0"`), trimmed by everything before the last slash character (mimicking the behavior of [`basename`](https://man7.org/linux/man-pages/man1/basename.1.html "man7.org &rightarrow; man pages &rightarrow; basename(1)")).  
If, for example, you want to give your script a symlink, but don't want this symlink's name to be used in the help and usage messages, then you can provide a custom, canonicalized `ARGPARSER_SCRIPT_NAME`. Alternatively, if your script forms a sub-part of a larger program, it may be named `program_part.sh`, but should be called as `program name [ARGUMENTS]`. Then, `program.sh` could parse its positional argument `name` and call `program_part.sh`, but on the command line, you want to hide this implementation detail and refer to `program_part.sh` as `program name`, so you set `ARGPARSER_SCRIPT_NAME` accordingly.  
Further, setting `ARGPARSER_SCRIPT_NAME` is strictly necessary when running the Argparser from shells other than Bash, using pipes or process substitution. Then, it is impossible to obtain the caller's name using only Bash builtins and commands like [`ps`](https://man7.org/linux/man-pages/man1/ps.1.html "man7.org &rightarrow; man pages &rightarrow; ps(1)") would be needed&mdash;violating one of the Argparser's central design principles of no dependencies but Bash.

#### 9.4.36. `ARGPARSER_SET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set the parsed arguments from the associative array the [`ARGPARSER_ARG_ARRAY_NAME`](#949-argparser_arg_array_name) refers to as variables in the calling script's scope.

> [!CAUTION]
> The Argparser performs no complex sanity checks for argument values! Automatically setting them as variables to the script is prone to command injection!

#### 9.4.37. `ARGPARSER_SET_ARRAYS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to set arguments intended to have multiple values as indexed array. This is only evaluated if [`ARGPARSER_SET_ARGS`](#9436-argparser_set_args) is `true`. While it can be very helpful in a script to have the multiple values already set to an array that can be iterated over, the drawback is that arrays are hard to transfer to other scripts and may need to be serialized. Since they come in serialized form from the Argparser, a temporary expansion to an array might be unnecessary.

#### 9.4.38. `ARGPARSER_SILENCE_ERRORS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of error messages. This should rarely be needed since the Argparser still stops running after a critical failure (which is the reason for error messages), but it may clean up your output when logging. See also [`ARGPARSER_SILENCE_WARNINGS`](#9439-argparser_silence_warnings).

#### 9.4.39. `ARGPARSER_SILENCE_WARNINGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to silence the emission (output) of warning messages. Like [`ARGPARSER_SILENCE_ERRORS`](#9438-argparser_silence_errors), this should rarely be needed, but as the Argparser continues running after a non-critical failure (which is the reason for warning messages), these messages may not be strictly required for your script's user.

#### 9.4.40. `ARGPARSER_TRANSLATION_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a simplified [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") file holding the translation of (mostly) auto-generated parts in the help, usage, error, and warning messages. This file can be used by multiple scripts. As a YAML file, it contains the translation in a key&ndash;value layout, separated by colons and using significant indentation. Each group key must specify the language identifier used for the [`ARGPARSER_LANGUAGE`](#9428-argparser_language). As many languages as desired can be given, which allows the localization for multiple languages with just one `ARGPARSER_TRANSLATION_FILE`. The rows can be in any order, since they are read into an associative array, which, by definition, has no order.

#### 9.4.41. `ARGPARSER_UNSET_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) all command-line arguments given to the script. This is usually what you want, as the Argparser re-sets these values in parsed form. Note that this has no effect when the Argparser is called from shells other than Bash, since it would run in a child environment.

#### 9.4.42. `ARGPARSER_UNSET_ENV_VARS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) the Argparser environment variables from the environment. As long as you don't need these variables anymore or want to reset them prior to the next Argparser invokation, this is usually what you want. This prevents accidental (but also deliberate) inheritance to child scripts when passing the entire environment to them.

#### 9.4.43. `ARGPARSER_UNSET_FUNCTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to unset (remove) the Argparser functions from the environment. You should not need them separated from an Argparser invokation, where they're automatically defined (set) upon sourcing it. By unsetting them, the namespace is kept clean.

#### 9.4.44. `ARGPARSER_USAGE_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a usage message was requested using the [`ARGPARSER_USAGE_OPTIONS`](#9450-argparser_usage_options) or the `--usage` flag.

#### 9.4.45. `ARGPARSER_USAGE_FILE`

- ***Type:*** *file* (Filepath)
- ***Allowed values:*** Any legit filepath or the empty string `""`
- ***Default value:*** `""`
- ***Description:*** The path to a file holding the extended usage message. This file may be used by multiple scripts, even if they share no arguments. By this, the default structure and content of the auto-generated usage message (invoked with the [`ARGPARSER_USAGE_OPTIONS`](#9450-argparser_usage_options) or `--usage`) can be overridden for all scripts in a project in the same way, without repeating yourself upon specifying the look.

#### 9.4.46. `ARGPARSER_USAGE_FILE_INCLUDE_CHAR`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique character that's not used as a line's first character in an [`ARGPARSER_USAGE_FILE`](#9445-argparser_usage_file)
- ***Default value:*** `"@"`
- ***Description:*** The character that introduces an include directive in an [`ARGPARSER_USAGE_FILE`](#9445-argparser_usage_file). You must ensure that it is set to a character or glyph that does not occur as any line's first character in the usage file, where it should not mean an include directive. This is only evaluated if an `ARGPARSER_USAGE_FILE` is given.

#### 9.4.47. `ARGPARSER_USAGE_FILE_KEEP_COMMENTS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to keep commented lines (and their trailing blank lines) in the usage file. By this, you can choose whether you want to include lines serving as a comment (starting with a hashmark, *i.e.*, `#`) in the usage file also in the usage message. This is only evaluated if an [`ARGPARSER_USAGE_FILE`](#9445-argparser_usage_file) is given.

#### 9.4.48. `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"long"` and `"short"`
- ***Default value:*** `"short"`
- ***Description:*** Whether to use short or long option names in usage messages. If an option doesn't have short option names, its long option names are used, and *vice versa*.

#### 9.4.49. `ARGPARSER_USAGE_MESSAGE_ORIENTATION`

- ***Type:*** *str* (String)
- ***Allowed values:*** `"row"` and `"column"`
- ***Default value:*** `"row"`
- ***Description:*** Whether to output the positional and keyword arguments in usage messages in a row-like or in a column-like fashion.

#### 9.4.50. `ARGPARSER_USAGE_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"u"`
- ***Description:*** The short option names used to call the usage message. This is only evaluated if [`ARGPARSER_ADD_USAGE`](#943-argparser_add_usage) is `true`.

#### 9.4.51. `ARGPARSER_USAGE_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"italic"`
- ***Description:*** The color and style specification to use for usage messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 9.4.52. `ARGPARSER_USE_LONG_OPTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to accept long option names upon parsing and creating the help and usage messages. If your script doesn't take any long option, it may be practical to disable also the long options the Argparser sets, *viz.* `--help`, `--usage`, and `--version` (given that [`ARGPARSER_ADD_HELP`](#942-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#943-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#944-argparser_add_version), respectively, are set). Additionally, the help message will only have two columns (the short option names and the help texts), then.

#### 9.4.53. `ARGPARSER_USE_SHORT_OPTIONS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `true`
- ***Description:*** Whether to accept short option names upon parsing and creating the help and usage messages. If your script doesn't take any short option, it may be practical to disable also the short options the Argparser sets, *viz.* the [`ARGPARSER_HELP_OPTIONS`](#9426-argparser_help_options), the [`ARGPARSER_USAGE_OPTIONS`](#9450-argparser_usage_options), and the [`ARGPARSER_VERSION_OPTIONS`](#9457-argparser_version_options) (given that [`ARGPARSER_ADD_HELP`](#942-argparser_add_help), [`ARGPARSER_ADD_USAGE`](#943-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](#944-argparser_add_version), respectively, are set). Additionally, the help message will only have two columns (the long option names and the help texts), then.

#### 9.4.54. `ARGPARSER_USE_STYLES_IN_FILES`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to use the colors and styles from [`ARGPARSER_HELP_STYLE`](#9427-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](#9451-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](#9458-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](#9419-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](#9459-argparser_warning_style) when `STDOUT`/`STDERR` is not a terminal (and thus perhaps a file). This is useful to get plain 7-bit ASCII text output for files, while in interactive sessions, the escape sequences offer more user-friendly formatting and possibilities for highlighting. By this, you can parse your files afterwards more easily. Still, using *e.g.* [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"), these escape sequences can be displayed from files, when included.

#### 9.4.55. `ARGPARSER_VERSION`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any string
- ***Default value:*** `"1.0.0"`
- ***Description:*** The version number of your script to be used in the version message. Consider using [semantic versioning](https://semver.org/ "semver.org") or [calendar versioning](https://calver.org/ "calver.org"), *i.e.*, give version numbers by major version, minor version, and patch, separated by dots, or by year, month, and/or day of release, again separated by dots.

#### 9.4.56. `ARGPARSER_VERSION_EXIT_CODE`

- ***Type:*** *int* (Integer)
- ***Allowed values:*** Any integer, usually zero
- ***Default value:*** `0`
- ***Description:*** The exit code when a version message was requested using the [`ARGPARSER_VERSION_OPTIONS`](#9457-argparser_version_options) or the `--version` flag.

#### 9.4.57. `ARGPARSER_VERSION_OPTIONS`

- ***Type:*** *char* (Character)
- ***Allowed values:*** Any unique short-option character that's not used in the arguments definition
- ***Default value:*** `"V"`
- ***Description:*** The short option names used to call the version message. This is only evaluated if [`ARGPARSER_ADD_VERSION`](#944-argparser_add_version) is `true`.

#### 9.4.58. `ARGPARSER_VERSION_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"bold"`
- ***Description:*** The color and style specification to use for version messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 9.4.59. `ARGPARSER_WARNING_STYLE`

- ***Type:*** *str* (String)
- ***Allowed values:*** Any [`ARGPARSER_ARG_DELIMITER_2`](#9412-argparser_arg_delimiter_2)-separated string consisting of a color and/or style, with the colors being `"black"`, `"red"`, `"green"`, `"yellow"`, `"blue"`, `"magenta"`, `"cyan"`, and `"white"`, and the styles being `"normal"`, `"bold"`, `"faint"`, `"italic"`, `"underline"`, `"double"`, `"overline"`, `"crossed-out"`, `"blink"`, and `"reverse"`
- ***Default value:*** `"red,bold"`
- ***Description:*** The color and style specification to use for warning messages, internally implemented as [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters").

#### 9.4.60. `ARGPARSER_WRITE_ARGS`

- ***Type:*** *bool* (Boolean)
- ***Allowed values:*** `true` and `false`
- ***Default value:*** `false`
- ***Description:*** Whether to write the parsed arguments from [`ARGPARSER_ARG_ARRAY_NAME`](#949-argparser_arg_array_name) to `STDOUT`. This is required for running the Argparser in a pipe to be able to access the parsed arguments. These are output as key&ndash;value pairs, separated by linefeeds.

[&#129092;&nbsp;9.4.1. Overview](overview.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9.5. Translations&nbsp;&#129094;](../translations/introduction.md)
