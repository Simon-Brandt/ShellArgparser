### 4.8. Version messages

Besides the the [`ARGPARSER_HELP_OPTIONS`](../reference/environment_variables/environment_variables.md#8527-argparser_help_options), `--help`, the [`ARGPARSER_USAGE_OPTIONS`](../reference/environment_variables/environment_variables.md#8552-argparser_usage_options), and `--usage`, there is a third option intended to help the user, the [`ARGPARSER_VERSION_OPTIONS`](../reference/environment_variables/environment_variables.md#8559-argparser_version_options) (default: `-V`) and `--version`. This flag compiles a brief version message for your script, showing its canonical name (the [`ARGPARSER_SCRIPT_NAME`](../reference/environment_variables/environment_variables.md#8537-argparser_script_name)) and the version number (the [`ARGPARSER_VERSION`](../reference/environment_variables/environment_variables.md#8557-argparser_version)). Just as for the help and usage messages, you can disable the version message (and its corresponding flags) by setting [`ARGPARSER_ADD_VERSION`](../reference/environment_variables/environment_variables.md#854-argparser_add_version) to `false`. Note that the default short option name is an uppercase `V`, such that you can use the lowercase `v` (as `-v`) for your purposes, like `--verbatim` or `--verbose`. This is in line with the common behavior of command-line programs. By setting `ARGPARSER_VERSION_OPTIONS` accordingly, you can of course change it to your needs, if desired.

The output version message is very simple:

<!-- <include command="bash ../tutorial/try_argparser.sh -V" lang="console"> -->
```console
$ bash ../tutorial/try_argparser.sh -V
try_argparser.sh v1.0.0
```
<!-- </include> -->

[&#129092;&nbsp;4.7. Help and usage message localization](help_and_usage_message_localization.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.9. Error and warning messages&nbsp;&#129094;](error_and_warning_messages.md)
