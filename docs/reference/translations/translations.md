#### 8.5.1. `Positional arguments`

- ***Message:*** `Positional arguments`
- ***Description:*** The name of the positional arguments' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#8433-argparser_positional_arg_group).

#### 8.5.2. `Help options`

- ***Message:*** `Help options`
- ***Description:*** The name of the help options' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#8420-argparser_help_arg_group).

#### 8.5.3. `Help description`

- ***Message:*** `""`
- ***Description:*** The script's description, indicating its purpose in the help message, *i.e.*, the translated [`ARGPARSER_HELP_DESCRIPTION`](../environment_variables/environment_variables.md#8421-argparser_help_description). The value is empty by default, and hence also the translations.

#### 8.5.4. `Error`

- ***Message:*** `Error`
- ***Description:*** The word `"Error"` in error messages.

#### 8.5.5. `Warning`

- ***Message:*** `Warning`
- ***Description:*** The word `"Warning"` in warning messages.

#### 8.5.6. `Usage`

- ***Message:*** `Usage`
- ***Description:*** The word `"Usage"` in help and usage messages.

#### 8.5.7. `Arguments`

- ***Message:*** `ARGUMENTS`
- ***Description:*** The word `"ARGUMENTS"` in help messages, to show the existence of mandatory options (those without a default value).

#### 8.5.8. `Options`

- ***Message:*** `OPTIONS`
- ***Description:*** The word `"OPTIONS"` in help messages, to show the existence of optional options (those with a default value).

#### 8.5.9. `Mandatory arguments`

- ***Message:*** `Mandatory arguments to long options are mandatory for short options too.`
- ***Description:*** The remark that mandatory arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#836-remark-directive) include directive.

#### 8.5.10. `Deprecated`

- ***Message:*** `DEPRECATED`
- ***Description:*** The word `"DEPRECATED"` in help messages, to show that an argument is deprecated and shouldn't be used, anymore.

#### 8.5.11. `Default`

- ***Message:*** `default`
- ***Description:*** The word `"default"` in help messages, to introduce the default values.

#### 8.5.12. `--help`

