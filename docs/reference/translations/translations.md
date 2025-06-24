#### 7.4.1. `Positional arguments`

- ***Description:*** The name of the positional arguments' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_POSITIONAL_ARG_GROUP`](../environment_variables/environment_variables.md#7534-argparser_positional_arg_group).

#### 7.4.2. `Help options`

- ***Description:*** The name of the help options' argument group in the arguments definition, to be shown in the help message, *i.e.*, the translated [`ARGPARSER_HELP_ARG_GROUP`](../environment_variables/environment_variables.md#7522-argparser_help_arg_group).

#### 7.4.3. `Error`

- ***Description:*** The word `"Error"` in error messages.

#### 7.4.4. `Warning`

- ***Description:*** The word `"Warning"` in warning messages.

#### 7.4.5. `Usage`

- ***Description:*** The word `"Usage"` in help and usage messages.

#### 7.4.6. `Arguments`

- ***Description:*** The word `"ARGUMENTS"` in help messages, to show the existence of mandatory options (those without a default value).

#### 7.4.7. `Options`

- ***Description:*** The word `"OPTIONS"` in help messages, to show the existence of optional options (those with a default value).

#### 7.4.8. `Mandatory arguments`

- ***Description:*** The remark that mandatory arguments to long options are mandatory for short options too, to be used in the help message for the [`@Remark`](../include_directives.md#734-remark-directive) include directive.

#### 7.4.9. `Deprecated`

- ***Description:*** The word `"DEPRECATED"` in help messages, to show that an argument is deprecated and shouldn't be used, anymore.

#### 7.4.10. `Default`

- ***Description:*** The word `"default"` in help messages, to introduce the default values.

#### 7.4.11. `--help`

- ***Description:*** the help text for the help options, *i.e.*, the [`ARGPARSER_HELP_OPTIONS`](../environment_variables/environment_variables.md#7527-argparser_help_options) and `--help`, if [`ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md#752-argparser_add_help) is set to `true`.

#### 7.4.12. `--usage`

- ***Description:*** the help text for the usage options, *i.e.*, the [`ARGPARSER_USAGE_OPTIONS`](../environment_variables/environment_variables.md#7552-argparser_usage_options) and `--usage`, if [`ARGPARSER_ADD_USAGE`](../environment_variables/environment_variables.md#753-argparser_add_usage) is set to `true`.

#### 7.4.13. `--version`

- ***Description:*** the help text for the version options, *i.e.*, the [`ARGPARSER_VERSION_OPTIONS`](../environment_variables/environment_variables.md#7559-argparser_version_options) and `--version`, if [`ARGPARSER_ADD_VERSION`](../environment_variables/environment_variables.md#754-argparser_add_version) is set to `true`.

#### 7.4.14. `false`

- ***Description:*** The default value of `false` in help messages.

#### 7.4.15. `true`

- ***Description:*** The default value of `true` in help messages.

#### 7.4.16. `Error env var bool`

- ***Description:*** The error that an environment variable is not a boolean.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `true` and `false`.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.17. `Error env var char`

- ***Description:*** The error that an environment variable is not a character.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value whose length differs from one.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.18. `Error env var identifier`

- ***Description:*** The error that an environment variable is not usable as a Bash variable identifier.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value not matched by the regular expression `[[:alpha:]_]*([[:word:]])` in Bash's extglob syntax.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.19. `Error env var int`

- ***Description:*** The error that an environment variable is not an integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value containing non-digit characters (excluding a leading sign).
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.20. `Error env var uint`

- ***Description:*** The error that an environment variable is not an unsigned integer.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value containing non-digit characters (including a leading sign).
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.21. `Error env var file 0001`

- ***Description:*** The error that an environment variable refers to an empty file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.22. `Error env var file 0010`

- ***Description:*** The error that an environment variable refers to a file which is not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.23. `Error env var file 0011`

- ***Description:*** The error that an environment variable refers to an empty file which is also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.24. `Error env var file 0100`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.25. `Error env var file 0101`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.26. `Error env var file 0110`

- ***Description:*** The error that an environment variable refers to a file which is not a regular file and also not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.27. `Error env var file 0111`

- ***Description:*** The error that an environment variable refers to an empty file which is also not a regular file and not readable.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file has been found empty and not to be a regular file, like a directory, pipe, or socket, and also not readable.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.28. `Error env var file 1111`

- ***Description:*** The error that an environment variable refers to a nonexistent file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to point to a file, but this file does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.29. `Error env var styles`

- ***Description:*** The error that an environment variable refers to an undefined [color or style](../colors_and_styles.md#72-colors-and-styles).
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value intended to set a message color or style which does not exist.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The environment variable's value.

#### 7.4.30. `Error env var option type`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](../environment_variables/environment_variables.md#7550-argparser_usage_message_option_type) is not set to `long` or `short`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `long` and `short`.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 7.4.31. `Error env var orientation`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](../environment_variables/environment_variables.md#7551-argparser_usage_message_orientation) is not set to `row` or `column`.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_ORIENTATION`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value other than `row` and `column`.
- ***Interpolated variables:***
  - `$1`: The environment variable's value.

#### 7.4.32. `Error env var delimiters`

- ***Description:*** The error that the environment variables [`ARGPARSER_ARG_DELIMITER_1`](../environment_variables/environment_variables.md#7511-argparser_arg_delimiter_1) and [`ARGPARSER_ARG_DELIMITER_2`](../environment_variables/environment_variables.md#7512-argparser_arg_delimiter_2) have an identical value.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variables `ARGPARSER_ARG_DELIMITER_1` and `ARGPARSER_ARG_DELIMITER_2`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, have the same value, rendering parsing of the arguments definition impossible.

#### 7.4.33. `Error env var short name empty`

- ***Description:*** The error that an environment variable uses the empty string (`""`) as short option name.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has the empty string (`""`) given as one of the short option names.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The number of short option names.

#### 7.4.34. `Error env var short name length`

- ***Description:*** The error that an environment variable has a too long short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option name given whose length is greater than one, which contradicts the definition of short options.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option's name.

#### 7.4.35. `Error env var short name inner duplication`

- ***Description:*** The error that an environment variable has a short option name given multiple times.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option name given more than once in its own value.
- ***Interpolated variables:***
  - `$1`: The environment variable's name.
  - `$2`: The short option's name.
  - `$3`: The number of identical short option names.

#### 7.4.36. `Error env var short name outer duplication`

- ***Description:*** The error that two environment variables have the same short option name given.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a short option name that was already given to an earlier parsed environment variable.
- ***Interpolated variables:***
  - `$1`: The current environment variable's name.
  - `$2`: The short option's name.
  - `$3`: The previous environment variable's name.

#### 7.4.37. `Error env var short options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#7430-error-env-var-option-type) requests short option names, while [`ARGPARSER_USE_SHORT_OPTIONS`](../environment_variables/environment_variables.md#7555-argparser_use_short_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `short`, while `ARGPARSER_USE_SHORT_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no short option name is available.

#### 7.4.38. `Error env var long options`

- ***Description:*** The error that the environment variable [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](#7430-error-env-var-option-type) requests long option names, while [`ARGPARSER_USE_LONG_OPTIONS`](../environment_variables/environment_variables.md#7554-argparser_use_long_options) prohibits this.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that the environment variable `ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, is set to `long`, while `ARGPARSER_USE_LONG_OPTIONS` is set to `false`. Consequently, the usage message could not be created, since no long option name is available.

#### 7.4.39. `Error env var files`

- ***Description:*** The error that two environment variables refer to the same file.
- ***Reasons for error:*** When [`ARGPARSER_CHECK_ENV_VARS`](../environment_variables/environment_variables.md#7516-argparser_check_env_vars) is set to `true`, the Argparser detected that an environment variable, provided by either an option from the [`ARGPARSER_CONFIG_FILE`](../environment_variables/environment_variables.md#7517-argparser_config_file), on the Argparser invokation command line, or as an environment variable, has a value pointing to the same file as an earlier parsed environment variable. Since the files referred to by these environment variables have different meanings (like the Argparser configuration and translation), it is impossible that both information is given in the same file.
- ***Interpolated variables:***
  - `$1`: The first environment variable's name.
  - `$2`: The second environment variable's name.

#### 7.4.40. `Error arg array 1`

- ***Description:*** The error that no arguments definition has been provided upon calling the Argparser.
- ***Reasons for error:*** When calling (and not sourcing) the Argparser, the arguments definition must be provided through STDIN, either by piping or by process substitution. However, STDIN (file descriptor 0) has been deemed empty.
- ***Interpolated variables:***
  - `$1`: The path to the Argparser, as [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#7537-argparser_script_name).

#### 7.4.41. `Error arg array 2`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#759-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"` and reports the first match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.
  - `$2`: The guesstimated actual name of the variable.

#### 7.4.42. `Error arg array 3`

- ***Description:*** The error that [`ARGPARSER_ARG_ARRAY_NAME`](../environment_variables/environment_variables.md#759-argparser_arg_array_name) refers to a variable that's not defined.
- ***Reasons for error:*** The arguments definition must be provided as an array variable whose name is stored in `ARGPARSER_ARG_ARRAY_NAME`. If this variable is not defined, the Argparser tries to guess how it might have been called by looking for all variable names starting with `"arg"`, but didn't find any match.
- ***Interpolated variables:***
  - `$1`: The variable `ARGPARSER_ARG_ARRAY_NAME` refers to.

#### 7.4.43. `Error no arg def`

- ***Description:*** The error that an argument is lacking a definition.
- ***Reasons for error:*** When reading the arguments definition, the Argparser found a definition line giving only an argument name, but no definition corresponding to this argument in the accompanying [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#7510-argparser_arg_def_file).
- ***Interpolated variables:***
  - `$1`: The problematic arguments definition line with the argument.

#### 7.4.44. `Error arg def id`

- ***Description:*** The error that the arguments definition in the script lacks the `id` column.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#7537-argparser_script_name) with the problematic definition.

#### 7.4.45. `Error arg def file id`

- ***Description:*** The error that the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#7510-argparser_arg_def_file) lacks a column, instead giving an unused one.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found the definition lacking the token `id` in the header.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#7510-argparser_arg_def_file) with the problematic definition.

#### 7.4.46. `Error arg def field count`

- ***Description:*** The error that in the arguments definition in the script, the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the script, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_SCRIPT_NAME`](../environment_variables/environment_variables.md#7537-argparser_script_name) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

#### 7.4.47. `Error arg def file id`

- ***Description:*** The error that in the arguments definition in the [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#7510-argparser_arg_def_file), the lines have differing field counts.
- ***Reasons for error:*** When parsing the arguments definition from the `ARGPARSER_ARG_DEF_FILE`, the Argparser found a line in the definition having a different number of fields (columns) than the header. Thus, the header fields cannot be mapped to the line's fields.
- ***Interpolated variables:***
  - `$1`: The [`ARGPARSER_ARG_DEF_FILE`](../environment_variables/environment_variables.md#7510-argparser_arg_def_file) with the problematic definition.
  - `$2`: The current line.
  - `$3`: The current line's number of fields.
  - `$4`: The header's number of fields.

[&#129092;&nbsp;`toc.md`](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`../environment_variables/introduction.md`&nbsp;&#129094;](../environment_variables/introduction.md)
