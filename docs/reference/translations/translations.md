<!--
###############################################################################
#                                                                             #
# Copyright 2025-2026 Simon Brandt                                            #
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

#### 9.5.1. `Help description`

- ***Message:*** `""`
- ***Description:*** The script's description, indicating its purpose in the help message, *i.e.*, the translated [`ARGPARSER_HELP_DESCRIPTION`](../environment_variables/environment_variables.md#9427-argparser_help_description). The value is empty by default, and hence also the translations.

#### 9.5.2. `Subcommands`

- ***Message:*** `Subcommands`
- ***Description:*** The name of the subcommands' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_SUBCOMMAND_GROUP`](../environment_variables/environment_variables.md#9447-argparser_subcommand_group).

#### 9.5.3. `Positional arguments`

- ***Message:*** `Positional arguments`
- ***Description:*** The name of the positional arguments' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#9439-argparser_positional_arg_group).

#### 9.5.4. `Help options`

- ***Message:*** `Help options`
- ***Description:*** The name of the help options' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#9426-argparser_help_arg_group).

#### 9.5.5. `Usage`

- ***Message:*** `Usage`
- ***Description:*** The word `"Usage"` in help and usage messages.

#### 9.5.6. `Version`

- ***Message:*** `Version`
- ***Description:*** The word `"Version"` in version messages.

#### 9.5.7. `Error`

- ***Message:*** `Error`
- ***Description:*** The word `"Error"` in error messages.

#### 9.5.8. `Errors`

- ***Message:*** `Errors`
- ***Description:*** The word `"Errors"` in error messages.

#### 9.5.9. `Warning`

- ***Message:*** `Warning`
- ***Description:*** The word `"Warning"` in warning messages.

#### 9.5.10. `Warnings`

- ***Message:*** `Warnings`
- ***Description:*** The word `"Warnings"` in warning messages.

#### 9.5.11. `Arguments`

- ***Message:*** `ARGUMENTS`
- ***Description:*** The word `"ARGUMENTS"` in help messages, to show the existence of mandatory options (those without a default value).

#### 9.5.12. `Options`

- ***Message:*** `OPTIONS`
- ***Description:*** The word `"OPTIONS"` in help messages, to show the existence of optional options (those with a default value).

#### 9.5.13. `Deprecated`

- ***Message:*** `DEPRECATED`
- ***Description:*** The word `"DEPRECATED"` in help messages, to show that an argument is deprecated and shouldn't be used, anymore.

#### 9.5.14. `Default`

- ***Message:*** `default`
- ***Description:*** The word `"default"` in help messages, to introduce the default values.

#### 9.5.15. `true`

- ***Message:*** `true`
- ***Description:*** The default value of `true` in help messages.

#### 9.5.16. `false`

- ***Message:*** `false`
- ***Description:*** The default value of `false` in help messages.

#### 9.5.17. `--help`