- ***Message:*** `display this help and exit`
- ***Description:*** the help text for the help options, *i.e.*, the [`ARGPARSER_HELP_OPTIONS`](../environment_variables/environment_variables.md#8426-argparser_help_options) and `--help`, if [`ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md#842-argparser_add_help) is set to `true`.

#### 8.5.13. `--usage`

- ***Message:*** `display the usage and exit`
- ***Description:*** the help text for the usage options, *i.e.*, the [`ARGPARSER_USAGE_OPTIONS`](../environment_variables/environment_variables.md#8450-argparser_usage_options) and `--usage`, if [`ARGPARSER_ADD_USAGE`](../environment_variables/environment_variables.md#843-argparser_add_usage) is set to `true`.

#### 8.5.14. `--version`

- ***Message:*** `display the version and exit`
- ***Description:*** the help text for the version options, *i.e.*, the [`ARGPARSER_VERSION_OPTIONS`](../environment_variables/environment_variables.md#8457-argparser_version_options) and `--version`, if [`ARGPARSER_ADD_VERSION`](../environment_variables/environment_variables.md#844-argparser_add_version) is set to `true`.

#### 8.5.15. `false`

- ***Message:*** `false`
- ***Description:*** The default value of `false` in help messages.

#### 8.5.16. `true`

- ***Message:*** `true`
- ***Description:*** The default value of `true` in help messages.

#### 8.5.17. `Error env var bool`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be a Boolean, i.e., true or false.`
- ***Description:*** The error that an environment variable is not a Boolean.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.18. `Error env var char`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be a character, i.e., a string comprising one printable ASCII character.`
- ***Description:*** The error that an environment variable is not a character.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.19. `Error env var identifier`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but designed to be used as Bash variable identifier, i.e., its value must start with a letter or underscore and contain only letters, digits, and underscores.`
- ***Description:*** The error that an environment variable is not usable as a Bash variable identifier.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not matched by the regular expression `[[:alpha:]_]*([[:word:]])` in Bash's extglob syntax.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.20. `Error env var int`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that an environment variable is not an integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.21. `Error env var uint`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that an environment variable is not an unsigned integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.22. `Error env var file 0001`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is empty.`
- ***Description:*** The error that an environment variable refers to an empty file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.23. `Error env var file 0010`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not readable.`
- ***Description:*** The error that an environment variable refers to a file which is not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.24. `Error env var file 0011`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not readable and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.25. `Error env var file 0100`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file.`
- ***Description:*** The error that an environment variable refers to a file which is not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.26. `Error env var file 0101`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.27. `Error env var file 0110`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file and not readable.`
- ***Description:*** The error that an environment variable refers to a file which is not a regular file and also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.28. `Error env var file 0111`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file is not a regular file, not readable, and empty.`
- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file and not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.29. `Error env var file 1111`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the referenced file does not exist.`
- ***Description:*** The error that an environment variable refers to a nonexistent file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.30. `Error env var delimiters reserved`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but hyphens, plus signs, asterisks, and question marks are reserved characters.`
- ***Description:*** The error that an environment variable uses a reserved character as arguments definition delimiter.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#8411-argparser_arg_delimiter_1) or [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#8412-argparser_arg_delimiter_2), provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value used as argument delimiter, but the respective character is reserved. Hyphens may be used to indicate `STDIN`, while plus signs are used to denote arguments accepting an infinite number of arguments (at least one). Asterisks and question marks are reserved for the same reason, as they will be used to indicate other argument counts in a later Argparser version. Additionally, hyphens and plus signs are used as option prefixes on the command line (not in the arguments definition), so may be confused with prefixes when given in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.31. `Error env var styles`

- ***Message:*** `Error: The environment variable "$1" is set to "$2", but the values must lie in {black, red, green, yellow, blue, magenta, cyan, white} for colors and in {normal, bold, faint, italic, underline, double, overline, crossed-out, blink, reverse} for styles.`
- ***Description:*** The error that an environment variable refers to an undefined [color or style](../colors_and_styles.md#82-colors-and-styles).
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to set a message color or style which does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.5.32. `Error env var option type`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" must be either set to "long" or "short", but is "$1".`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#8448-argparser_usage_message_option_type) is not set to `long` or `short`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `long` and `short`. Since there are only short and long option names possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 8.5.33. `Error env var orientation`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_ORIENTATION" must be either set to "row" or "column", but is "$1".`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../environment_variables/environment_variables.md#8449-argparser_usage_message_orientation) is not set to `row` or `column`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_ORIENTATION`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `row` and `column`. Since only a row-like or column-like structure is possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 8.5.34. `Error env var delimiters identical`

- ***Message:*** `Error: The environment variables "ARGPARSER_ARG_DELIMITER_1" and "ARGPARSER_ARG_DELIMITER_2" must have different values, but are both "$1".`
- ***Description:*** The error that the environment variables [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#8411-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#8412-argparser_arg_delimiter_2) have an identical value.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variables `ARGPARSER_ARG_DELIMITER_1` and `ARGPARSER_ARG_DELIMITER_2`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, have the same value. This renders parsing of the arguments definition impossible, as multi-value fields cannot be told apart from column delimiters.
- ***Interpolated variables:***
  - `$1`: The environment variables' common value.

#### 8.5.35. `Error env var short name empty`

- ***Message:*** `Error: The environment variable "$1" has an empty string given as one of the $2 short option names, instead of a legit name.`
- ***Description:*** The error that an environment variable uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The number of short option names.

#### 8.5.36. `Error env var short name length`

- ***Message:*** `Error: The environment variable "$1" has the short option "-$2" defined with more than 1 character length.`
- ***Description:*** The error that an environment variable has a short option name with more than one character length given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where a name is longer than one character. This contradicts the definition of short options, and would interfere with merging short options on the command line.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option name.

#### 8.5.37. `Error env var short name duplication 1`

- ***Message:*** `Error: The environment variable "$1" has the short option "-$2" given $3 times.`
- ***Description:*** The error that an environment variable has a short option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 8.5.38. `Error env var short name duplication 2`

- ***Message:*** `Error: The environment variable "$1" has the short option "-$2" given, but that is already in use by "$3".`
- ***Description:*** The error that at least two environment variables have the same short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, which is already in use by a previously parsed environment variable. When given on the command line, it would be unclear which environment variable would be referred to.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The short option name.
  - `$3`: The previous environment variable's name.

#### 8.5.39. `Error env var short options`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" requests the usage of short option names, but "ARGPARSER_USE_SHORT_OPTIONS" turns them off.`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#8532-error-env-var-option-type) requests short option names, while [`ARGPARSER_USE_SHORT_OPTIONS`](../environment_variables/environment_variables.md#8453-argparser_use_short_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `short`, while `ARGPARSER_USE_SHORT_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no short option name is available.

#### 8.5.40. `Error env var long options`

- ***Message:*** `Error: The environment variable "ARGPARSER_USAGE_MESSAGE_OPTION_TYPE" requests the usage of long option names, but "ARGPARSER_USE_LONG_OPTIONS" turns them off.`
- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#8532-error-env-var-option-type) requests long option names, while [`ARGPARSER_USE_LONG_OPTIONS`](../environment_variables/environment_variables.md#8452-argparser_use_long_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `long`, while `ARGPARSER_USE_LONG_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no long option name is available.

#### 8.5.41. `Error env var files`

- ***Message:*** `Error: The environment variables "$1" and "$2" point to the same file.`
- ***Description:*** The error that two environment variables refer to the same file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8415-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8416-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value pointing to the same file as an earlier parsed environment variable. Since the files referred to by these environment variables have different meanings (like the Argparser configuration and translation), it is impossible that both information is given in the same file.
- ***Interpolated variables:***
  - `$1`: The first environment variable's name.
  - `$2`: The second environment variable's name.

#### 8.5.42. `Error arg array 1`

- ***Message:*** `Error: Calling (instead of sourcing) the Argparser requires the arguments definition to be provided through STDIN, separated by newlines.  Either pipe to the Argparser or use process substitution to give input.  Alternatively, try "$1 --help" to get a help message with further information.`
- ***Description:*** The error that no arguments definition has been provided upon calling the Argparser.
- ***Reasons for error:*** When calling (and not sourcing) the Argparser, the arguments definition must be provided through `STDIN`, either by piping or by process substitution. However, `STDIN` (file descriptor `0`) has been deemed empty.
- ***Interpolated variables:***
  - `$1`: The path to the Argparser, as [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8435-argparser_script_name).

#### 8.5.43. `Error arg array 2`

- ***Message:*** `Error: The variable ARGPARSER_ARG_ARRAY_NAME refers to "$1", but this variable is not defined.  Either you have given your arguments array another name (maybe "$2" -- then change ARGPARSER_ARG_ARRAY_NAME accordingly) or you forgot defining the array at all (then define it).`
- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#849-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"` and reports the first match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.
  - `$2`: The guesstimated actual name of the variable.

#### 8.5.44. `Error arg array 3`

- ***Message:*** `Error: The variable ARGPARSER_ARG_ARRAY_NAME refers to "$1", but this variable is not defined.  Either you have given your arguments array another name (then change ARGPARSER_ARG_ARRAY_NAME accordingly) or you forgot defining the array at all (then define it).`
- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#849-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"`, but didn't find any match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.

#### 8.5.45. `Error no arg def`

- ***Message:*** `Error: No argument definition for "$1".`
- ***Description:*** The error that an argument is lacking a definition.
- ***Reasons for error:*** When reading the arguments definition, the Argparser found a definition line giving only an argument name, but no definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8410-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 8.5.46. `Error arg def id`

- ***Message:*** `Error: In the arguments definition in "$1", the column "id" is missing.`
- ***Description:*** The error that the arguments definition in the script lacks the `id` column.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8435-argparser_script_name) with the problematic definition.

#### 8.5.47. `Error arg def file id`

- ***Message:*** `Error: In the arguments definition file "$1", the column "id" is missing.`
- ***Description:*** The error that the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8410-argparser_arg_def_file) lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8410-argparser_arg_def_file) with the problematic definition.

#### 8.5.48. `Error arg def field count`

- ***Message:*** `Error: In the arguments definition in "$1", the field count of the line "$2" ($3) doesn't match the header's field count ($4).`
- ***Description:*** The error that in the arguments definition in the script, the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8435-argparser_script_name) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 8.5.49. `Error arg def file field count`

- ***Message:*** `Error: In the arguments definition file "$1", the field count of the line "$2" ($3) doesn't match the header's field count ($4).`
- ***Description:*** The error that in the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8410-argparser_arg_def_file), the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8410-argparser_arg_def_file) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 8.5.50. `Error arg def choice range hyphens`

