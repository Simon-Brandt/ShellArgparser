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

### 5.8. Version messages

Besides the [`ARGPARSER_HELP_OPTIONS`](../reference/environment_variables/environment_variables.md#9426-argparser_help_options), `--help`, the [`ARGPARSER_USAGE_OPTIONS`](../reference/environment_variables/environment_variables.md#9450-argparser_usage_options), and `--usage`, there is a third option intended to help the user, the [`ARGPARSER_VERSION_OPTIONS`](../reference/environment_variables/environment_variables.md#9457-argparser_version_options) (default: `-V`) and `--version`. This flag compiles a brief version message for your script, showing its canonical name (the [`ARGPARSER_SCRIPT_NAME`](../reference/environment_variables/environment_variables.md#9435-argparser_script_name)) and the version number (the [`ARGPARSER_VERSION`](../reference/environment_variables/environment_variables.md#9455-argparser_version)). Just as for the help and usage messages, you can disable the version message (and its corresponding flags) by setting [`ARGPARSER_ADD_VERSION`](../reference/environment_variables/environment_variables.md#944-argparser_add_version) to `false`. Note that the default short option name is an uppercase `"V"`, such that you can use the lowercase `"v"` (as `-v`) for your purposes, like `--verbatim` or `--verbose`. This is in line with the common behavior of command-line programs. By setting `ARGPARSER_VERSION_OPTIONS` accordingly, you can of course change it to your needs, if desired.

The output version message is very simple:

<!-- <include command="bash ../tutorial/try_argparser.sh -V" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh -V
try_argparser.sh v1.0.0
```
<!-- </include> -->

[&#129092;&nbsp;5.7. Help and usage message localization](help_and_usage_message_localization.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.9. Error and warning messages&nbsp;&#129094;](error_and_warning_messages.md)
