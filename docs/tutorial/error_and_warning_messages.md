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

### 5.9. Error and warning messages

The Argparser outputs about a hundred different error and warning messages to give both you and your script's user as detailled feedback as possible about what went wrong with the argument parsing, value checking, *etc.* Each message starts with your script's canonical name (the [`ARGPARSER_SCRIPT_NAME`](../reference/environment_variables/environment_variables.md#9438-argparser_script_name)), followed by either `"Error:"` or `"Warning:"` and the respective message. Using the same simplified [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") file as for the help and usage messages (the [`ARGPARSER_TRANSLATION_FILE`](../reference/environment_variables/environment_variables.md#9444-argparser_translation_file)), also the error and warning messages can be fully localized.

Generally, errors may lead to abortion of the script, while warnings just write the message to `STDERR`. Thus, warnings are less problematic errors, usually since some default or fallback value can be used, instead. The warning message then informs about this decision. Only for deprecated arguments, no default is used, simply because the Argparser does not use the information about deprecation other than for creating a message to your script's user. After all, a deprecated argument should still be fully functional, until the deprecation time has passed and you decide to fully remove the argument (or replace it by a dummy implementation&mdash;then without deprecation note&mdash;whose application raises an error within your script).

Using [`ARGPARSER_SILENCE_ERRORS`](../reference/environment_variables/environment_variables.md#9441-argparser_silence_errors) and [`ARGPARSER_SILENCE_WARNINGS`](../reference/environment_variables/environment_variables.md#9442-argparser_silence_warnings), it is possible to prevent the emission of error or warning messages. Still, in case of critical errors, the Argparser exits, just not informing you or your user about its failure. Silencing errors may not be needed at all, except when you want to keep log files clean, but silencing warnings may improve the user experience in some cases.

[&#129092;&nbsp;5.8. Version messages](version_messages.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.10. Message styles&nbsp;&#129094;](message_styles.md)