- ***Message:*** `Error: The argument with the identifier "$1" has more hyphens in the choice values given than supported (2).`
- ***Description:*** The error that in the arguments definition, an argument uses more than two hyphens in a choice value range.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a set of choice values defined, where at least one uses more than two hyphens to indicate a range. Zero hyphens means the literal value, one hyphen the range with step size `1`, and two hyphens the range with the given step size. Three hyphens or more aren't meaningful and hence not supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.51. `Error arg def choice range`

- ***Message:*** `Error: The argument with the identifier "$1" has choice values given with "$2" as start, "$3" as stop, and "$4" as step size, while only integer, float, or letter sequences are supported.`
- ***Description:*** The error that in the arguments definition, an argument uses non-integer, non-float, or non-letter characters in a choice value range.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a set of choice values defined, where at least one uses non-integer, non-float, or non-letter characters to indicate a range. Both the start and stop value may be either integers, floats, or alphabetical characters (letters), the step size may be an integer or float. It must be an integer for letter sequences. Any other character is not supported.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The start value.
  - `$3`: The stop value.
  - `$4`: The step size.

#### 8.5.52. `Error arg def short name empty`

- ***Message:*** `Error: The short option with the identifier "$1" has an empty string given as one of the $2 short option names, instead of a legit name.`
- ***Description:*** The error that in the arguments definition, an argument uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of short option names.

