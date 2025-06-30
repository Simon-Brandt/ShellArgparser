#### 8.4.1. `Positional arguments`

- ***Description:*** The name of the positional arguments' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#8534-argparser_positional_arg_group).

#### 8.4.2. `Help options`

- ***Description:*** The name of the help options' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#8522-argparser_help_arg_group).

#### 8.4.3. `Error`

- ***Description:*** The word `"Error"` in error messages.

#### 8.4.4. `Warning`

- ***Description:*** The word `"Warning"` in warning messages.

#### 8.4.5. `Usage`

- ***Description:*** The word `"Usage"` in help and usage messages.

#### 8.4.6. `Arguments`

- ***Description:*** The word `"ARGUMENTS"` in help messages, to show the existence of mandatory options (those without a default value).

#### 8.4.7. `Options`

- ***Description:*** The word `"OPTIONS"` in help messages, to show the existence of optional options (those with a default value).

#### 8.4.8. `Mandatory arguments`

- ***Description:*** The remark that mandatory arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#834-remark-directive) include directive.

#### 8.4.9. `Deprecated`

- ***Description:*** The word `"DEPRECATED"` in help messages, to show that an argument is deprecated and shouldn't be used, anymore.

#### 8.4.10. `Default`

- ***Description:*** The word `"default"` in help messages, to introduce the default values.

#### 8.4.11. `--help`

