#### 8.4.1. Overview

<!-- <table caption="Overview over the Argparser environment variables"> -->
*Tab. 7: Overview over the Argparser environment variables.*

| Variable name                                                                      | Type[^14]  | Default value[^15][^16]  |
| ---------------------------------------------------------------------------------- | ---------- | ------------------------ |
| [`ARGPARSER_ADD_HELP`](environment_variables.md#842-argparser_add_help)                                    | *bool*     | `true`                   |
| [`ARGPARSER_ADD_USAGE`](environment_variables.md#843-argparser_add_usage)                                  | *bool*     | `true`                   |
| [`ARGPARSER_ADD_VERSION`](environment_variables.md#844-argparser_add_version)                              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_INVERSION`](environment_variables.md#845-argparser_allow_flag_inversion)            | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_NEGATION`](environment_variables.md#846-argparser_allow_flag_negation)              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](environment_variables.md#847-argparser_allow_option_abbreviation)  | *bool*     | `false`                  |
| [`ARGPARSER_ALLOW_OPTION_MERGING`](environment_variables.md#848-argparser_allow_option_merging)            | *bool*     | `false`                  |
| [`ARGPARSER_ARG_ARRAY_NAME`](environment_variables.md#849-argparser_arg_array_name)                        | *str*[^17] | `"args"`                 |
| [`ARGPARSER_ARG_DEF_FILE`](environment_variables.md#8410-argparser_arg_def_file)                           | *file*     | `""`                     |
| [`ARGPARSER_ARG_DELIMITER_1`](environment_variables.md#8411-argparser_arg_delimiter_1)                     | *char*     | `"\|"`[^18]              |
| [`ARGPARSER_ARG_DELIMITER_2`](environment_variables.md#8412-argparser_arg_delimiter_2)                     | *char*     | `","`[^18]               |
| [`ARGPARSER_ARGPARSER_VERSION`](environment_variables.md#8413-argparser_argparser_version)                 | *str*      | *None* (unset)           |
| [`ARGPARSER_ARGS`](environment_variables.md#8414-argparser_args)                                           | *arr*      | *None* (unset)           |
| [`ARGPARSER_CHECK_ARG_DEF`](environment_variables.md#8415-argparser_check_arg_def)                         | *bool*     | `false`                  |
| [`ARGPARSER_CHECK_ENV_VARS`](environment_variables.md#8416-argparser_check_env_vars)                       | *bool*     | `false`                  |
| [`ARGPARSER_CONFIG_FILE`](environment_variables.md#8417-argparser_config_file)                             | *file*     | `""`                     |
| [`ARGPARSER_COUNT_FLAGS`](environment_variables.md#8418-argparser_count_flags)                             | *bool*     | `false`                  |
| [`ARGPARSER_DICTIONARY`](environment_variables.md#8419-argparser_dictionary)                               | *dict*     | *None* (unset)           |
| [`ARGPARSER_ERROR_EXIT_CODE`](environment_variables.md#8420-argparser_error_exit_code)                     | *int*      | `1`                      |
| [`ARGPARSER_ERROR_STYLE`](environment_variables.md#8421-argparser_error_style)                             | *str*      | `"red,bold,reverse"`     |
| [`ARGPARSER_HELP_EXIT_CODE`](environment_variables.md#8423-argparser_help_exit_code)                       | *int*      | `0`                      |
| [`ARGPARSER_HELP_ARG_GROUP`](environment_variables.md#8422-argparser_help_arg_group)                       | *str*      | `"Help options"`         |
| [`ARGPARSER_HELP_FILE`](environment_variables.md#8424-argparser_help_file)                                 | *file*     | `""`                     |
| [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables.md#8425-argparser_help_file_include_char)       | *char*     | `"@"`                    |
| [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](environment_variables.md#8426-argparser_help_file_keep_comments)     | *bool*     | `false`                  |
| [`ARGPARSER_HELP_OPTIONS`](environment_variables.md#8427-argparser_help_options)                           | *char*     | `"h,?"`                  |
| [`ARGPARSER_HELP_STYLE`](environment_variables.md#8428-argparser_help_style)                               | *str*      | `"italic"`               |
| [`ARGPARSER_LANGUAGE`](environment_variables.md#8429-argparser_language)                                   | *str*      | `"en"`                   |
| [`ARGPARSER_MAX_COL_WIDTH_1`](environment_variables.md#8430-argparser_max_col_width_1)                     | *uint*     | `5`[^19]                 |
| [`ARGPARSER_MAX_COL_WIDTH_2`](environment_variables.md#8431-argparser_max_col_width_2)                     | *uint*     | `33`[^19]                |
| [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables.md#8432-argparser_max_col_width_3)                     | *uint*     | `0`[^19]                 |
| [`ARGPARSER_MAX_WIDTH`](environment_variables.md#8433-argparser_max_width)                                 | *uint*     | `79`                     |
| [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables.md#8434-argparser_positional_arg_group)           | *str*      | `"Positional arguments"` |
| [`ARGPARSER_READ_ARGS`](environment_variables.md#8435-argparser_read_args)                                 | *bool*     | `true`                   |
| [`ARGPARSER_SCRIPT_ARGS`](environment_variables.md#8436-argparser_script_args)                             | *arr*      | *None* (unset)           |
| [`ARGPARSER_SCRIPT_NAME`](environment_variables.md#8437-argparser_script_name)                             | *str*      | `"${0##*/}"`             |
| [`ARGPARSER_SET_ARGS`](environment_variables.md#8438-argparser_set_args)                                   | *bool*     | `true`                   |
| [`ARGPARSER_SET_ARRAYS`](environment_variables.md#8439-argparser_set_arrays)                               | *bool*     | `true`                   |
| [`ARGPARSER_SILENCE_ERRORS`](environment_variables.md#8440-argparser_silence_errors)                       | *bool*     | `false`                  |
| [`ARGPARSER_SILENCE_WARNINGS`](environment_variables.md#8441-argparser_silence_warnings)                   | *bool*     | `false`                  |
| [`ARGPARSER_TRANSLATION_FILE`](environment_variables.md#8442-argparser_translation_file)                   | *file*     | `""`                     |
| [`ARGPARSER_UNSET_ARGS`](environment_variables.md#8443-argparser_unset_args)                               | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_ENV_VARS`](environment_variables.md#8444-argparser_unset_env_vars)                       | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_FUNCTIONS`](environment_variables.md#8445-argparser_unset_functions)                     | *bool*     | `true`                   |
| [`ARGPARSER_USAGE_EXIT_CODE`](environment_variables.md#8446-argparser_usage_exit_code)                     | *int*      | `0`                      |
| [`ARGPARSER_USAGE_FILE`](environment_variables.md#8447-argparser_usage_file)                               | *file*     | `""`                     |
| [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables.md#8448-argparser_usage_file_include_char)     | *char*     | `"@"`                    |
| [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](environment_variables.md#8449-argparser_usage_file_keep_comments)   | *bool*     | `false`                  |
| [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](environment_variables.md#8450-argparser_usage_message_option_type) | *str*      | `"short"`                |
| [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](environment_variables.md#8451-argparser_usage_message_orientation) | *str*      | `"row"`                  |
| [`ARGPARSER_USAGE_OPTIONS`](environment_variables.md#8452-argparser_usage_options)                         | *char*     | `"u"`                    |
| [`ARGPARSER_USAGE_STYLE`](environment_variables.md#8453-argparser_usage_style)                             | *str*      | `"italic"`               |
| [`ARGPARSER_USE_LONG_OPTIONS`](environment_variables.md#8454-argparser_use_long_options)                   | *bool*     | `true`                   |
| [`ARGPARSER_USE_SHORT_OPTIONS`](environment_variables.md#8455-argparser_use_short_options)                 | *bool*     | `true`                   |
| [`ARGPARSER_USE_STYLES_IN_FILES`](environment_variables.md#8456-argparser_use_styles_in_files)             | *bool*     | `false`                  |
| [`ARGPARSER_VERSION`](environment_variables.md#8457-argparser_version)                                     | *str*      | `"1.0.0"`                |
| [`ARGPARSER_VERSION_EXIT_CODE`](environment_variables.md#8458-argparser_version_exit_code)                 | *int*      | `0`                      |
| [`ARGPARSER_VERSION_OPTIONS`](environment_variables.md#8459-argparser_version_options)                     | *char*     | `"V"`                    |
| [`ARGPARSER_VERSION_STYLE`](environment_variables.md#8460-argparser_version_style)                         | *str*      | `"bold"`                 |
| [`ARGPARSER_WARNING_STYLE`](environment_variables.md#8461-argparser_warning_style)                         | *str*      | `"red,bold"`             |
| [`ARGPARSER_WRITE_ARGS`](environment_variables.md#8462-argparser_write_args)                               | *bool*     | `false`                  |

[^14]: Bash is weakly typed, hence the denoted types are just a guidance.
[^15]: Strings can optionally be enclosed by quotes.
[^16]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^17]: In fact, any legit Bash variable identifier.
[^18]: Values must be different from each other.
[^19]: Sum of values is recommended to be 77.

[&#129092;&nbsp;Table of contents (Environment variables)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[8.4.2. `ARGPARSER_ADD_HELP`&nbsp;&#129094;](environment_variables.md)