#### 8.5.53. `Error arg def short name help`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" defined, which is reserved for invoking the help message.`
- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the help message. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.5.54. `Error arg def short name usage`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" defined, which is reserved for invoking the usage message.`
- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the usage message. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.5.55. `Error arg def short name version`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" defined, which is reserved for invoking the version message.`
- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the version message. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.5.56. `Error arg def short name length`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" defined with more than 1 character length.`
- ***Description:*** The error that in the arguments definition, an argument has a short option name with more than one character length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is longer than one character. This contradicts the definition of short options, and would interfere with merging short options on the command line. Use a long option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.5.57. `Error arg def short name duplication 1`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" given $3 times.`
- ***Description:*** The error that in the arguments definition, an argument has a short option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 8.5.58. `Error arg def short name duplication 2`

- ***Message:*** `Error: The short option with the identifier "$1" has the short option "-$2" given, but that is already in use by "$3".`
- ***Description:*** The error that in the arguments definition, at least two arguments have the same short option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, which is already in use by a previously parsed argument. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The previously parsed argument's identifier.

#### 8.5.59. `Error arg def long name empty`

- ***Message:*** `Error: The long option with the identifier "$1" has an empty string given as one of the $2 long option names, instead of a legit name.`
- ***Description:*** The error that in the arguments definition, an argument uses the empty string (`""`) as long option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of long option names.

#### 8.5.60. `Error arg def long name help`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--help" defined, which is reserved for invoking the help message.`
- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the help option, `--help`.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to the one used to invoke the help message, *i.e.*, `--help`. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.61. `Error arg def long name usage`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--usage" defined, which is reserved for invoking the usage message.`
- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the usage option, `--usage`.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to the one used to invoke the usage message, *i.e.*, `--usage`. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.62. `Error arg def long name version`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--version" defined, which is reserved for invoking the version message.`
- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the version option, `--version`.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to the one used to invoke the version message, *i.e.*, `--version`. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.63. `Error arg def long name length`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--$2" defined with less than 2 characters length.`
- ***Description:*** The error that in the arguments definition, an argument has a long option name with less than two characters length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is shorter than two characters. This contradicts the definition of long options. Use a short option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 8.5.64. `Error arg def long name duplication 1`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--$2" given $3 times.`
- ***Description:*** The error that in the arguments definition, an argument has a long option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The number of occurrences of the long option name.

