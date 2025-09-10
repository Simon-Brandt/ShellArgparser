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

<!-- <toc title="Table of contents (Environment variables)"> -->
#### Table of contents (Environment variables)

1. [Overview](overview.md#941-overview)
1. [`ARGPARSER_ADD_HELP`](environment_variables.md#942-argparser_add_help)
1. [`ARGPARSER_ADD_USAGE`](environment_variables.md#943-argparser_add_usage)
1. [`ARGPARSER_ADD_VERSION`](environment_variables.md#944-argparser_add_version)
1. [`ARGPARSER_ALLOW_FLAG_INVERSION`](environment_variables.md#945-argparser_allow_flag_inversion)
1. [`ARGPARSER_ALLOW_FLAG_NEGATION`](environment_variables.md#946-argparser_allow_flag_negation)
1. [`ARGPARSER_ALLOW_OPTION_ABBREVIATION`](environment_variables.md#947-argparser_allow_option_abbreviation)
1. [`ARGPARSER_ALLOW_OPTION_MERGING`](environment_variables.md#948-argparser_allow_option_merging)
1. [`ARGPARSER_ARG_ARRAY_NAME`](environment_variables.md#949-argparser_arg_array_name)
1. [`ARGPARSER_ARG_DEF_FILE`](environment_variables.md#9410-argparser_arg_def_file)
1. [`ARGPARSER_ARG_DELIMITER_1`](environment_variables.md#9411-argparser_arg_delimiter_1)
1. [`ARGPARSER_ARG_DELIMITER_2`](environment_variables.md#9412-argparser_arg_delimiter_2)
1. [`ARGPARSER_ARGS`](environment_variables.md#9413-argparser_args)
1. [`ARGPARSER_CHECK_ARG_DEF`](environment_variables.md#9414-argparser_check_arg_def)
1. [`ARGPARSER_CHECK_ENV_VARS`](environment_variables.md#9415-argparser_check_env_vars)
1. [`ARGPARSER_CONFIG_FILE`](environment_variables.md#9416-argparser_config_file)
1. [`ARGPARSER_COUNT_FLAGS`](environment_variables.md#9417-argparser_count_flags)
1. [`ARGPARSER_CREATE_ARG_DEF`](environment_variables.md#9418-argparser_create_arg_def)
1. [`ARGPARSER_DEBUG`](environment_variables.md#9419-argparser_debug)
1. [`ARGPARSER_ERROR_EXIT_CODE`](environment_variables.md#9420-argparser_error_exit_code)
1. [`ARGPARSER_ERROR_STYLE`](environment_variables.md#9421-argparser_error_style)
1. [`ARGPARSER_HELP_ARG_GROUP`](environment_variables.md#9422-argparser_help_arg_group)
1. [`ARGPARSER_HELP_DESCRIPTION`](environment_variables.md#9423-argparser_help_description)
1. [`ARGPARSER_HELP_EXIT_CODE`](environment_variables.md#9424-argparser_help_exit_code)
1. [`ARGPARSER_HELP_FILE`](environment_variables.md#9425-argparser_help_file)
1. [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables.md#9426-argparser_help_file_include_char)
1. [`ARGPARSER_HELP_FILE_KEEP_COMMENTS`](environment_variables.md#9427-argparser_help_file_keep_comments)
1. [`ARGPARSER_HELP_OPTIONS`](environment_variables.md#9428-argparser_help_options)
1. [`ARGPARSER_HELP_STYLE`](environment_variables.md#9429-argparser_help_style)
1. [`ARGPARSER_LANGUAGE`](environment_variables.md#9430-argparser_language)
1. [`ARGPARSER_MAX_COL_WIDTH_1`](environment_variables.md#9431-argparser_max_col_width_1)
1. [`ARGPARSER_MAX_COL_WIDTH_2`](environment_variables.md#9432-argparser_max_col_width_2)
1. [`ARGPARSER_MAX_COL_WIDTH_3`](environment_variables.md#9433-argparser_max_col_width_3)
1. [`ARGPARSER_MAX_WIDTH`](environment_variables.md#9434-argparser_max_width)
1. [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables.md#9435-argparser_positional_arg_group)
1. [`ARGPARSER_READ_ARGS`](environment_variables.md#9436-argparser_read_args)
1. [`ARGPARSER_SCRIPT_NAME`](environment_variables.md#9437-argparser_script_name)
1. [`ARGPARSER_SET_ARGS`](environment_variables.md#9438-argparser_set_args)
1. [`ARGPARSER_SET_ARRAYS`](environment_variables.md#9439-argparser_set_arrays)
1. [`ARGPARSER_SILENCE_ERRORS`](environment_variables.md#9440-argparser_silence_errors)
1. [`ARGPARSER_SILENCE_WARNINGS`](environment_variables.md#9441-argparser_silence_warnings)
1. [`ARGPARSER_TRANSLATION_FILE`](environment_variables.md#9442-argparser_translation_file)
1. [`ARGPARSER_UNSET_ARGS`](environment_variables.md#9443-argparser_unset_args)
1. [`ARGPARSER_UNSET_ENV_VARS`](environment_variables.md#9444-argparser_unset_env_vars)
1. [`ARGPARSER_UNSET_FUNCTIONS`](environment_variables.md#9445-argparser_unset_functions)
1. [`ARGPARSER_USAGE_EXIT_CODE`](environment_variables.md#9446-argparser_usage_exit_code)
1. [`ARGPARSER_USAGE_FILE`](environment_variables.md#9447-argparser_usage_file)
1. [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables.md#9448-argparser_usage_file_include_char)
1. [`ARGPARSER_USAGE_FILE_KEEP_COMMENTS`](environment_variables.md#9449-argparser_usage_file_keep_comments)
1. [`ARGPARSER_USAGE_MESSAGE_OPTION_TYPE`](environment_variables.md#9450-argparser_usage_message_option_type)
1. [`ARGPARSER_USAGE_MESSAGE_ORIENTATION`](environment_variables.md#9451-argparser_usage_message_orientation)
1. [`ARGPARSER_USAGE_OPTIONS`](environment_variables.md#9452-argparser_usage_options)
1. [`ARGPARSER_USAGE_STYLE`](environment_variables.md#9453-argparser_usage_style)
1. [`ARGPARSER_USE_LONG_OPTIONS`](environment_variables.md#9454-argparser_use_long_options)
1. [`ARGPARSER_USE_SHORT_OPTIONS`](environment_variables.md#9455-argparser_use_short_options)
1. [`ARGPARSER_USE_STYLES_IN_FILES`](environment_variables.md#9456-argparser_use_styles_in_files)
1. [`ARGPARSER_VERSION_EXIT_CODE`](environment_variables.md#9457-argparser_version_exit_code)
1. [`ARGPARSER_VERSION_NUMBER`](environment_variables.md#9458-argparser_version_number)
1. [`ARGPARSER_VERSION_OPTIONS`](environment_variables.md#9459-argparser_version_options)
1. [`ARGPARSER_VERSION_STYLE`](environment_variables.md#9460-argparser_version_style)
1. [`ARGPARSER_WARNING_STYLE`](environment_variables.md#9461-argparser_warning_style)
1. [`ARGPARSER_WRITE_ARGS`](environment_variables.md#9462-argparser_write_args)
<!-- </toc> -->

[&#129092;&nbsp;9.4. Environment variables](introduction.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9.4.1. Overview&nbsp;&#129094;](overview.md)