- ***Description:*** the help text for the help options, *i.e.*, the [`ARGPARSER_HELP_OPTIONS`](../environment_variables/environment_variables.md#8527-argparser_help_options) and `--help`, if [`ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md#852-argparser_add_help) is set to `true`.

#### 8.4.12. `--usage`

- ***Description:*** the help text for the usage options, *i.e.*, the [`ARGPARSER_USAGE_OPTIONS`](../environment_variables/environment_variables.md#8552-argparser_usage_options) and `--usage`, if [`ARGPARSER_ADD_USAGE`](../environment_variables/environment_variables.md#853-argparser_add_usage) is set to `true`.

#### 8.4.13. `--version`

- ***Description:*** the help text for the version options, *i.e.*, the [`ARGPARSER_VERSION_OPTIONS`](../environment_variables/environment_variables.md#8559-argparser_version_options) and `--version`, if [`ARGPARSER_ADD_VERSION`](../environment_variables/environment_variables.md#854-argparser_add_version) is set to `true`.

#### 8.4.14. `false`

- ***Description:*** The default value of `false` in help messages.

#### 8.4.15. `true`

- ***Description:*** The default value of `true` in help messages.

#### 8.4.16. `Error env var bool`

- ***Description:*** The error that an environment variable is not a Boolean.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.17. `Error env var char`

- ***Description:*** The error that an environment variable is not a character.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.18. `Error env var identifier`

- ***Description:*** The error that an environment variable is not usable as a Bash variable identifier.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not matched by the regular expression `[[:alpha:]_]*([[:word:]])` in Bash's extglob syntax.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.19. `Error env var int`

- ***Description:*** The error that an environment variable is not an integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.20. `Error env var uint`

- ***Description:*** The error that an environment variable is not an unsigned integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not according to the data type `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.21. `Error env var file 0001`

- ***Description:*** The error that an environment variable refers to an empty file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.22. `Error env var file 0010`

- ***Description:*** The error that an environment variable refers to a file which is not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.23. `Error env var file 0011`

- ***Description:*** The error that an environment variable refers to an empty file which is also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.24. `Error env var file 0100`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.25. `Error env var file 0101`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.26. `Error env var file 0110`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file and also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.27. `Error env var file 0111`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file and not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.28. `Error env var file 1111`

- ***Description:*** The error that an environment variable refers to a nonexistent file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.29. `Error env var styles`

- ***Description:*** The error that an environment variable refers to an undefined [color or style](../colors_and_styles.md#82-colors-and-styles).
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to set a message color or style which does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 8.4.30. `Error env var option type`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#8550-argparser_usage_message_option_type) is not set to `long` or `short`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `long` and `short`. Since there are only short and long option names possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 8.4.31. `Error env var orientation`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../environment_variables/environment_variables.md#8551-argparser_usage_message_orientation) is not set to `row` or `column`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_ORIENTATION`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `row` and `column`. Since only a row-like or column-like structure is possible, other values are refused.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 8.4.32. `Error env var delimiters`

- ***Description:*** The error that the environment variables [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#8511-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#8512-argparser_arg_delimiter_2) have an identical value.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variables `ARGPARSER_ARG_DELIMITER_1` and `ARGPARSER_ARG_DELIMITER_2`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, have the same value. This renders parsing of the arguments definition impossible, as multi-value fields cannot be told apart from column delimiters.

#### 8.4.33. `Error env var short name empty`

- ***Description:*** The error that an environment variable uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The number of short option names.

#### 8.4.34. `Error env var short name length`

- ***Description:*** The error that an environment variable has a short option name with more than one character length given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where a name is longer than one character. This contradicts the definition of short options, and would interfere with merging short options on the command line.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option name.

#### 8.4.35. `Error env var short name inner duplication`

- ***Description:*** The error that an environment variable has a short option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 8.4.36. `Error env var short name outer duplication`

- ***Description:*** The error that at least two environment variables have the same short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option defined, which is already in use by a previously parsed environment variable. When given on the command line, it would be unclear which environment variable would be referred to.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The short option name.
  - `$3`: The previous environment variable's name.

#### 8.4.37. `Error env var short options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#8430-error-env-var-option-type) requests short option names, while [`ARGPARSER_USE_SHORT_OPTIONS`](../environment_variables/environment_variables.md#8555-argparser_use_short_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `short`, while `ARGPARSER_USE_SHORT_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no short option name is available.

#### 8.4.38. `Error env var long options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#8430-error-env-var-option-type) requests long option names, while [`ARGPARSER_USE_LONG_OPTIONS`](../environment_variables/environment_variables.md#8554-argparser_use_long_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `long`, while `ARGPARSER_USE_LONG_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no long option name is available.

#### 8.4.39. `Error env var files`

- ***Description:*** The error that two environment variables refer to the same file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#8516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#8517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value pointing to the same file as an earlier parsed environment variable. Since the files referred to by these environment variables have different meanings (like the Argparser configuration and translation), it is impossible that both information is given in the same file.
- ***Interpolated variables:***
  - `$1`: The first environment variable's name.
  - `$2`: The second environment variable's name.

#### 8.4.40. `Error arg array 1`

- ***Description:*** The error that no arguments definition has been provided upon calling the Argparser.
- ***Reasons for error:*** When calling (and not sourcing) the Argparser, the arguments definition must be provided through STDIN, either by piping or by process substitution. However, STDIN (file descriptor 0) has been deemed empty.
- ***Interpolated variables:***
  - `$1`: The path to the Argparser, as [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8537-argparser_script_name).

#### 8.4.41. `Error arg array 2`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#859-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"` and reports the first match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.
  - `$2`: The guesstimated actual name of the variable.

#### 8.4.42. `Error arg array 3`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#859-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"`, but didn't find any match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.

#### 8.4.43. `Error no arg def`

- ***Description:*** The error that an argument is lacking a definition.
- ***Reasons for error:*** When reading the arguments definition, the Argparser found a definition line giving only an argument name, but no definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8510-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 8.4.44. `Error arg def id`

- ***Description:*** The error that the arguments definition in the script lacks the `id` column.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8537-argparser_script_name) with the problematic definition.

#### 8.4.45. `Error arg def file id`

- ***Description:*** The error that the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8510-argparser_arg_def_file) lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8510-argparser_arg_def_file) with the problematic definition.

#### 8.4.46. `Error arg def field count`

- ***Description:*** The error that in the arguments definition in the script, the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#8537-argparser_script_name) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 8.4.47. `Error arg def file field count`

- ***Description:*** The error that in the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8510-argparser_arg_def_file), the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#8510-argparser_arg_def_file) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 8.4.48. `Error arg def short name empty`