#### 8.5.65. `Error arg def long name duplication 2`

- ***Message:*** `Error: The long option with the identifier "$1" has the long option "--$2" given, but that is already in use by "$3".`
- ***Description:*** The error that in the arguments definition, at least two arguments have the same long option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, which is already in use by a previously parsed argument. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The previously parsed argument's identifier.

#### 8.5.66. `Error arg def pos default 1`

- ***Message:*** `Error: The positional argument with the identifier "$1" requires 1 value, but has $2 given as default.`
- ***Description:*** The error that in the arguments definition of a positional argument, the number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 8.5.67. `Error arg def pos default 2`

- ***Message:*** `Error: The positional argument with the identifier "$1" requires $2 values, but has $3 given as default.`
- ***Description:*** The error that in the arguments definition of a positional argument, the number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 8.5.68. `Error arg def pos choice`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts only the choice values {$2}, but has {$3} given as default.`
- ***Description:*** The error that in the arguments definition of a positional argument, the default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 8.5.69. `Error arg def pos optionals`

- ***Message:*** `Error: The positional argument with the identifier "$1" is optional, as is "$2", which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least two positional arguments are optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, as another previously parsed argument is. In the general case, it is impossible to parse this, since it cannot be inferred which optional argument is given.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.5.70. `Error arg def pos optional infinite`

- ***Message:*** `Error: The positional argument with the identifier "$1" is optional, while "$2" accepts an infinite number of values, which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least one positional argument is optional, with another one accepting an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while another previously parsed argument accepts an infinite number of values. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the argument accepting an infinite number of values.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.5.71. `Error arg def pos flag`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts 0 arguments and thus can never be given on the command line.`
- ***Description:*** The error that in the arguments definition of a positional argument, the number of required arguments is zero.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting no value, just as a flag. However, the presence of a flag is indicated by the presence of the respective keyword argument (option name), which does not exist for positional arguments. Thus, positional flags aren't possible.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.72. `Error arg def pos infinites`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts an infinite number of values, as does "$2", which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least two positional arguments accept an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting an infinite number of values, just as another previously parsed argument does. It is impossible to parse this, since it cannot be inferred which of these arguments would take a given value.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.5.73. `Error arg def pos infinite optional 1`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts an infinite number of values, while being optional, which is not supported.`
- ***Description:*** The error that in the arguments definition, a positional argument is both optional and accepts an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while accepting an infinite number of values. Although parsable in theory, the Argparser does not yet support this behavior (the argument count `*`).
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.5.74. `Error arg def pos infinite optional 2`