- ***Message:*** `display this help and exit`
- ***Description:*** the help text for the help options, *i.e.*, the [`ARGPARSER_HELP_OPTIONS`](../environment_variables/environment_variables.md#9432-argparser_help_options), if [`ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md#942-argparser_add_help) is set to `true`.

#### 9.5.18. `--usage`

- ***Message:*** `display the usage and exit`
- ***Description:*** the help text for the usage options, *i.e.*, the [`ARGPARSER_USAGE_OPTIONS`](../environment_variables/environment_variables.md#9458-argparser_usage_options), if [`ARGPARSER_ADD_USAGE`](../environment_variables/environment_variables.md#943-argparser_add_usage) is set to `true`.

#### 9.5.19. `--version`

- ***Message:*** `display the version and exit`
- ***Description:*** the help text for the version options, *i.e.*, the [`ARGPARSER_VERSION_OPTIONS`](../environment_variables/environment_variables.md#9468-argparser_version_options), if [`ARGPARSER_ADD_VERSION`](../environment_variables/environment_variables.md#944-argparser_add_version) is set to `true`.

#### 9.5.20. `Remark mandatory optional arguments`

- ***Message:*** `Mandatory or optional arguments to long options are mandatory or optional for short options too.`
- ***Description:*** The remark that mandatory or optional arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#936-remark-directive) include directive.

#### 9.5.21. `Remark mandatory arguments`

- ***Message:*** `Mandatory arguments to long options are mandatory for short options too.`
- ***Description:*** The remark that mandatory arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#936-remark-directive) include directive.

#### 9.5.22. `Remark optional arguments`

- ***Message:*** `Optional arguments to long options are optional for short options too.`
- ***Description:*** The remark that optional arguments to long options are optional for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#936-remark-directive) include directive.

#### 9.5.23. `Error include directive`

- ***Message:*** `Error: The include directive "$1" could not be recognized.`
- ***Description:*** The error that an include directive cannot be parsed.
- ***Reasons for error:*** When parsing the [`ARGPARSER_HELP_FILE`](../environment_variables/environment_variables.md#9429-argparser_help_file) or [`ARGPARSER_USAGE_FILE`](../environment_variables/environment_variables.md#9453-argparser_usage_file), the Argparser found an include directive that is not supported.
- ***Interpolated variables:***
  - `$1`: The include directive.

#### 9.5.24. `Error env var bool`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that an environment variable is not a Boolean.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value not according to the data type `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.25. `Error env var char`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that an environment variable is not a character.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value not according to the data type `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.26. `Error env var identifier`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but designed to be used as Bash variable identifier, i.e., its value must start with a letter or underscore and contain only letters, digits, and underscores.`
- ***Description:*** The error that an environment variable is not usable as a Bash variable identifier.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value not matched by the regular expression `[[:alpha:]_]*([[:word:]])` in Bash's extglob syntax.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.27. `Error env var int`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that an environment variable is not an integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value not according to the data type `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.28. `Error env var uint`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that an environment variable is not an unsigned integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value not according to the data type `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.29. `Error env var file 0001`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is empty.`
- ***Description:*** The error that an environment variable refers to an empty file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.30. `Error env var file 0010`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not readable.`
- ***Description:*** The error that an environment variable refers to a file which is not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.31. `Error env var file 0011`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not readable and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.32. `Error env var file 0100`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file.`
- ***Description:*** The error that an environment variable refers to a file which is not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.33. `Error env var file 0101`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.34. `Error env var file 0110`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file and not readable.`
- ***Description:*** The error that an environment variable refers to a file which is not a regular file and also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.35. `Error env var file 0111`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file, not readable, and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file and not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.36. `Error env var file 1111`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file does not exist.`
- ***Description:*** The error that an environment variable refers to a nonexistent file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to point to a file, but this file does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.37. `Error env var delimiters reserved`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but hyphens, plus signs, asterisks, and question marks are reserved characters.`
- ***Description:*** The error that an environment variable uses a reserved character as arguments definition delimiter.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#9414-argparser_arg_delimiter_1) or [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#9415-argparser_arg_delimiter_2), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value used as argument delimiter, but the respective character is reserved. Hyphens may be used to indicate `STDIN`, while plus signs are used to denote arguments accepting an infinite number of arguments (at least one). Asterisks and question marks are reserved for the same reason, as they will be used to indicate other argument counts in a later Argparser version. Additionally, hyphens and plus signs are used as option prefixes on the command line (not in the arguments definition), so may be confused with prefixes when given in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 9.5.38. `Error env var styles`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the values must lie in {$3} for colors and in {$4} for styles.  Colors, only, may be prefixed by "bright_" or suffixed by "_fg" or "_bg".`
- ***Description:*** The error that an environment variable refers to an undefined [color or style](../colors_and_styles.md#92-colors-and-styles).
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value intended to set a message color or style which does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.
  - `$3`: The available colors.
  - `$4`: The available text styles.

#### 9.5.39. `Error env var style usage`

- ***Message:*** `Error: The environment variable "ARGPARSER_USE_STYLES" must be in {$1}, but is "$2".`
- ***Description:*** The error that the environment variable [`ARGPARSER_USE_STYLES`](../environment_variables/environment_variables.md#9463-argparser_use_styles) is not set to `always`, `never`, `file`, or `tty`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_USE_STYLES`](../environment_variables/environment_variables.md#9463-argparser_use_styles), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value other than `always`, `never`, `file`, and `tty`. Since there are only files and TTYs where the help, usage, version, error, and warning messages may be redirected to, other values are refused.
- ***Interpolated variables:***
  - `$1`: The available style usages.
  - `$2`: The environment variable's value.

#### 9.5.40. `Error env var option type`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" must be either set to "long" or "short", but is "$1".`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#9456-argparser_usage_message_option_type) is not set to `long` or `short`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#9456-argparser_usage_message_option_type), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value other than `long` and `short`. Since there are only short and long option names possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 9.5.41. `Error env var orientation`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_ORIENTATION" must be either set to "row" or "column", but is "$1".`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../environment_variables/environment_variables.md#9457-argparser_usage_message_orientation) is not set to `row` or `column`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../environment_variables/environment_variables.md#9457-argparser_usage_message_orientation), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value other than `row` and `column`. Since only a row-like or column-like structure is possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 9.5.42. `Error env var delimiters identical`

- ***Message:*** `Error: The environment variables "ARGPARSER_ARG_DELIMITER_1" and "ARGPARSER_ARG_DELIMITER_2" must have different values, but are both "$1".`
- ***Description:*** The error that the environment variables [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#9414-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#9415-argparser_arg_delimiter_2) have an identical value.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variables `ARGPARSER_ARG_DELIMITER_1` and `ARGPARSER_ARG_DELIMITER_2`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, have the same value. This renders parsing of the arguments definition impossible, as multi-value fields cannot be told apart from column delimiters.
- ***Interpolated variables:***
  - `$1`: The environment variables' common value.

#### 9.5.43. `Error env var option name empty`

- ***Message:*** `Error: The environment variable "$1" has an empty string given as one of the $2 option names, instead of a legit name.`
- ***Description:*** The error that an environment variable uses the empty string (`""`) as option name.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has an option name defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The number of option names.

#### 9.5.44. `Error env var option name duplication 1`

- ***Message:*** `Error: The environment variable "$1" has the short option "-$2" given $3 times.`
- ***Description:*** The error that an environment variable has a short option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a short option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 9.5.45. `Error env var option name duplication 2`

- ***Message:*** `Error: The environment variable "$1" has the long option "--$2" given $3 times.`
- ***Description:*** The error that an environment variable has a long option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a long option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The long option name.
  - `$3`: The number of occurrences of the long option name.

#### 9.5.46. `Error env var option name duplication 3`

- ***Message:*** `Error: The environment variable "$1" has the short option "-$2" given, but that is already in use by "$3".`
- ***Description:*** The error that at least two environment variables have the same short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a short option defined, which is already in use by a previously parsed environment variable. When given on the command line, it would be unclear which environment variable would be referred to.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The short option name.
  - `$3`: The previous environment variable's name.

#### 9.5.47. `Error env var option name duplication 4`

- ***Message:*** `Error: The environment variable "$1" has the long option "--$2" given, but that is already in use by "$3".`
- ***Description:*** The error that at least two environment variables have the same long option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a long option defined, which is already in use by a previously parsed environment variable. When given on the command line, it would be unclear which environment variable would be referred to.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The long option name.
  - `$3`: The previous environment variable's name.

#### 9.5.48. `Error env var short options`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" requests the usage of short option names, but "ARGPARSER_USE_SHORT_OPTIONS" turns them off.`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#9540-error-env-var-option-type) requests short option names, while [`ARGPARSER_USE_SHORT_OPTIONS`](../environment_variables/environment_variables.md#9462-argparser_use_short_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#9456-argparser_usage_message_option_type), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, is set to `short`, while [`ARGPARSER_USE_SHORT_OPTIONS`](../environment_variables/environment_variables.md#9462-argparser_use_short_options) is set to `false`. Consequently, the usage message could not be created, since no short option name is available.

#### 9.5.49. `Error env var long options`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" requests the usage of long option names, but "ARGPARSER_USE_LONG_OPTIONS" turns them off.`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#9540-error-env-var-option-type) requests long option names, while [`ARGPARSER_USE_LONG_OPTIONS`](../environment_variables/environment_variables.md#9461-argparser_use_long_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#9456-argparser_usage_message_option_type), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, is set to `long`, while [`ARGPARSER_USE_LONG_OPTIONS`](../environment_variables/environment_variables.md#9461-argparser_use_long_options) is set to `false`. Consequently, the usage message could not be created, since no long option name is available.

#### 9.5.50. `Error env var files`

- ***Message:*** `Error: The environment variables "$1" and "$2" point to the same file.`
- ***Description:*** The error that two environment variables refer to the same file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has a value pointing to the same file as an earlier parsed environment variable. Since the files referred to by these environment variables have different meanings (like the Argparser configuration and translation), it is impossible that both information is given in the same file.
- ***Interpolated variables:***
  - `$1`: The first environment variable's name.
  - `$2`: The second environment variable's name.

#### 9.5.51. `Error env var negation prefix empty`

- ***Message:*** `Error: The environment variable "ARGPARSER_FLAG_NEGATION_PREFIXES" has an empty string given as prefix, instead of a legit prefix.`
- ***Description:*** The error that the environment variable [`ARGPARSER_FLAG_NEGATION_PREFIXES`](../environment_variables/environment_variables.md#9425-argparser_flag_negation_prefixes) uses the empty string (`""`) as prefix.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#9418-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_FLAG_NEGATION_PREFIXES`](../environment_variables/environment_variables.md#9425-argparser_flag_negation_prefixes), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#9419-argparser_config_file), on the Argparser invocation command line, or as an environment variable, has prefixes defined, where at least one prefix of which is empty. No flag could be negated with this prefix.

#### 9.5.52. `Error YAML`

- ***Message:*** `Error: The YAML line "$1" could not be recognized.`
- ***Description:*** The error that a translation file's [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") line cannot be parsed.
- ***Reasons for error:*** When parsing the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#9448-argparser_translation_file), the Argparser found a YAML line that it doesn't recognize. This is most likely due to a YAML feature that the Argparser doesn't support to keep the parser simple.
- ***Interpolated variables:***
  - `$1`: The YAML line.

#### 9.5.53. `Warning no identifier`

- ***Message:*** `Warning: In the translation file "$1", the identifier "$2" is missing.  For convenience, the untranslated string is used, instead.`
- ***Description:*** The warning that in a translation file, an identifier is missing.
- ***Reasons for warning:*** When trying to translate a string from the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#9448-argparser_translation_file), the Argparser found that the identifier is missing in the dictionary, and by this, also in the translation file. Thus, it uses the untranslated English string as fallback.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#9448-argparser_translation_file).
  - `$2`: The missing identifier.

#### 9.5.54. `Warning no translation`

- ***Message:*** `Warning: In the translation file "$1", the translation to "$2" for the identifier "$3" is missing.  For convenience, the untranslated string is used, instead.`
- ***Description:*** The warning that in a translation file, an identifier's translation is missing.
- ***Reasons for warning:*** When trying to translate a string from the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#9448-argparser_translation_file), the Argparser found that the translation to the [`ARGPARSER_LANGUAGE`](../environment_variables/environment_variables.md#9434-argparser_language) for the identifier is missing in the dictionary, and by this, also in the translation file. Thus, it uses the untranslated English string as fallback.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#9448-argparser_translation_file).
  - `$2`: The [`ARGPARSER_LANGUAGE`](../environment_variables/environment_variables.md#9434-argparser_language).
  - `$3`: The identifier with missing translation.

#### 9.5.55. `Warning style file message key`

- ***Message:*** `Warning: In the style file "$1", the line "$2" sets a non-existent message key.`
- ***Description:*** The warning that a style file's line sets a non-existent message key.
- ***Reasons for warning:*** When parsing the [`ARGPARSER_STYLE_FILE`](../environment_variables/environment_variables.md#9446-argparser_style_file), the Argparser found a line that sets a message key (the part before the equals sign) which the Argparser never uses, and which is thus unnecessary to give.
- ***Interpolated variables:***
  - `$1`: The style file.
  - `$2`: The line.

#### 9.5.56. `Error style file equals sign`

- ***Message:*** `Error: In the style file "$1", the line "$2" doesn't contain an equals sign ("="), nor is it empty or commented.`
- ***Description:*** The error that a style file's line cannot be parsed.
- ***Reasons for error:*** When parsing the [`ARGPARSER_STYLE_FILE`](../environment_variables/environment_variables.md#9446-argparser_style_file), the Argparser found a line that it doesn't recognize. Each line must contain key&ndash;value pairs, delimited by an equals sign (`"="`), or be entirely empty, or start with a hashmark (`"#"`), indicating the line to be commented.
- ***Interpolated variables:***
  - `$1`: The style file.
  - `$2`: The line.

#### 9.5.57. `Error style file frame styles`

- ***Message:*** `Error: The style "$1" is set to "$2", but the values must lie in {$3} for colors and in {$4} for frame styles.  Colors, only, may be prefixed by \"bright_\" or suffixed by \"_fg\" or \"_bg\".`
- ***Description:*** The error that a style file's line refers to an undefined [color or frame style](../colors_and_styles.md#92-colors-and-styles).
- ***Reasons for error:*** When parsing the [`ARGPARSER_STYLE_FILE`](../environment_variables/environment_variables.md#9446-argparser_style_file), the Argparser found a line trying to set a frame color or frame style which does not exist.
- ***Interpolated variables:***
  - `$1`: The style's message key.
  - `$2`: The style.
  - `$3`: The available colors.
  - `$4`: The available frame styles.

#### 9.5.58. `Error style file text styles`

- ***Message:*** `Error: The style "$1" is set to "$2", but the values must lie in {$3} for colors and in {$4} for text styles.  Colors, only, may be prefixed by "bright_" or suffixed by "_fg" or "_bg".`
- ***Description:*** The error that a style file's line refers to an undefined [color or text style](../colors_and_styles.md#92-colors-and-styles).
- ***Reasons for error:*** When parsing the [`ARGPARSER_STYLE_FILE`](../environment_variables/environment_variables.md#9446-argparser_style_file), the Argparser found a line trying to set a text/message color or text/message style which does not exist.
- ***Interpolated variables:***
  - `$1`: The style's message key.
  - `$2`: The style.
  - `$3`: The available colors.
  - `$4`: The available text styles.

#### 9.5.59. `Error arg array 1`

- ***Message:*** `Error: Calling (instead of sourcing) the Argparser requires the arguments definition to be provided through STDIN, separated by newlines.  Either pipe to the Argparser or use process substitution to give input.  Alternatively, try "$1 --help" to get a help message with further information.`
- ***Description:*** The error that no arguments definition has been provided upon calling the Argparser.
- ***Reasons for error:*** When calling (and not sourcing) the Argparser, the arguments definition must be provided through `STDIN`, either by piping or by process substitution. However, `STDIN` (file descriptor `0`) has been deemed empty.
- ***Interpolated variables:***
  - `$1`: The path to the Argparser, as [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#9441-argparser_script_name).

#### 9.5.60. `Error arg array 2`

- ***Message:*** `Error: The variable ARGPARSER_ARG_ARRAY_NAME refers to "$1", but this variable is not defined.  Either you have given your arguments array another name (maybe "$2" -- then change ARGPARSER_ARG_ARRAY_NAME accordingly) or you forgot defining the array at all (then define it).`
- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name). If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"` and reports the first match.
- ***Interpolated variables:***
  - `$1`: The variable [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name) refers to.
  - `$2`: The guesstimated actual name of the variable.

#### 9.5.61. `Error arg array 3`

- ***Message:*** `Error: The variable ARGPARSER_ARG_ARRAY_NAME refers to "$1", but this variable is not defined.  Either you have given your arguments array another name (then change ARGPARSER_ARG_ARRAY_NAME accordingly) or you forgot defining the array at all (then define it).`
- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name). If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"`, but didn't find any match.
- ***Interpolated variables:***
  - `$1`: The variable [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#9412-argparser_arg_array_name) refers to.

#### 9.5.62. `Error no arg def`

- ***Message:*** `Error: No argument definition for "$1".`
- ***Description:*** The error that an argument is lacking a definition.
- ***Reasons for error:*** When reading the arguments definition, the Argparser found a definition line giving only an argument name, but no definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 9.5.63. `Error arg def id`

- ***Message:*** `Error: In the arguments definition in "$1", the column "id" is missing.`
- ***Description:*** The error that the arguments definition in the script lacks the `id` column.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#9441-argparser_script_name) with the problematic definition.

#### 9.5.64. `Error arg def file id`

- ***Message:*** `Error: In the arguments definition file "$1", the column "id" is missing.`
- ***Description:*** The error that the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file) lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file), the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file) with the problematic definition.

#### 9.5.65. `Error arg def field count`

- ***Message:*** `Error: In the arguments definition in "$1", the field count of the line "$2" ($3) doesn't match the header's field count ($4).`
- ***Description:*** The error that in the arguments definition in the script, the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#9441-argparser_script_name) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 9.5.66. `Error arg def file field count`

- ***Message:*** `Error: In the arguments definition file "$1", the field count of the line "$2" ($3) doesn't match the header's field count ($4).`
- ***Description:*** The error that in the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file), the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file), the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#9413-argparser_arg_def_file) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 9.5.67. `Error arg def choice range hyphens`

- ***Message:*** `Error: The argument with the identifier "$1" has more hyphens in the choice values given than supported (2).`
- ***Description:*** The error that in the arguments definition, an argument uses more than two hyphens in a choice value range.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a set of choice values defined, where at least one uses more than two hyphens to indicate a range. Zero hyphens means the literal value, one hyphen the range with step size `1`, and two hyphens the range with the given step size. Three hyphens or more aren't meaningful and hence not supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.68. `Error arg def choice range`

- ***Message:*** `Error: The argument with the identifier "$1" has choice values given with "$2" as start, "$3" as stop, and "$4" as step size, while only integer, float, or letter sequences are supported.`
- ***Description:*** The error that in the arguments definition, an argument uses non-integer, non-float, or non-letter characters in a choice value range.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a set of choice values defined, where at least one uses non-integer, non-float, or non-letter characters to indicate a range. Both the start and stop value may be either integers, floats, or alphabetical characters (letters), the step size may be an integer or float. It must be an integer for letter sequences. Any other character is not supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The start value.
  - `$3`: The stop value.
  - `$4`: The step size.

#### 9.5.69. `Error arg def subcommand id`

- ***Message:*** `Error: The subcommand with the identifier "$1" does not use a valid Bash identifier.`
- ***Description:*** The error that in the arguments definition, a subcommand uses an invalid identifier.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined whose identifier does not match the regex for valid Bash identifiers. This subcommand could not be set to a variable after parsing.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.70. `Error arg def subcommand subcommand`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a nested subcommand defined, which is not supported.`
- ***Description:*** The error that in the arguments definition, a subcommand has a subcommand given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined for another subcommand, nesting them. This is not yet supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.71. `Error arg def subcommand short name`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a short option name defined, while only value names are supported.`
- ***Description:*** The error that in the arguments definition, a subcommand has a short option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a short option name, but only value names are meaningful for subcommands.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.72. `Error arg def subcommand long name`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a long option name defined, while only value names are supported.`
- ***Description:*** The error that in the arguments definition, a subcommand has a long option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a long option name, but only value names are meaningful for subcommands.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.73. `Error arg def subcommand value name 1`

- ***Message:*** `Error: The subcommand with the identifier "$1" has no value name defined, while 1 is required.`
- ***Description:*** The error that in the arguments definition, a subcommand is missing the value name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined which lacks a value name, which is required for passing the subcommand on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.74. `Error arg def subcommand value name 2`

- ***Message:*** `Error: The subcommand with the identifier "$1" has $2 value names defined, while 1 is required.`
- ***Description:*** The error that in the arguments definition, a subcommand has too many value names defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined which has more than one value name defined, while exactly one is required for passing the subcommand on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of defined value names.

#### 9.5.75. `Error arg def subcommand value name duplication`

- ***Message:*** `The subcommand with the identifier "$1" has the value name "$2" defined, but that is already in use by "$3".`
- ***Description:*** The error that in the arguments definition, a subcommand uses the same value name as another subcommand.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with the same value name as already defined for another subcommand. This makes parsing the value name ambiguous.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The value name.
  - `$3`: The previously parsed subcommand's identifier.

#### 9.5.76. `Error arg def subcommand default value`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a default value defined, but cannot take a value.`
- ***Description:*** The error that in the arguments definition, a subcommand has a default value defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a default value, while subcommands only use value names to indicate their presence, without being able to take a value as argument. Thus, a default value is not needed.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.77. `Error arg def subcommand choice value`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a choice value defined, but cannot take a value.`
- ***Description:*** The error that in the arguments definition, a subcommand has a choice value defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a choice value, while subcommands only use value names to indicate their presence, without being able to take a value as argument. Thus, a choice value is not needed.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.78. `Error arg def subcommand type`

- ***Message:*** `Error: The subcommand with the identifier "$1" has a data type defined, but cannot take a value.`
- ***Description:*** The error that in the arguments definition, a subcommand has a data type defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a data type, while subcommands only use value names to indicate their presence, without being able to take a value as argument. Thus, a data type is not needed.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.79. `Error arg def subcommand arg number`

- ***Message:*** `Error: The subcommand with the identifier "$1" has an argument number defined, but cannot take a value.`
- ***Description:*** The error that in the arguments definition, a subcommand has an argument number defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with an argument number, while subcommands only use value names to indicate their presence, without being able to take a value as argument. Thus, an argument number is not needed.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.80. `Error arg def subcommand arg group`

- ***Message:*** `Error: The subcommand with the identifier "$1" is defined for the argument group "$2", while all subcommands must belong to "$3", as defined by the ARGPARSER_SUBCOMMAND_GROUP.`
- ***Description:*** The error that in the arguments definition, a subcommand is defined for the wrong argument group.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined for an argument group other than the [`ARGPARSER_SUBCOMMAND_GROUP`](../environment_variables/environment_variables.md#9447-argparser_subcommand_group). For grouping purposes in the help message, all subcommands must belong to this group.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The argument group.
  - `$3`: The [`ARGPARSER_SUBCOMMAND_GROUP`](../environment_variables/environment_variables.md#9447-argparser_subcommand_group).

#### 9.5.81. `Error arg def subcommand note`

- ***Message:*** `Error: The subcommand with the identifier "$1" has "$2" given as note, but only "deprecated" and "hidden" are supported.`
- ***Description:*** The error that in the arguments definition, a subcommand has an unsupported note given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined with a note other than `"deprecated"` and `"hidden"`. Currently, the Argparser doesn't support any other note, but may do so in the future, so any other value is reserved for future usage.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 9.5.82. `Warning arg def subcommand help text`

- ***Message:*** `Warning: The subcommand with the identifier "$1" has no help text defined, but for user-friendliness, defining one is recommended.`
- ***Description:*** The warning that in the arguments definition, a subcommand lacks a help text.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a subcommand defined without help text. Specifying one is highly recommended for useful help messages.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.83. `Error arg def pos id`

- ***Message:*** `Error: The positional argument with the identifier "$1" does not use a valid Bash identifier.`
- ***Description:*** The error that in the arguments definition, a positional argument uses an invalid identifier.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined whose identifier does not match the regex for valid Bash identifiers. This argument could not be set to a variable after parsing.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.84. `Error arg def pos subcommand`

- ***Message:*** `Error: The positional argument with the identifier "$1" has more than one subcommand defined, which is not supported.`
- ***Description:*** The error that in the arguments definition, a positional argument has more than one subcommand given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined for at least two subcommands. This is not yet supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.85. `Error arg def pos default value flag`

- ***Message:*** `Error: The positional argument with the identifier "$1" must have its default value set to "true" or "false" (as it is allowed to take 0 values), but has {$2} defined.`
- ***Description:*** The error that in the arguments definition, a flag-like positional argument has a non-Boolean default value.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting no value, *i.e.*, as a flag-like argument. Thus, the default value, if given, must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.86. `Error arg def pos default value 1`

- ***Message:*** `Error: The positional argument with the identifier "$1" requires 1 value, but has $2 given as default values.`
- ***Description:*** The error that in the arguments definition, a positional argument's number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 9.5.87. `Error arg def pos default value 2`

- ***Message:*** `Error: The positional argument with the identifier "$1" requires $2 values, but has $3 given as default values.`
- ***Description:*** The error that in the arguments definition, a positional argument's number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 9.5.88. `Error arg def pos choice value true false`

- ***Message:*** `Error: The positional argument with the identifier "$1" has {$2} given as choice values, while "true" and "false" cannot be any.`
- ***Description:*** The error that in the arguments definition, a positional argument that can take zero values has choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with choice values including `true` and/or `false`. These are included for flag-like arguments by definition, and disallowed for all other argument counts.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.

#### 9.5.89. `Error arg def pos choice value default`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts only the choice values {$2}, but has {$3} given as default values.`
- ***Description:*** The error that in the arguments definition, a positional argument's default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 9.5.90. `Error arg def pos type`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as data type, but only "bool", "char", "float", "file", "int", "str", and "uint" are supported.`
- ***Description:*** The error that in the arguments definition, a positional argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 9.5.91. `Error arg def pos default value bool`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as default value, which must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that in the arguments definition, a positional argument's default value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a default value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.92. `Error arg def pos default value char`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as default value, which must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that in the arguments definition, a positional argument's default value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a default value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.93. `Error arg def pos default value float`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as default value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's default value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a default value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.94. `Error arg def pos default value int`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as default value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's default value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a default value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.95. `Error arg def pos default value uint`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as default value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's default value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a default value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.96. `Error arg def pos choice value bool`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that in the arguments definition, a positional argument's choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.97. `Error arg def pos choice value char`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that in the arguments definition, a positional argument's choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.98. `Error arg def pos choice value float`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.99. `Error arg def pos choice value int`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.100. `Error arg def pos choice value uint`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition, a positional argument's choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.101. `Error arg def pos optionals`

- ***Message:*** `Error: The positional argument with the identifier "$1" is optional, as is "$2", which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least two positional arguments are optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, as another previously parsed argument is. In the general case, it is impossible to parse this, since it cannot be inferred which optional argument is given.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 9.5.102. `Error arg def pos optional variadic`

- ***Message:*** `Error: The positional argument with the identifier "$1" is optional, while "$2" is variadic (it accepts an infinite number of values), which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least one positional argument is optional, with another one being variadic.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while another previously parsed argument is variadic by accepting an infinite number of values. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the variadic argument.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 9.5.103. `Error arg def pos flag`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts 0 arguments and thus can never be given on the command line.`
- ***Description:*** The error that in the arguments definition, a positional argument's number of required arguments is zero.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting no value, just like a flag. However, the presence of a flag is indicated by the presence of the respective keyword argument (option name), which does not exist for positional arguments. Thus, positional flags aren't possible.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.104. `Error arg def pos variadic`

- ***Message:*** `Error: The positional argument with the identifier "$1" is variadic (it accepts an infinite number of values), as is "$2", which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least two positional arguments are variadic.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as variadic by accepting an infinite number of values, just as another previously parsed argument. It is impossible to parse this, since it cannot be inferred which of these arguments would take a given value.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 9.5.105. `Error arg def pos variadic optional 1`

- ***Message:*** `Error: The positional argument with the identifier "$1" is variadic (it accepts an infinite number of values), while being optional, which is not supported.`
- ***Description:*** The error that in the arguments definition, a positional argument is both optional and variadic.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while also being variadic by accepting an infinite number of values. Although parsable in theory, the Argparser does not yet support this behavior (the argument count `*`).
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.106. `Error arg def pos variadic optional 2`

- ***Message:*** `Error: The positional argument with the identifier "$1" is variadic (it accepts an infinite number of values), while "$2" is optional, which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least one positional argument is variadic, with another one being optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as variadic by accepting an infinite number of values, while another previously parsed argument is optional. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the variadic argument.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 9.5.107. `Error arg def pos arg number`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as argument number, which must be an unsigned integer or either of "+", "*", and "?".`
- ***Description:*** The error that in the arguments definition, a positional argument has an unsupported argument number defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with an argument number, that is neither an unsigned integer or one of the special values `+`, `*`, and `?`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.108. `Error arg def pos arg group`

- ***Message:*** `Error: The positional argument with the identifier "$1" is defined for the argument group "$2", while all positional arguments must belong to "$3", as defined by the ARGPARSER_POSITIONAL_ARG_GROUP.`
- ***Description:*** The error that in the arguments definition, a positional argument is defined for the wrong argument group.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined for an argument group other than the [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#9439-argparser_positional_arg_group). For grouping purposes in the help message, all positional arguments must belong to this group.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The argument group.
  - `$3`: The [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#9439-argparser_positional_arg_group).

#### 9.5.109. `Error arg def pos note`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as note, but only "deprecated" and "hidden" are supported.`
- ***Description:*** The error that in the arguments definition, a positional argument has an unsupported note is given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a note other than `"deprecated"` and `"hidden"`. Currently, the Argparser doesn't support any other note, but may do so in the future, so any other value is reserved for future usage.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 9.5.110. `Warning arg def pos help text`

- ***Message:*** `Warning: The positional argument with the identifier "$1" has no help text defined, but for user-friendliness, defining one is recommended.`
- ***Description:*** The warning that in the arguments definition, a positional argument lacks a help text.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined without help text. Specifying one is highly recommended for useful help messages.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.111. `Error arg def option id invalid`

- ***Message:*** `Error: The option with the identifier "$1" does not use a valid Bash identifier.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses an invalid identifier.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined whose identifier does not match the regex for valid Bash identifiers. This argument could not be set to a variable after parsing.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.112. `Error arg def option id help`

- ***Message:*** `Error: The option with the identifier "$1" uses the identifier reserved for the help option, while ARGPARSER_ADD_HELP is activated.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses an identifier reserved for the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined whose identifier (`help`) is the one that the Argparser uses for the automatically added help option. Thus, the Argparser-defined help option would override yours, while you likely intended to provide your own help option. If so, simply deactivate [`ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md#942-argparser_add_help). Otherwise, you would need to rename your `help` option to a different identifier.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.113. `Error arg def option id usage`

- ***Message:*** `Error: The option with the identifier "$1" uses the identifier reserved for the usage option, while ARGPARSER_ADD_HELP is activated.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses an identifier reserved for the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined whose identifier (`usage`) is the one that the Argparser uses for the automatically added usage option. Thus, the Argparser-defined usage option would override yours, while you likely intended to provide your own usage option. If so, simply deactivate [`ARGPARSER_ADD_USAGE`](../environment_variables/environment_variables.md#943-argparser_add_usage). Otherwise, you would need to rename your `usage` option to a different identifier.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.114. `Error arg def option id version`

- ***Message:*** `Error: The option with the identifier "$1" uses the identifier reserved for the version option, while ARGPARSER_ADD_HELP is activated.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses an identifier reserved for the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined whose identifier (`version`) is the one that the Argparser uses for the automatically added version option. Thus, the Argparser-defined version option would override yours, while you likely intended to provide your own version option. If so, simply deactivate [`ARGPARSER_ADD_VERSION`](../environment_variables/environment_variables.md#944-argparser_add_version). Otherwise, you would need to rename your `version` option to a different identifier.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.115. `Error arg def option subcommand`

- ***Message:*** `Error: The option with the identifier "$1" has more than one subcommand defined, which is not supported.`
- ***Description:*** The error that in the arguments definition, a keyword argument has more than one subcommand given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined for at least two subcommands. This is not yet supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.116. `Error arg def option short name empty`

- ***Message:*** `Error: The option with the identifier "$1" has an empty string given as one of the $2 short option names, instead of a legit name.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where at least one short option name is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of short option names.

#### 9.5.117. `Error arg def option short name help`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" defined, which is reserved for invoking the help message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same short option name as the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a short option name is identical to one of those used to invoke the help message. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 9.5.118. `Error arg def option short name usage`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" defined, which is reserved for invoking the usage message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same short option name as the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a short option name is identical to one of those used to invoke the usage message. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 9.5.119. `Error arg def option short name version`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" defined, which is reserved for invoking the version message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same short option name as the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a short option name is identical to one of those used to invoke the version message. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 9.5.120. `Error arg def option short name length`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" defined with more than 1 character length.`
- ***Description:*** The error that in the arguments definition, a keyword argument has a short option name with more than one character length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a short option name is longer than one character. This contradicts the definition of short options, and would interfere with merging short options on the command line. Use a long option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 9.5.121. `Error arg def option short name duplication 1`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" given $3 times.`
- ***Description:*** The error that in the arguments definition, a keyword argument has a short option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a short option name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 9.5.122. `Error arg def option short name duplication 2`

- ***Message:*** `Error: The option with the identifier "$1" has the short option name "-$2" given, but that is already in use by "$3".`
- ***Description:*** The error that in the arguments definition, at least two keyword arguments have the same short option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option name defined, which is already in use by a previously parsed option. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The previously parsed option's identifier.

#### 9.5.123. `Error arg def option long name empty`

- ***Message:*** `Error: The option with the identifier "$1" has an empty string given as one of the $2 long option names, instead of a legit name.`
- ***Description:*** The error that in the arguments definition, a keyword argument uses the empty string (`""`) as long option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where at least one long option name is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of long option names.

#### 9.5.124. `Error arg def option long name help`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" defined, which is reserved for invoking the help message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same long option name as the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a long option name is identical to one of those used to invoke the help message. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 9.5.125. `Error arg def option long name usage`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" defined, which is reserved for invoking the usage message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same long option name as the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a long option name is identical to one of those used to invoke the usage message. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 9.5.126. `Error arg def option long name version`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" defined, which is reserved for invoking the version message.`
- ***Description:*** The error that in the arguments definition, a keyword argument has the same long option name as the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a long option name is identical to one of those used to invoke the version message. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 9.5.127. `Error arg def option long name length`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" defined with less than 2 characters length.`
- ***Description:*** The error that in the arguments definition, a keyword argument has a long option name with less than two characters length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a long option name is shorter than two characters. This contradicts the definition of long options. Use a short option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 9.5.128. `Error arg def option long name duplication 1`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" given $3 times.`
- ***Description:*** The error that in the arguments definition, a keyword argument has a long option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, where a long option name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The number of occurrences of the long option name.

#### 9.5.129. `Error arg def option long name duplication 2`

- ***Message:*** `Error: The option with the identifier "$1" has the long option name "--$2" given, but that is already in use by "$3".`
- ***Description:*** The error that in the arguments definition, at least two keyword arguments have the same long option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option name defined, which is already in use by a previously parsed option. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The previously parsed option's identifier.

#### 9.5.130. `Error arg def option default value flag`

- ***Message:*** `Error: The option with the identifier "$1" must have its default value set to "true" or "false" (as it is allowed to take 0 values), but has {$2} defined.`
- ***Description:*** The error that in the arguments definition, a flag or flag-like keyword argument has a non-Boolean default value.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as accepting no value, *i.e.*, as a flag or flag-like option. Thus, the default value, if given, must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.131. `Error arg def option default value 1`

- ***Message:*** `Error: The option with the identifier "$1" requires 1 value, but has $2 given as default values.`
- ***Description:*** The error that in the arguments definition, a keyword argument's number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 9.5.132. `Error arg def option default value 2`

- ***Message:*** `Error: The option with the identifier "$1" requires $2 values, but has $3 given as default values.`
- ***Description:*** The error that in the arguments definition, a keyword argument's number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 9.5.133. `Error arg def option choice value flag`

- ***Message:*** `Error: The option with the identifier "$1" accepts no choice values, but has {$2} given.`
- ***Description:*** The error that in the arguments definition, a flag has choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as flag, but with choice values. Since they are `true` and `false` by definition, and flags not accepting any value, specifying choice values is redundant or wrong, depending on what they are.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.

#### 9.5.134. `Error arg def option choice value true false`

- ***Message:*** `Error: The option with the identifier "$1" has {$2} given as choice values, while "true" and "false" cannot be any.`
- ***Description:*** The error that in the arguments definition, a keyword argument that can take zero values has choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with choice values including `true` and/or `false`. These are included for flags and flag-like arguments by definition, and disallowed for all other argument counts.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.

#### 9.5.135. `Error arg def option choice value default`

- ***Message:*** `Error: The option with the identifier "$1" accepts only the choice values {$2}, but has {$3} given as default values.`
- ***Description:*** The error that in the arguments definition, a keyword argument's default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 9.5.136. `Error arg def option type`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as data type, but only "bool", "char", "float", "file", "int", "str", and "uint" are supported.`
- ***Description:*** The error that in the arguments definition, a keyword argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 9.5.137. `Error arg def option default value bool`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as default value, which must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that in the arguments definition, a keyword argument's a default value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a default value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.138. `Error arg def option default value char`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as default value, which must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that in the arguments definition, a keyword argument's a default value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a default value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.139. `Error arg def option default value float`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as default value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's a default value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a default value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.140. `Error arg def option default value int`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as default value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's a default value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a default value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.141. `Error arg def option default value uint`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as default value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's a default value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a default value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 9.5.142. `Error arg def option choice value bool`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that in the arguments definition, a keyword argument's choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.143. `Error arg def option choice value char`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that in the arguments definition, a keyword argument's choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.144. `Error arg def option choice value float`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.145. `Error arg def option choice value int`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.146. `Error arg def option choice value uint`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition, a keyword argument's choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 9.5.147. `Error arg def option arg number`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as argument number, which must be an unsigned integer or either of "+", "*", and "?".`
- ***Description:*** The error that in the arguments definition, a keyword argument has an unsupported argument number defined.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with an argument number, that is neither an unsigned integer or one of the special values `+`, `*`, and `?`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.148. `Error arg def option arg group`

- ***Message:*** `Error: The option with the identifier "$1" is defined for the argument group "$2", but must not belong to neither "$3", as defined by the ARGPARSER_SUBCOMMAND_GROUP, nor to "$4", as defined by the ARGPARSER_POSITIONAL_ARG_GROUP, nor to "$5", as defined by the ARGPARSER_HELP_ARG_GROUP.`
- ***Description:*** The error that in the arguments definition, a keyword argument is defined for a wrong argument group.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined for the [`ARGPARSER_SUBCOMMAND_GROUP`](../environment_variables/environment_variables.md#9447-argparser_subcommand_group), the [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#9439-argparser_positional_arg_group), or the [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#9426-argparser_help_arg_group). For grouping purposes in the help message, the keyword arguments must not belong to either of these groups.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The argument group.
  - `$3`: The [`ARGPARSER_SUBCOMMAND_GROUP`](../environment_variables/environment_variables.md#9447-argparser_subcommand_group).
  - `$4`: The [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#9439-argparser_positional_arg_group).
  - `$5`: The [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#9426-argparser_help_arg_group).

#### 9.5.149. `Error arg def option note`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as note, but only "deprecated" and "hidden" are supported.`
- ***Description:*** The error that in the arguments definition, a keyword argument has an unsupported note given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a note other than `"deprecated"` and `"hidden"`. Currently, the Argparser doesn't support any other note, but may do so in the future, so any other value is reserved for future usage.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 9.5.150. `Warning arg def option help text`

- ***Message:*** `Warning: The option with the identifier "$1" has no help text defined, but for user-friendliness, defining one is recommended.`
- ***Description:*** The warning that in the arguments definition, a keyword argument lacks a help text.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined without help text. Specifying one is highly recommended for useful help messages.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 9.5.151. `Error arg double hyphen`

- ***Message:*** `Error: The special option "--" takes no value.`
- ***Description:*** The error that on the command line, the option `--` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a double hyphen with an equals sign (`=`), possibly followed by a value. Since `--` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 9.5.152. `Error arg double plus`

- ***Message:*** `Error: The special option "++" takes no value.`
- ***Description:*** The error that on the command line, the option `++` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a doubled plus sign with an equals sign (`=`), possibly followed by a value. Since `++` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 9.5.153. `Error arg inversion`

- ***Message:*** `Error: Inverting flags with a "+" prefix is deactivated.`
- ***Description:*** The error that on the command line, a keyword argument starts with a `+` or `++`, when flag inversion is deactivated.
- ***Reasons for error:*** When parsing the command line, the Argparser found a keyword argument that starts with a plus sign, meaning the intention to invert the flag, but [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#946-argparser_allow_flag_inversion) is set to `false`. This removes the ability to use the `+` prefix.

#### 9.5.154. `Error arg unknown`

- ***Message:*** `Error: The argument "$1" is unknown.`
- ***Description:*** The error that on the command line, an undefined argument is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument that has not been defined in the arguments definition, thus failing to parse it.
- ***Interpolated variables:***
  - `$1`: The unknown argument.

#### 9.5.155. `Error long option match`

- ***Message:*** `Error: The long option "$1" matches multiple long options.`
- ***Description:*** The error that on the command line, an abbreviated long option matches multiple option names.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](../environment_variables/environment_variables.md#948-argparser_allow_option_abbreviation) is set to `true`, the Argparser found a long option being abbreviated, but matching more than one defined long option in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The ambiguous long option.

#### 9.5.156. `Error long option negation`

- ***Message:*** `Error: The long option "$1" is negated, but its affirmative version "$2" is unknown.`
- ***Description:*** The error that on the command line, an undefined negated long option is given.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#947-argparser_allow_flag_negation) is set to `true`, the Argparser found a long option starting with one of the [`ARGPARSER_FLAG_NEGATION_PREFIXES`](../environment_variables/environment_variables.md#9425-argparser_flag_negation_prefixes), but the remaining (affirmative) version has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The negated long option.
  - `$2`: The affirmative long option.

#### 9.5.157. `Error long option unknown`

- ***Message:*** `Error: The long option "$1" is unknown.`
- ***Description:*** The error that on the command line, an unknown long option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a long option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown long option.

#### 9.5.158. `Error short option merge`

- ***Message:*** `Error: The short option "$1$2" is unknown.`
- ***Description:*** The error that on the command line, an unknown short option is given in merged form.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_MERGING`](../environment_variables/environment_variables.md#949-argparser_allow_option_merging) is set to `true`, the Argparser found a short option, merged with others, that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The merged short options' common prefix.
  - `$2`: The unknown short option.

#### 9.5.159. `Error short option unknown`

- ***Message:*** `Error: The short option "$1" is unknown.`
- ***Description:*** The error that on the command line, an unknown short option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a short option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown short option.

#### 9.5.160. `Error pos arg count 1`

- ***Message:*** `Error: 1 positional argument is required, but $1 are given.`
- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments, which is one.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less than one positional argument being given, while one is required.
- ***Interpolated variables:***
  - `$1`: The number of given positional arguments.

#### 9.5.161. `Error pos arg count 2`

- ***Message:*** `Error: $1 positional arguments are required, but 1 is given.`
- ***Description:*** The error that on the command line, the number of given positional arguments, which is one, doesn't match the number of required positional arguments.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less positional arguments being given than required.
- ***Interpolated variables:***
  - `$1`: The number of required positional arguments.

#### 9.5.162. `Error pos arg count 3`

- ***Message:*** `Error: $1 positional arguments are required, but $2 are given.`
- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less positional arguments being given than required.
- ***Interpolated variables:***
  - `$1`: The number of required positional arguments.
  - `$2`: The number of given positional arguments.

#### 9.5.163. `Error arg subcommand 1`

- ***Message:*** `Error: The argument "$1" is known, but defined for the subcommand "$2", which is not given.`
- ***Description:*** The error that on the command line, an argument is given that belongs to a subcommand.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument that is defined, but belongs to a subcommand, while none is given.
- ***Interpolated variables:***
  - `$1`: The argument.
  - `$2`: The subcommand.

#### 9.5.164. `Error arg subcommand 2`

- ***Message:*** `Error: The argument "$1" is known, but not defined for the given subcommand "$2".`
- ***Description:*** The error that on the command line, an argument is given that belongs to a different subcommand.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument that is defined, but belongs to a subcommand other than the given one, or to the main program.
- ***Interpolated variables:***
  - `$1`: The argument.
  - `$2`: The subcommand.

#### 9.5.165. `Warning deprecation`

- ***Message:*** `Warning: The argument "$1" is deprecated and will be removed in the future.`
- ***Description:*** The warning that on the command line, a deprecated argument is given.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument which is defined as deprecated. Thus, it warns your script's user to adapt the workflow.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.

#### 9.5.166. `Error arg no flag 1`

- ***Message:*** `Error: The option "$1" is no flag and thus needs a value after the option name.`
- ***Description:*** The error that on the command line, a non-flag is given without a value.
- ***Reasons for error:*** When parsing the command line, the Argparser found a keyword argument given multiple times and at least once without a value, without being defined as flag in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.

#### 9.5.167. `Error arg no flag 2`

- ***Message:*** `Error: The option "$1" is not used as a flag (it has a value given) and thus cannot be given with a "+" or "{$2}-" prefix.`
- ***Description:*** The error that on the command line, a flag-like argument with value is inverted or negated.
- ***Reasons for error:*** When parsing the command line and either [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#946-argparser_allow_flag_inversion) or [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#947-argparser_allow_flag_negation) is set to `true`, the Argparser found a keyword argument, defined as usable as a flag (*i.e.*, having an arguments count of `"*"` or `"?"`) and given with a `+` prefix or one of the [`ARGPARSER_FLAG_NEGATION_PREFIXES`](../environment_variables/environment_variables.md#9425-argparser_flag_negation_prefixes), but which is followed by a value, *i.e.*, not used as a flag.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.

#### 9.5.168. `Error arg no flag 3`

- ***Message:*** `Error: The option "$1" is no flag and thus cannot be given with a "+" or "{$2}-" prefix.`
- ***Description:*** The error that on the command line, a non-flag is inverted or negated.
- ***Reasons for error:*** When parsing the command line and either [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#946-argparser_allow_flag_inversion) or [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#947-argparser_allow_flag_negation) is set to `true`, the Argparser found a keyword argument given with a `+` prefix or one of the [`ARGPARSER_FLAG_NEGATION_PREFIXES`](../environment_variables/environment_variables.md#9425-argparser_flag_negation_prefixes), but which has not been defined as flag in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.

#### 9.5.169. `Error mandatory arg`

- ***Message:*** `Error: The argument "$1" is mandatory, but not given.`
- ***Description:*** The error that on the command line, a mandatory argument is not given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument defined to be required, but not given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.

#### 9.5.170. `Error wrong arg number 1`

- ***Message:*** `Error: The argument "$1" requires at least 1 value, but has $2 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given, while requiring at least one.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is at least one.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.

#### 9.5.171. `Warning wrong arg number 1`

- ***Message:*** `Warning: The argument "$1" requires at least 1 value, but has $2 given.  For convenience, the default ($3) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given, while requiring at least one.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is at least one. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.
  - `$3`: The default values.

#### 9.5.172. `Error wrong arg number 2`

- ***Message:*** `Error: The argument "$1" requires 0 or 1 value, but has $2 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given, while requiring zero or one.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is zero or one.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.

#### 9.5.173. `Warning wrong arg number 2`

- ***Message:*** `Warning: The argument "$1" requires at 0 or 1 value, but has $2 given.  For convenience, the default ($3) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given, while requiring zero or one.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is zero or one. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.
  - `$3`: The default values.

#### 9.5.174. `Error wrong arg number 3`

- ***Message:*** `Error: The argument "$1" requires 1 value, but has $2 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given, while requiring one.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is one.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.

#### 9.5.175. `Warning wrong arg number 3`

- ***Message:*** `Warning: The argument "$1" requires 1 value, but has $2 given.  For convenience, the default ($3) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given, while requiring one.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is one. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of given values.
  - `$3`: The default values.

#### 9.5.176. `Error wrong arg number 4`

- ***Message:*** `Error: The argument "$1" requires $2 values, but has $3 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of required values.
  - `$3`: The number of given values.

#### 9.5.177. `Warning wrong arg number 4`

- ***Message:*** `Warning: The argument "$1" requires $2 values, but has $3 given.  For convenience, the default ($4) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The number of required values.
  - `$3`: The number of given values.
  - `$4`: The default values.

#### 9.5.178. `Error arg choice`

- ***Message:*** `Error: The argument "$1" must be in {$2}, but is {$3}.`
- ***Description:*** The error that a given arguments' values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose given values aren't completely included in the choice values.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The choice values.
  - `$3`: The given values.

#### 9.5.179. `Error arg bool`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a Boolean, i.e., "true" or "false".`
- ***Description:*** The error that a given argument's value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The given value.

#### 9.5.180. `Error arg char`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a character, i.e., a string comprising one printable symbol.`
- ***Description:*** The error that a given argument's value's data type is not a character.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable symbol.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The given value.

#### 9.5.181. `Error arg float`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that a given argument's value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The given value.

#### 9.5.182. `Error arg int`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that a given argument's value's data type is not an integer.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The given value.

#### 9.5.183. `Error arg uint`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that a given argument's value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument's display (option or value) names.
  - `$2`: The given value.

[&#129092;&nbsp;Table of contents (Translations)](toc.md)