- ***Description:*** The error that in the arguments definition, an argument uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of short option names.

#### 8.4.49. `Error arg def short name help`

- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the help message. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.4.50. `Error arg def short name usage`

- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the usage message. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.4.51. `Error arg def short name version`

- ***Description:*** The error that in the arguments definition, an argument has the same short option name as the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is identical to one of those used to invoke the version message. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.4.52. `Error arg def short name length`

- ***Description:*** The error that in the arguments definition, an argument has a short option name with more than one character length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is longer than one character. This contradicts the definition of short options, and would interfere with merging short options on the command line. Use a long option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.

#### 8.4.53. `Error arg def short name inner duplication`

- ***Description:*** The error that in the arguments definition, an argument has a short option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The number of occurrences of the short option name.

#### 8.4.54. `Error arg def short name outer duplication`

- ***Description:*** The error that in the arguments definition, at least two arguments have the same short option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a short option defined, which is already in use by a previously parsed argument. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The short option name.
  - `$3`: The previously parsed argument's identifier.

#### 8.4.55. `Error arg def long name empty`

- ***Description:*** The error that in the arguments definition, an argument uses the empty string (`""`) as long option name.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where at least one name of which is empty. This option name could never be given on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of long option names.

#### 8.4.56. `Error arg def long name help`

- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the help option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to one of those used to invoke the help message. Since parsing the latter takes precedence, the option name would always refer to the help message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 8.4.57. `Error arg def long name usage`

- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the usage option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to one of those used to invoke the usage message. Since parsing the latter takes precedence, the option name would always refer to the usage message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 8.4.58. `Error arg def long name version`

- ***Description:*** The error that in the arguments definition, an argument has the same long option name as the version option.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is identical to one of those used to invoke the version message. Since parsing the latter takes precedence, the option name would always refer to the version message on the command line.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 8.4.59. `Error arg def long name length`

- ***Description:*** The error that in the arguments definition, an argument has a long option name with less than two characters length.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is shorter than two characters. This contradicts the definition of long options. Use a short option name, instead.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.

#### 8.4.60. `Error arg def long name inner duplication`

- ***Description:*** The error that in the arguments definition, an argument has a long option name given multiple times.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, where a name is given more than once. This is likely a typo when wanting to specify similar name aliases. Although this would mean no harm for the end user, as giving that name would still refer to the correct option, the error is not just a warning for consistency with more serious errors.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The number of occurrences of the long option name.

#### 8.4.61. `Error arg def long name outer duplication`

- ***Description:*** The error that in the arguments definition, at least two arguments have the same long option name given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a long option defined, which is already in use by a previously parsed argument. When given on the command line, it would be unclear which option would be referred to.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The long option name.
  - `$3`: The previously parsed argument's identifier.

#### 8.4.62. `Error arg def pos default 1`

- ***Description:*** The error that in the arguments definition of a positional argument, the number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 8.4.63. `Error arg def pos default 2`

- ***Description:*** The error that in the arguments definition of a positional argument, the number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 8.4.64. `Error arg def pos choice`

- ***Description:*** The error that in the arguments definition of a positional argument, the default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 8.4.65. `Error arg def pos optionals`

- ***Description:*** The error that in the arguments definition, at least two positional arguments are optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, as another previously parsed argument is. In the general case, it is impossible to parse this, since it cannot be inferred which optional argument is given.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.4.66. `Error arg def pos optional infinite`

- ***Description:*** The error that in the arguments definition, at least one positional argument is optional, with another one accepting an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while another previously parsed argument accepts an infinite number of values. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the argument accepting an infinite number of values.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.4.67. `Error arg def pos flag`

- ***Description:*** The error that in the arguments definition of a positional argument, the number of required arguments is zero.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting no value, just as a flag. However, the presence of a flag is indicated by the presence of the respective keyword argument (option name), which does not exist for positional arguments. Thus, positional flags aren't possible.
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.4.68. `Error arg def pos infinites`