- ***Message:*** `Error: The positional argument with the identifier "$1" accepts an infinite number of values, while "$2" is optional, which renders parsing impossible.`
- ***Description:*** The error that in the arguments definition, at least one positional argument accepts an infinite number of values, with another one being optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting an infinite number of values, while another previously parsed argument is optional. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the argument accepting an infinite number of values.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.5.75. `Error arg def pos type`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as data type, but only "bool", "char", "float", "file", "int", "str", and "uint" are supported.`
- ***Description:*** The error that in the arguments definition, a positional argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 8.5.76. `Error arg def pos bool`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a Boolean, i.e., true or false.`
- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.77. `Error arg def pos char`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a character, i.e., a string comprising one printable ASCII character.`
- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.78. `Error arg def pos float`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.79. `Error arg def pos int`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.80. `Error arg def pos uint`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as choice value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.81. `Error arg def pos note`

- ***Message:*** `Error: The positional argument with the identifier "$1" has "$2" given as note, but only "deprecated" is supported.`
- ***Description:*** The error that in the arguments definition of a positional argument, an unsupported note is given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a note other than `"deprecated"`. Currently, the Argparser doesn't support any other note, but may do so in the future.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 8.5.82. `Error arg def option flag`

- ***Message:*** `Error: The option with the identifier "$1" must be true or false, but has {$2} given as default.`
- ***Description:*** The error that in the arguments definition, a flag has a non-Boolean default value.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as accepting no value, *i.e.*, as a flag. Thus, the default value must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 8.5.83. `Error arg def option default 1`

- ***Message:*** `Error: The option with the identifier "$1" requires 1 value, but has $2 given as default.`
- ***Description:*** The error that in the arguments definition of a keyword argument, the number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 8.5.84. `Error arg def option default 2`

- ***Message:*** `Error: The option with the identifier "$1" requires $2 values, but has $3 given as default.`
- ***Description:*** The error that in the arguments definition of a keyword argument, the number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 8.5.85. `Error arg def option choice flag`

- ***Message:*** `Error: The option with the identifier "$1" accepts no choice values, but has {$2} given.`
- ***Description:*** The error that in the arguments definition, a flag has choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as flag, but with choice values. Since they are `true` and `false` by definition, and flags not accepting any value, specifying choice values is either redundant or wrong, depending on the point of view.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.

#### 8.5.86. `Error arg def option choice`

- ***Message:*** `Error: The option with the identifier "$1" accepts only the choice values {$2}, but has {$3} given as default.`
- ***Description:*** The error that in the arguments definition of a keyword argument, the default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 8.5.87. `Error arg def option type`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as data type, but only "bool", "char", "float", "file", "int", "str", and "uint" are supported.`
- ***Description:*** The error that in the arguments definition, a keyword argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 8.5.88. `Error arg def option bool`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a Boolean, i.e., true or false.`
- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.89. `Error arg def option char`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a character, i.e., a string comprising one printable ASCII character.`
- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.90. `Error arg def option float`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.91. `Error arg def option int`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.92. `Error arg def option uint`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as choice value, which must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.5.93. `Error arg def option note`

- ***Message:*** `Error: The option with the identifier "$1" has "$2" given as note, but only "deprecated" is supported.`
- ***Description:*** The error that in the arguments definition of a keyword argument, an unsupported note is given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a note other than `"deprecated"`. Currently, the Argparser doesn't support any other note, but may do so in the future.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 8.5.94. `Error arg double hyphen`

- ***Message:*** `Error: The special option "--" takes no value.`
- ***Description:*** The error that on the command line, the option `--` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a double hyphen with an equals sign (`=`), possibly followed by a value. Since `--` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 8.5.95. `Error arg double plus`

- ***Message:*** `Error: The special option "++" takes no value.`
- ***Description:*** The error that on the command line, the option `++` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a doubled plus sign with an equals sign (`=`), possibly followed by a value. Since `++` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 8.5.96. `Error arg inversion`

