#### 6.5.1. Overview

| Variable name                                                                      | Type[^14]  | Default value[^15][^16]  |
|------------------------------------------------------------------------------------|------------|--------------------------|
| [`ARGPARSER_ADD_HELP`](environment_variables.md#652-argparser_add_help)                                    | *bool*     | `true`                   |
| [`ARGPARSER_ADD_USAGE`](environment_variables.md#653-argparser_add_usage)                                  | *bool*     | `true`                   |
| [`ARGPARSER_ADD_VERSION`](environment_variables.md#654-argparser_add_version)                              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_INVERSION`](environment_variables.md#655-argparser_allow_flag_inversion)            | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_NEGATION`](environment_variables.md#656-argparser_allow_flag_negation)              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](environment_variables.md#657-argparser_allow_option_abbreviation)  | *bool*     | `false`                  |
| [`ARGPARSER_ALLOW_OPTION_MERGING`](environment_variables.md#658-argparser_allow_option_merging)            | *bool*     | `false`                  |
| [`ARGPARSER_ARG_ARRAY_NAME`](environment_variables.md#659-argparser_arg_array_name)                        | *str*[^17] | `"args"`                 |
| [`ARGPARSER_ARG_DEF_FILE`](environment_variables.md#6510-argparser_arg_def_file)                           | *file*     | `""`                     |
| [`ARGPARSER_ARG_DELIMITER_1`](environment_variables.md#6511-argparser_arg_delimiter_1)                     | *char*     | `"\|"`[^18]              |
| [`ARGPARSER_ARG_DELIMITER_2`](environment_variables.md#6512-argparser_arg_delimiter_2)                     | *char*     | `","`[^18]               |
| [`ARGPARSER_ARGPARSER_VERSION`](environment_variables.md#6513-argparser_argparser_version)                 | *str*      | *None* (unset)           |
| [`ARGPARSER_ARGS`](environment_variables.md#6514-argparser_args)                                           | *arr*      | *None* (unset)           |
| [`ARGPARSER_CHECK_ARG_DEF`](environment_variables.md#6515-argparser_check_arg_def)                         | *bool*     | `false`                  |
| [`ARGPARSER_CHECK_ENV_VARS`](environment_variables.md#6516-argparser_check_env_vars)                       | *bool*     | `false`                  |
| [`ARGPARSER_CONFIG_FILE`](environment_variables.md#6517-argparser_config_file)                             | *file*     | `""`                     |
| [`ARGPARSER_COUNT_FLAGS`](environment_variables.md#6518-argparser_count_flags)                             | *bool*     | `false`                  |
| [`ARGPARSER_DICTIONARY`](environment_variables.md#6519-argparser_dictionary)                               | *dict*     | *None* (unset)           |
| [`ARGPARSER_ERROR_EXIT_CODE`](environment_variables.md#6520-argparser_error_exit_code)                     | *int*      | `1`                      |
| [`ARGPARSER_ERROR_STYLE`](environment_variables.md#6521-argparser_error_style)                             | *str*      | `"red,bold,reverse"`     |
| [`ARGPARSER_HELP_EXIT_CODE`](environment_variables.md#6523-argparser_help_exit_code)                       | *int*      | `0`                      |
| [`ARGPARSER_HELP_ARG_GROUP`](environment_variables.md#6522-argparser_help_arg_group)                       | *str*      | `"Help options"`         |
| [`ARGPARSER_HELP_FILE`](environment_variables.md#6524-argparser_help_file)                                 | *file*     | `""`                     |
| [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables.md#6525-argparser_help_file_include_char)       | *char*     | `"@"`                    |
| [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](environment_variables.md#6526-argparser_help_file_keep_comments)     | *bool*     | `false`                  |
| [`ARGPARSER_HELP_OPTIONS`](environment_variables.md#6527-argparser_help_options)                           | *char*     | `"h,?"`                  |
| [`ARGPARSER_HELP_STYLE`](environment_variables.md#6528-argparser_help_style)                               | *str*      | `"italic"`               |
| [`ARGPARSER_LANGUAGE`](environment_variables.md#6529-argparser_language)                                   | *str*      | `"en"`                   |
| [`ARGPARSER_MAX_COL_WIDTH_1`](environment_variables.md#6530-argparser_max_col_width_1)                     | *uint*     | `5`[^19]                 |
| [`ARGPARSER_MAX_COL_WIDTH_2`](environment_variables.md#6531-argparser_max_col_width_2)                     | *uint*     | `33`[^19]                |
| [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables.md#6532-argparser_max_col_width_3)                     | *uint*     | `0`[^19]                 |
| [`ARGPARSER_MAX_WIDTH`](environment_variables.md#6533-argparser_max_width)                                 | *uint*     | `79`                     |
| [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables.md#6534-argparser_positional_arg_group)           | *str*      | `"Positional arguments"` |
| [`ARGPARSER_READ_ARGS`](environment_variables.md#6535-argparser_read_args)                                 | *bool*     | `true`                   |
| [`ARGPARSER_SCRIPT_ARGS`](environment_variables.md#6536-argparser_script_args)                             | *arr*      | *None* (unset)           |
| [`ARGPARSER_SCRIPT_NAME`](environment_variables.md#6537-argparser_script_name)                             | *str*      | `"${0##*/}"`             |
| [`ARGPARSER_SET_ARGS`](environment_variables.md#6538-argparser_set_args)                                   | *bool*     | `true`                   |
| [`ARGPARSER_SET_ARRAYS`](environment_variables.md#6539-argparser_set_arrays)                               | *bool*     | `true`                   |
| [`ARGPARSER_SILENCE_ERRORS`](environment_variables.md#6540-argparser_silence_errors)                       | *bool*     | `false`                  |
| [`ARGPARSER_SILENCE_WARNINGS`](environment_variables.md#6541-argparser_silence_warnings)                   | *bool*     | `false`                  |
| [`ARGPARSER_TRANSLATION_FILE`](environment_variables.md#6542-argparser_translation_file)                   | *file*     | `""`                     |
| [`ARGPARSER_UNSET_ARGS`](environment_variables.md#6543-argparser_unset_args)                               | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_ENV_VARS`](environment_variables.md#6544-argparser_unset_env_vars)                       | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_FUNCTIONS`](environment_variables.md#6545-argparser_unset_functions)                     | *bool*     | `true`                   |
| [`ARGPARSER_USAGE_EXIT_CODE`](environment_variables.md#6546-argparser_usage_exit_code)                     | *int*      | `0`                      |
| [`ARGPARSER_USAGE_FILE`](environment_variables.md#6547-argparser_usage_file)                               | *file*     | `""`                     |
| [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables.md#6548-argparser_usage_file_include_char)     | *char*     | `"@"`                    |
| [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](environment_variables.md#6549-argparser_usage_file_keep_comments)   | *bool*     | `false`                  |
| [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](environment_variables.md#6550-argparser_usage_message_option_type) | *str*      | `"short"`                |
| [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](environment_variables.md#6551-argparser_usage_message_orientation) | *str*      | `"row"`                  |
| [`ARGPARSER_USAGE_OPTIONS`](environment_variables.md#6552-argparser_usage_options)                         | *char*     | `"u"`                    |
| [`ARGPARSER_USAGE_STYLE`](environment_variables.md#6553-argparser_usage_style)                             | *str*      | `"italic"`               |
| [`ARGPARSER_USE_LONG_OPTIONS`](environment_variables.md#6554-argparser_use_long_options)                   | *bool*     | `true`                   |
| [`ARGPARSER_USE_SHORT_OPTIONS`](environment_variables.md#6555-argparser_use_short_options)                 | *bool*     | `true`                   |
| [`ARGPARSER_USE_STYLES_IN_FILES`](environment_variables.md#6556-argparser_use_styles_in_files)             | *bool*     | `false`                  |
| [`ARGPARSER_VERSION`](environment_variables.md#6557-argparser_version)                                     | *str*      | `"1.0.0"`                |
| [`ARGPARSER_VERSION_EXIT_CODE`](environment_variables.md#6558-argparser_version_exit_code)                 | *int*      | `0`                      |
| [`ARGPARSER_VERSION_OPTIONS`](environment_variables.md#6559-argparser_version_options)                     | *char*     | `"V"`                    |
| [`ARGPARSER_VERSION_STYLE`](environment_variables.md#6560-argparser_version_style)                         | *str*      | `"bold"`                 |
| [`ARGPARSER_WARNING_STYLE`](environment_variables.md#6561-argparser_warning_style)                         | *str*      | `"red,bold"`             |
| [`ARGPARSER_WRITE_ARGS`](environment_variables.md#6562-argparser_write_args)                               | *bool*     | `false`                  |

[^14]: Bash is weakly typed, hence the denoted types are just a guidance.
[^15]: Strings can optionally be enclosed by quotes.
[^16]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^17]: In fact, any legit Bash variable identifier.
[^18]: Values must be different from each other.
[^19]: Sum of values is recommended to be 77.

[&#129092;&nbsp;`toc.md`](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`environment_variables.md`&nbsp;&#129094;](environment_variables.md)