- ***Description:*** The error that in the arguments definition, at least two positional arguments accept an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting an infinite number of values, just as another previously parsed argument does. It is impossible to parse this, since it cannot be inferred which of these arguments would take a given value.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.4.69. `Error arg def pos infinite optional 1`

- ***Description:*** The error that in the arguments definition, a positional argument is both optional and accepts an infinite number of values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as optional, while accepting an infinite number of values. Although parsable in theory, the Argparser does not yet support this behavior (the argument count `*`).
- ***Interpolated variables:***
  - `$1`: The argument identifier.

#### 8.4.70. `Error arg def pos infinite optional 2`

- ***Description:*** The error that in the arguments definition, at least one positional argument accepts an infinite number of values, with another one being optional.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined as accepting an infinite number of values, while another previously parsed argument is optional. It is impossible to parse this, since it cannot be inferred whether the optional argument is given, when the value could also be accepted by the argument accepting an infinite number of values.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The previously parsed argument's identifier.

#### 8.4.71. `Error arg def pos type`

- ***Description:*** The error that in the arguments definition, a positional argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 8.4.72. `Error arg def pos bool`

- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.73. `Error arg def pos char`

- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.74. `Error arg def pos float`

- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.75. `Error arg def pos int`

- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.76. `Error arg def pos uint`

- ***Description:*** The error that in the arguments definition of a positional argument, a choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.77. `Error arg def pos note`

- ***Description:*** The error that in the arguments definition of a positional argument, an unsupported note is given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a positional argument defined with a note other than `"deprecated"`. Currently, the Argparser doesn't support any other note, but may do so in the future.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 8.4.78. `Error arg def option flag`

- ***Description:*** The error that in the arguments definition, a flag has a non-Boolean default value.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as accepting no value, *i.e.*, as a flag. Thus, the default value must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The default value.

#### 8.4.79. `Error arg def option default 1`

- ***Description:*** The error that in the arguments definition of a keyword argument, the number of default values doesn't match the number of required values, which is one.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values, which is one. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of default values.

#### 8.4.80. `Error arg def option default 2`

- ***Description:*** The error that in the arguments definition of a keyword argument, the number of default values doesn't match the number of required values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose number of default values doesn't match the number of required values. Since the latter is likely a requirement for your script, you could not rely on the number being correct when default values are used.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The number of required values.
  - `$3`: The number of default values.

#### 8.4.81. `Error arg def option choice flag`

- ***Description:*** The error that in the arguments definition, a flag has choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined as flag, but with choice values. Since they are `true` and `false` by definition, and flags not accepting any value, specifying choice values is either redundant or wrong, depending on the point of view.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.

#### 8.4.82. `Error arg def option choice`

- ***Description:*** The error that in the arguments definition of a keyword argument, the default values aren't a subset of the choice values.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined, whose default values aren't completely given as choice values, contradicting the latter's purpose.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice values.
  - `$3`: The default values.

#### 8.4.83. `Error arg def option type`

- ***Description:*** The error that in the arguments definition, a keyword argument has an unsupported data type.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a data type which the Argparser doesn't support. Although only simple regex-based type checks are performed, for clarity in the arguments definition, a correct data type must be given. These are `bool`, `char`, `float`, `file`, `int`, `str`, and `uint`. For arbitrary or unsupported data types, use `str` (or possibly `file`), which is unchecked.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The data type.

#### 8.4.84. `Error arg def option bool`

- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a Boolean.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `bool`. These Boolean values must be either `true` or `false`.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.85. `Error arg def option char`

- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a character.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `char`. These characters must be strings comprising one printable ASCII character.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.86. `Error arg def option float`

- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not a floating-point number.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `float`. These floating-point numbers must comprise only digits, a dot, and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.87. `Error arg def option int`

- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not an integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `int`. These integers must comprise only digits and possibly a leading sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.88. `Error arg def option uint`