- ***Message:*** `Error: Inverting flags with a "+" prefix is deactivated.`
- ***Description:*** The error that on the command line, an option starts with a `+` or `++`, when flag inversion is deactivated.
- ***Reasons for error:*** When parsing the command line, the Argparser found an option that starts with a plus sign, meaning the intention to invert the flag, but [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#845-argparser_allow_flag_inversion) is set to `false`. This removes the ability to use the `+` prefix.

#### 8.5.97. `Error arg unknown`

- ***Message:*** `Error: The argument "$1" is unknown.`
- ***Description:*** The error that on the command line, an undefined argument is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument that has not been defined in the arguments definition, thus failing to parse it.
- ***Interpolated variables:***
  - `$1`: The unknown argument.

#### 8.5.98. `Error long option match`

- ***Message:*** `Error: The long option "$1" matches multiple long options.`
- ***Description:*** The error that on the command line, an abbreviated long option matches multiple option names.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](../environment_variables/environment_variables.md#847-argparser_allow_option_abbreviation) is set to `true`, the Argparser found a long option being abbreviated, but matching more than one defined long option in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The ambiguous long option.

#### 8.5.99. `Error long option negation`

- ***Message:*** `Error: The long option "$1" is negated, but its affirmative version "$2" is unknown.`
- ***Description:*** The error that on the command line, an undefined negated long option is given.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#846-argparser_allow_flag_negation) is set to `true`, the Argparser found a long option starting with `--no-`, but the remaining (affirmative) version has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The negated long option.
  - `$2`: The affirmative long option.

#### 8.5.100. `Error long option unknown`

- ***Message:*** `Error: The long option "$1" is unknown.`
- ***Description:*** The error that on the command line, an unknown long option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a long option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown long option.

#### 8.5.101. `Error short option merge`

- ***Message:*** `Error: The short option "$1$2" is unknown.`
- ***Description:*** The error that on the command line, an unknown short option is given in merged form.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_MERGING`](../environment_variables/environment_variables.md#848-argparser_allow_option_merging) is set to `true`, the Argparser found a short option, merged with others, that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The merged short options' common prefix.
  - `$2`: The unknown short option.

#### 8.5.102. `Error short option unknown`

- ***Message:*** `Error: The short option "$1" is unknown.`
- ***Description:*** The error that on the command line, an unknown short option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a short option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown short option.

#### 8.5.103. `Error pos arg count 1`

- ***Message:*** `Error: 1 positional argument is required, but $1 are given.`
- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments, which is one.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less than one positional argument being given, while one is required.
- ***Interpolated variables:***
  - `$1`: The number of given positional arguments.

#### 8.5.104. `Error pos arg count 2`

- ***Message:*** `Error: $1 positional arguments are required, but $2 are given.`
- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less positional arguments being given than required.
- ***Interpolated variables:***
  - `$1`: The number of required positional arguments.
  - `$2`: The number of given positional arguments.

#### 8.5.105. `Error arg no flag`

- ***Message:*** `Error: The option "$1" is no flag and thus cannot be given with a "+" or "no-" prefix.`
- ***Description:*** The error that on the command line, a non-flag is inverted or negated.
- ***Reasons for error:*** When parsing the command line and either [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#845-argparser_allow_flag_inversion) or [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#846-argparser_allow_flag_negation) is set to `true`, the Argparser found an option given with a `+` or `no-` prefix, but which has not been defined as flag in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.

#### 8.5.106. `Error mandatory arg`

- ***Message:*** `Error: The argument "$1" is mandatory, but not given.`
- ***Description:*** The error that on the command line, a mandatory argument is not given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument defined to be required, but not given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.

#### 8.5.107. `Error wrong arg number 1`

- ***Message:*** `Error: The argument "$1" requires 1 value, but has $2 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given, while requiring one.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is one.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of given values.

#### 8.5.108. `Error wrong arg number 2`

- ***Message:*** `Error: The argument "$1" requires at least 1 value, but has $2 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given, while requiring at least one.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is at least one.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of given values.

#### 8.5.109. `Error wrong arg number 3`

- ***Message:*** `Error: The argument "$1" requires $2 values, but has $3 given.`
- ***Description:*** The error that on the command line, an argument has a wrong number of values given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of required values.
  - `$3`: The number of given values.

#### 8.5.110. `Error arg choice`

- ***Message:*** `Error: The argument "$1" must be in {$2}, but is {$3}.`
- ***Description:*** The error that a given arguments' values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument whose given values aren't completely included in the choice values.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The choice values.
  - `$3`: The given values.

#### 8.5.111. `Error arg bool`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a Boolean, i.e., true or false.`
- ***Description:*** The error that a given argument's value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The given value.

#### 8.5.112. `Error arg char`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a character, i.e., a string comprising one printable ASCII character.`
- ***Description:*** The error that a given argument's value's data type is not a character.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The given value.

#### 8.5.113. `Error arg float`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be a floating-point number, i.e., comprise only digits, a dot, and possibly a leading sign.`
- ***Description:*** The error that a given argument's value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The given value.

#### 8.5.114. `Error arg int`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be an integer, i.e., comprise only digits and possibly a leading sign.`
- ***Description:*** The error that a given argument's value's data type is not an integer.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The given value.

#### 8.5.115. `Error arg uint`

- ***Message:*** `Error: The argument "$1" is set to "$2", but must be an unsigned integer, i.e., comprise only digits and no sign.`
- ***Description:*** The error that a given argument's value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the command line, the Argparser found a given value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The given value.

#### 8.5.116. `Error YAML`

- ***Message:*** `Error: The YAML line "$1" could not be recognized.`
- ***Description:*** The error that a translation file's [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") line cannot be parsed.
- ***Reasons for error:*** When parsing the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#8440-argparser_translation_file), the Argparser found a YAML line that it doesn't recognize. This is most likely due to a YAML feature that the Argparser doesn't support to keep the parser simple.
- ***Interpolated variables:***
  - `$1`: The YAML line.

#### 8.5.117. `Error include directive`

- ***Message:*** `Error: The include directive "$1" could not be recognized.`
- ***Description:*** The error that an include directive cannot be parsed.
- ***Reasons for error:*** When parsing the [`ARGPARSER_HELP_FILE`](../environment_variables/environment_variables.md#8423-argparser_help_file) or [`ARGPARSER_USAGE_FILE`](../environment_variables/environment_variables.md#8445-argparser_usage_file), the Argparser found an include directive that is not supported.
- ***Interpolated variables:***
  - `$1`: The include directive.

#### 8.5.118. `Warning wrong arg number 1`

- ***Message:*** `Warning: The argument "$1" requires 1 value, but has $2 given.  For convenience, the default ($3) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given, while requiring one.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is one. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of given values.
  - `$3`: The default values.

#### 8.5.119. `Warning wrong arg number 2`

- ***Message:*** `Warning: The argument "$1" requires at least 1 value, but has $2 given. For convenience, the default ($3) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given, while requiring at least one.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values, which is at least one. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of given values.
  - `$3`: The default values.

#### 8.5.120. `Warning wrong arg number 3`

- ***Message:*** `Warning: The argument "$1" requires $2 values, but has $3 given.  For convenience, the default ($4) is used.`
- ***Description:*** The warning that on the command line, an argument has a wrong number of values given.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument whose number of given values doesn't match the number of required values. Thus, it falls back to the default values.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.
  - `$2`: The number of required values.
  - `$3`: The number of given values.
  - `$4`: The default values.

#### 8.5.121. `Warning deprecation`

- ***Message:*** `Warning: The argument "$1" is deprecated and will be removed in the future.`
- ***Description:*** The warning that on the command line, a deprecated argument is given.
- ***Reasons for warning:*** When parsing the command line, the Argparser found an argument which is defined as deprecated. Thus, it warns your script's user to adapt the workflow.
- ***Interpolated variables:***
  - `$1`: The argument's option or value names.

#### 8.5.122. `Warning no identifier`

- ***Message:*** `Warning: In the translation file "$1", the identifier "$2" is missing.  For convenience, the untranslated string is used, instead.`
- ***Description:*** The warning that in a translation file, an identifier is missing.
- ***Reasons for warning:*** When trying to translate a string from the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#8440-argparser_translation_file), the Argparser found that the identifier is missing in the dictionary, and by this, also in the translation file. Thus, it uses the untranslated English string as fallback.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#8440-argparser_translation_file).
  - `$2`: The missing identifier.

#### 8.5.123. `Warning no translation`

- ***Message:*** `Warning: In the translation file "$1", the translation to "$2" for the identifier "$3" is missing.  For convenience, the untranslated string is used, instead.`
- ***Description:*** The warning that in a translation file, an identifier's translation is missing.
- ***Reasons for warning:*** When trying to translate a string from the [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#8440-argparser_translation_file), the Argparser found that the translation to the [`ARGPARSER_LANGUAGE`](../environment_variables/environment_variables.md#8428-argparser_language) for the identifier is missing in the dictionary, and by this, also in the translation file. Thus, it uses the untranslated English string as fallback.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_TRANSLATION_FILE`](../environment_variables/environment_variables.md#8440-argparser_translation_file).
  - `$2`: The [`ARGPARSER_LANGUAGE`](../environment_variables/environment_variables.md#8428-argparser_language).
  - `$3`: The identifier with missing translation.

[&#129092;&nbsp;Table of contents (Translations)](toc.md)
