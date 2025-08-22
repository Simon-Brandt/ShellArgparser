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

#### 9.4.1. Overview

The following table shall give a brief overview over the expected data types and the default values for the Argparser's environment variables.

Note that [`ARGPARSER_ARGS`](environment_variables.md#9413-argparser_args) is for internal usage only and thus locally declared. It is *not* part of the Argparser's command line, but listed here for reference, like when you erroneously have it set in a configuration file. Its default value is seen as implementation detail and thus shown as *"None"* here.

<!-- <table caption="Overview over the Argparser environment variables"> -->
*Tab. 8: Overview over the Argparser environment variables.*

| Variable name                                                                      | Type[^14]  | Default value[^15][^16]  |
| ---------------------------------------------------------------------------------- | ---------- | ------------------------ |
| [`ARGPARSER_ADD_HELP`](environment_variables.md#942-argparser_add_help)                                    | *bool*     | `true`                   |
| [`ARGPARSER_ADD_USAGE`](environment_variables.md#943-argparser_add_usage)                                  | *bool*     | `true`                   |
| [`ARGPARSER_ADD_VERSION`](environment_variables.md#944-argparser_add_version)                              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_INVERSION`](environment_variables.md#945-argparser_allow_flag_inversion)            | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_FLAG_NEGATION`](environment_variables.md#946-argparser_allow_flag_negation)              | *bool*     | `true`                   |
| [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](environment_variables.md#947-argparser_allow_option_abbreviation)  | *bool*     | `false`                  |
| [`ARGPARSER_ALLOW_OPTION_MERGING`](environment_variables.md#948-argparser_allow_option_merging)            | *bool*     | `false`                  |
| [`ARGPARSER_ARG_ARRAY_NAME`](environment_variables.md#949-argparser_arg_array_name)                        | *str*[^17] | `"args"`                 |
| [`ARGPARSER_ARG_DEF_FILE`](environment_variables.md#9410-argparser_arg_def_file)                           | *file*     | `""`                     |
| [`ARGPARSER_ARG_DELIMITER_1`](environment_variables.md#9411-argparser_arg_delimiter_1)                     | *char*     | `"\|"`[^18]              |
| [`ARGPARSER_ARG_DELIMITER_2`](environment_variables.md#9412-argparser_arg_delimiter_2)                     | *char*     | `","`[^18]               |
| [`ARGPARSER_ARGS`](environment_variables.md#9413-argparser_args)                                           | *arr*      | *None* (unset)           |
| [`ARGPARSER_CHECK_ARG_DEF`](environment_variables.md#9414-argparser_check_arg_def)                         | *bool*     | `false`                  |
| [`ARGPARSER_CHECK_ENV_VARS`](environment_variables.md#9415-argparser_check_env_vars)                       | *bool*     | `false`                  |
| [`ARGPARSER_CONFIG_FILE`](environment_variables.md#9416-argparser_config_file)                             | *file*     | `""`                     |
| [`ARGPARSER_COUNT_FLAGS`](environment_variables.md#9417-argparser_count_flags)                             | *bool*     | `false`                  |
| [`ARGPARSER_ERROR_EXIT_CODE`](environment_variables.md#9418-argparser_error_exit_code)                     | *int*      | `1`                      |
| [`ARGPARSER_ERROR_STYLE`](environment_variables.md#9419-argparser_error_style)                             | *str*      | `"red,bold,reverse"`     |
| [`ARGPARSER_HELP_EXIT_CODE`](environment_variables.md#9422-argparser_help_exit_code)                       | *int*      | `0`                      |
| [`ARGPARSER_HELP_ARG_GROUP`](environment_variables.md#9420-argparser_help_arg_group)                       | *str*      | `"Help options"`         |
| [`ARGPARSER_HELP_FILE`](environment_variables.md#9423-argparser_help_file)                                 | *file*     | `""`                     |
| [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables.md#9424-argparser_help_file_include_char)       | *char*     | `"@"`                    |
| [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](environment_variables.md#9425-argparser_help_file_keep_comments)     | *bool*     | `false`                  |
| [`ARGPARSER_HELP_OPTIONS`](environment_variables.md#9426-argparser_help_options)                           | *char*     | `"h,?"`                  |
| [`ARGPARSER_HELP_STYLE`](environment_variables.md#9427-argparser_help_style)                               | *str*      | `"italic"`               |
| [`ARGPARSER_LANGUAGE`](environment_variables.md#9428-argparser_language)                                   | *str*      | `"en"`                   |
| [`ARGPARSER_MAX_COL_WIDTH_1`](environment_variables.md#9429-argparser_max_col_width_1)                     | *uint*     | `9`[^19]                 |
| [`ARGPARSER_MAX_COL_WIDTH_2`](environment_variables.md#9430-argparser_max_col_width_2)                     | *uint*     | `33`[^19]                |
| [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables.md#9431-argparser_max_col_width_3)                     | *uint*     | `0`[^19]                 |
| [`ARGPARSER_MAX_WIDTH`](environment_variables.md#9432-argparser_max_width)                                 | *uint*     | `79`                     |
| [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables.md#9433-argparser_positional_arg_group)           | *str*      | `"Positional arguments"` |
| [`ARGPARSER_READ_ARGS`](environment_variables.md#9434-argparser_read_args)                                 | *bool*     | `true`                   |
| [`ARGPARSER_SCRIPT_NAME`](environment_variables.md#9435-argparser_script_name)                             | *str*      | `"${0##*/}"`             |
| [`ARGPARSER_SET_ARGS`](environment_variables.md#9436-argparser_set_args)                                   | *bool*     | `true`                   |
| [`ARGPARSER_SET_ARRAYS`](environment_variables.md#9437-argparser_set_arrays)                               | *bool*     | `true`                   |
| [`ARGPARSER_SILENCE_ERRORS`](environment_variables.md#9438-argparser_silence_errors)                       | *bool*     | `false`                  |
| [`ARGPARSER_SILENCE_WARNINGS`](environment_variables.md#9439-argparser_silence_warnings)                   | *bool*     | `false`                  |
| [`ARGPARSER_TRANSLATION_FILE`](environment_variables.md#9440-argparser_translation_file)                   | *file*     | `""`                     |
| [`ARGPARSER_UNSET_ARGS`](environment_variables.md#9441-argparser_unset_args)                               | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_ENV_VARS`](environment_variables.md#9442-argparser_unset_env_vars)                       | *bool*     | `true`                   |
| [`ARGPARSER_UNSET_FUNCTIONS`](environment_variables.md#9443-argparser_unset_functions)                     | *bool*     | `true`                   |
| [`ARGPARSER_USAGE_EXIT_CODE`](environment_variables.md#9444-argparser_usage_exit_code)                     | *int*      | `0`                      |
| [`ARGPARSER_USAGE_FILE`](environment_variables.md#9445-argparser_usage_file)                               | *file*     | `""`                     |
| [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables.md#9446-argparser_usage_file_include_char)     | *char*     | `"@"`                    |
| [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](environment_variables.md#9447-argparser_usage_file_keep_comments)   | *bool*     | `false`                  |
| [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](environment_variables.md#9448-argparser_usage_message_option_type) | *str*      | `"short"`                |
| [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](environment_variables.md#9449-argparser_usage_message_orientation) | *str*      | `"row"`                  |
| [`ARGPARSER_USAGE_OPTIONS`](environment_variables.md#9450-argparser_usage_options)                         | *char*     | `"u"`                    |
| [`ARGPARSER_USAGE_STYLE`](environment_variables.md#9451-argparser_usage_style)                             | *str*      | `"italic"`               |
| [`ARGPARSER_USE_LONG_OPTIONS`](environment_variables.md#9452-argparser_use_long_options)                   | *bool*     | `true`                   |
| [`ARGPARSER_USE_SHORT_OPTIONS`](environment_variables.md#9453-argparser_use_short_options)                 | *bool*     | `true`                   |
| [`ARGPARSER_USE_STYLES_IN_FILES`](environment_variables.md#9454-argparser_use_styles_in_files)             | *bool*     | `false`                  |
| [`ARGPARSER_VERSION_EXIT_CODE`](environment_variables.md#9455-argparser_version_exit_code)                 | *int*      | `0`                      |
| [`ARGPARSER_VERSION_NUMBER`](environment_variables.md#9456-argparser_version_number)                       | *str*      | `"1.0.0"`                |
| [`ARGPARSER_VERSION_OPTIONS`](environment_variables.md#9457-argparser_version_options)                     | *char*     | `"V"`                    |
| [`ARGPARSER_VERSION_STYLE`](environment_variables.md#9458-argparser_version_style)                         | *str*      | `"bold"`                 |
| [`ARGPARSER_WARNING_STYLE`](environment_variables.md#9459-argparser_warning_style)                         | *str*      | `"red,bold"`             |
| [`ARGPARSER_WRITE_ARGS`](environment_variables.md#9460-argparser_write_args)                               | *bool*     | `false`                  |

[^14]: Bash is weakly typed, hence the denoted types are just a guidance.
[^15]: Strings can optionally be enclosed by quotes.
[^16]: Bools must be lowercase, *i.e.*, `true` or `false`.
[^17]: In fact, any legit Bash variable identifier.
[^18]: Values must be different from each other.
[^19]: Sum of values is recommended to be 77, except when [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables.md#9431-argparser_max_col_width_3) is `0`.

[&#129092;&nbsp;Table of contents (Environment variables)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9.4.2. `ARGPARSER_ADD_HELP`&nbsp;&#129094;](environment_variables.md)
