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

### 5.10. Message styles

It is possible to customize the appearance of help, usage, version, error, and warning messages using a dedicated style file, given as [`ARGPARSER_STYLE_FILE`](../reference/environment_variables/environment_variables.md#9443-argparser_style_file), with the same format as the [configuration file](argparser_configuration.md#531-configuration-file). The usage of the legacy and less powerful environment variables, *viz.* [`ARGPARSER_HELP_STYLE`](../reference/environment_variables/environment_variables.md#9430-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](../reference/environment_variables/environment_variables.md#9455-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](../reference/environment_variables/environment_variables.md#9463-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](../reference/environment_variables/environment_variables.md#9422-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](../reference/environment_variables/environment_variables.md#9464-argparser_warning_style), is considered deprecated and will be disabled in `v2.0.0`.

The colorization and stylization of the messages works by using [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters"). Employing colors is especially useful to quickly see errors when logging, but requires that the terminal or text editor, with which you opened the log file, supports interpreting the escape codes. This is, *e.g.*, supported by [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"). Thereby, when [`ARGPARSER_USE_STYLES`](../reference/environment_variables/environment_variables.md#9458-argparser_use_styles) is set to `"tty"` (the default), the escape sequences are only output when `STDOUT`/`STDERR` is a terminal, not a file. The value `"never"` deactivates the styles even for terminals&mdash;whereas `"always"` activates them for both, and `"file"` only for files, not terminals.

The following colors and styles are available (with the actual appearance depending on the output device):

<!-- <table caption="Available colors and styles"> -->
*Tab. 2: Available colors and styles.*

| Colors                                  | Styles        |
| --------------------------------------- | ------------- |
| $\small\textsf{\color{black}black}$     | `normal`      |
| $\small\textsf{\color{red}red}$         | `bold`        |
| $\small\textsf{\color{green}green}$     | `faint`       |
| $\small\textsf{\color{orange}yellow}$   | `italic`      |
| $\small\textsf{\color{blue}blue}$       | `underline`   |
| $\small\textsf{\color{magenta}magenta}$ | `double`      |
| $\small\textsf{\color{cyan}cyan}$       | `overline`    |
| $\small\textsf{\color{lightgray}white}$ | `crossed-out` |
|                                         | `blink`       |
|                                         | `reverse`     |

Colors overwrite each other, whereas styles may be combined, like `"red,bold,reverse"` as default value for error message captions. Styles may be given in any order; for colors, the last one is effectively visible. Still, the escape codes are concatenated in their order of definition in the style setting.

You can prefix color names with `bright_` to obtain the bright ANSI colors, and suffix them with `_fg` or `_bg` to use them as either a foreground or background color. Without suffix, the color is used as foreground color. Be wary, however, that not all terminals support bright or background colors and may use substitute colors or ignore the escape sequences. Thus, the Argparser does not, and will never, use these extensions by default, only the eight classic ANSI foreground colors.

Currently, the default values, as given in the template [`styles.cfg`](../../resources/styles.cfg), are as follows:
<!-- <include command="tail --lines=+6 ../resources/styles.cfg" lang="console"> -->
```console
$ tail --lines=+6 ../resources/styles.cfg
argument_group_names = "cyan,bold"
choice_values        = "yellow"
default_text         = "italic"
default_values       = "cyan,italic"
deprecation_note     = "red,bold"
description_text     = "italic"
error_caption        = "red,bold,reverse"
error_text           = "red"
help_text            = "normal"
long_options         = "magenta,bold"
remark_text          = "italic"
script_name          = "bold"
short_options        = "green,bold"
usage_caption        = "bold"
value_names          = "blue"
version_string       = "normal"
warning_caption      = "red,bold"
warning_text         = "red"
```
<!-- </include> -->

[&#129092;&nbsp;5.9. Error and warning messages](error_and_warning_messages.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.11. Standalone usage&nbsp;&#129094;](standalone_usage.md)