- ***Description:*** The error that in the arguments definition of a keyword argument, a choice value's data type is not an unsigned integer.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a choice value whose data type doesn't accord to the argument's data type, `uint`. These unsigned integers must comprise only digits and no sign.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The choice value.

#### 8.4.89. `Error arg def option note`

- ***Description:*** The error that in the arguments definition of a keyword argument, an unsupported note is given.
- ***Reasons for error:*** When parsing the arguments definition, the Argparser found a line in the definition having a keyword argument defined with a note other than `"deprecated"`. Currently, the Argparser doesn't support any other note, but may do so in the future.
- ***Interpolated variables:***
  - `$1`: The argument identifier.
  - `$2`: The note.

#### 8.4.90. `Error arg double hyphen`

- ***Description:*** The error that on the command line, the option `--` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a double hyphen with an equals sign (`=`), possibly followed by a value. Since `--` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 8.4.91. `Error arg double plus`

- ***Description:*** The error that on the command line, the option `++` has a value given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a doubled plus sign with an equals sign (`=`), possibly followed by a value. Since `++` acts as positional arguments delimiter, specifying a value would have no meaning.

#### 8.4.92. `Error arg inversion`

- ***Description:*** The error that on the command line, an option starts with a `+` or `++`, when flag inversion is deactivated.
- ***Reasons for error:*** When parsing the command line, the Argparser found an option that starts with a plus sign, meaning the intention to invert the flag, but [`ARGPARSER_ALLOW_FLAG_INVERSION`](../environment_variables/environment_variables.md#855-argparser_allow_flag_inversion) is set to `false`. This removes the ability to use the `+` prefix.

#### 8.4.93. `Error arg unknown`

- ***Description:*** The error that on the command line, an undefined argument is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found an argument that has not been defined in the arguments definition, thus failing to parse it.
- ***Interpolated variables:***
  - `$1`: The unknown argument.

#### 8.4.94. `Error long option match`

- ***Description:*** The error that on the command line, an abbreviated long option matches multiple option names.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](../environment_variables/environment_variables.md#857-argparser_allow_option_abbreviation) is set to `true`, the Argparser found a long option being abbreviated, but matching more than one defined long option in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The ambiguous long option.

#### 8.4.95. `Error long option negation`

- ***Description:*** The error that on the command line, an undefined negated long option is given.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_FLAG_NEGATION`](../environment_variables/environment_variables.md#856-argparser_allow_flag_negation) is set to `true`, the Argparser found a long option starting with `--no-`, but the remaining (affirmative) version has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The negated long option.

#### 8.4.96. `Error long option unknown`

- ***Description:*** The error that on the command line, an unknown long option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a long option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown long option.

#### 8.4.97. `Error short option merge`

- ***Description:*** The error that on the command line, an unknown short option is given in merged form.
- ***Reasons for error:*** When parsing the command line and [`ARGPARSER_ALLOW_OPTION_MERGING`](../environment_variables/environment_variables.md#858-argparser_allow_option_merging) is set to `true`, the Argparser found a short option, merged with others, that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The merged short options' common prefix.
  - `$2`: The unknown short option.

#### 8.4.98. `Error short option unknown`

- ***Description:*** The error that on the command line, an unknown short option is given.
- ***Reasons for error:*** When parsing the command line, the Argparser found a short option that has not been defined in the arguments definition.
- ***Interpolated variables:***
  - `$1`: The unknown short option.

#### 8.4.99. `Error pos arg count 1`

- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments, which is one.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less than one positional argument being given, while one is required.
- ***Interpolated variables:***
  - `$1`: The number of given positional arguments

#### 8.4.100. `Error pos arg count 2`

- ***Description:*** The error that on the command line, the number of given positional arguments doesn't match the number of required positional arguments.
- ***Reasons for error:*** When parsing the command line, the Argparser found more or less positional arguments being given than required.
- ***Interpolated variables:***
  - `$1`: The number of required positional arguments
  - `$2`: The number of given positional arguments

[&#129092;&nbsp;Table of contents (Translations)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[8.5. Environment variables&nbsp;&#129094;](../environment_variables/introduction.md)
