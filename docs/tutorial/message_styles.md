<!--
###############################################################################
#                                                                             #
# Copyright 2025-2026 Simon Brandt                                            #
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

It is possible to customize the appearance of help, usage, version, error, and warning messages using a dedicated style file, given as [`ARGPARSER_STYLE_FILE`](../reference/environment_variables/environment_variables.md#9444-argparser_style_file), with the same format as the [configuration file](argparser_configuration.md#531-configuration-file). The usage of the legacy and less powerful environment variables, *viz.* [`ARGPARSER_HELP_STYLE`](../reference/environment_variables/environment_variables.md#9431-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](../reference/environment_variables/environment_variables.md#9456-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](../reference/environment_variables/environment_variables.md#9466-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](../reference/environment_variables/environment_variables.md#9422-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](../reference/environment_variables/environment_variables.md#9467-argparser_warning_style), is considered deprecated and will be disabled in `v2.0.0`.

The colorization and stylization of the messages works by using [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters"). Employing colors is especially useful to quickly see errors when logging, but requires that the terminal or text editor, with which you opened the log file, supports interpreting the escape codes. This is, *e.g.*, supported by [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"). Thereby, when [`ARGPARSER_USE_STYLES`](../reference/environment_variables/environment_variables.md#9460-argparser_use_styles) is set to `"tty"` (the default), the escape sequences are only output when `STDOUT`/`STDERR` is a terminal, not a file. The value `"never"` deactivates the styles even for terminals&mdash;whereas `"always"` activates them for both, and `"file"` only for files, not terminals.

To adhere to the informal [no-color](https://no-color.org/ "no-color.org") and [force-color standards](https://force-color.org/ "force-color.org"), the Argparser supports the `NO_COLOR` and `FORCE_COLOR` environment variables (as special values to [`ARGPARSER_USE_COLORS`](../reference/environment_variables/environment_variables.md#9457-argparser_use_colors)). If given, and not set to the empty string, you can globally disable/enable ANSI colorization in any software supporting the standard, including the Argparser. You can then selectively re-enable colorization for the Argparser using `ARGPARSER_USE_COLORS=true`, provided you set `ARGPARSER_USE_STYLES={always,file,tty}`. Thereby, if `ARGPARSER_USE_COLORS` is given in the environment, including its occurrence on the command line or in a configuration file, it unconditionally overrides both `NO_COLOR` and `FORCE_COLOR`, in line with the standard. This allows instructing no software to use colors, except the Argparser, if wanted. Additionally, `NO_COLOR` overrides `FORCE_COLOR`, should you happen to have set conflicting options in your environment.

The available colors and styles offer a detailled way of customizing the look of messages. Besides being possible to colorize and stylize the actual text of the messages, the usage, version, error and warning messages, as well as the argument groups in help messages, can be surrounded by frames, serving as visual grouping to blocks. These frame styles use characters from the [Unicode Box Drawing block](https://en.wikipedia.org/wiki/Box_Drawing "wikipedia.org &rightarrow; Box Drawing"). For maximum compatibility with output devices, the Argparser currently does not use these Unicode frames by default, but ASCII frames. You have to opt into the Unicode frames by setting [`ARGPARSER_USE_UNICODE`](../reference/environment_variables/environment_variables.md#9462-argparser_use_unicode) to `true`, or use an `ARGPARSER_STYLE_FILE`.

The following colors and styles are available (with the actual appearance depending on the output device):

<!-- <table caption="Available colors and styles"> -->
*Tab. 2: Available colors and styles.*

| Colors                                  | Text styles   | Frame styles       |
| --------------------------------------- | ------------- | ------------------ |
| $\small\textsf{\color{black}black}$     | `normal`      | `ASCII`            |
| $\small\textsf{\color{red}red}$         | `bold`        | `angular`          |
| $\small\textsf{\color{green}green}$     | `faint`       | `rounded`          |
| $\small\textsf{\color{orange}yellow}$   | `italic`      | `double`           |
| $\small\textsf{\color{blue}blue}$       | `underline`   | `solid`            |
| $\small\textsf{\color{magenta}magenta}$ | `double`      | `double-dashed`    |
| $\small\textsf{\color{cyan}cyan}$       | `overline`    | `triple-dashed`    |
| $\small\textsf{\color{lightgray}white}$ | `crossed-out` | `quadruple-dashed` |
|                                         | `blink`       | `thin`             |
|                                         | `reverse`     | `thick`            |
|                                         |               | `double`           |

Colors overwrite each other, whereas styles may be combined, like `"red,bold,reverse"` as default value for error message captions, or `"red,rounded"` for error message frames in the template [`styles.cfg`](../../resources/styles.cfg). Text styles may be given in any order, while frame styles are only in part compatible (*e.g.*, there is no way to specify thick, rounded corners since Unicode lacks characters for them); for colors, the last one is effectively visible. Still, the escape codes are concatenated in their order of definition in the style setting.

You can prefix color names with `bright_` to obtain the bright ANSI colors, and suffix them with `_fg` or `_bg` to use them as either a foreground or background color. Without suffix, the color is used as foreground color. Be wary, however, that not all terminals support bright or background colors and may use substitute colors or ignore the escape sequences. Thus, the Argparser does not, and will never, use these extensions by default, only the eight classic ANSI foreground colors.

For the default values currently in use, refer to the [reference](../reference/colors_and_styles.md#92-colors-and-styles). You may also want to have a look at the template [`styles.cfg`](../../resources/styles.cfg), where frames are employed.

[&#129092;&nbsp;5.9. Error and warning messages](error_and_warning_messages.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.11. Standalone usage&nbsp;&#129094;](standalone_usage.md)
