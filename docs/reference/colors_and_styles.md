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

### 9.2. Colors and styles

The Argparser employs [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters") to set the appearance of help, usage, version, error, and warning messages. To this end, you can use an [`ARGPARSER_STYLE_FILE`](environment_variables/environment_variables.md#9443-argparser_style_file) or fall back to the Argparser's default colors and styles. The five environment variables previously used for stylization, *viz.* [`ARGPARSER_HELP_STYLE`](environment_variables/environment_variables.md#9430-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](environment_variables/environment_variables.md#9455-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](environment_variables/environment_variables.md#9463-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](environment_variables/environment_variables.md#9422-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](environment_variables/environment_variables.md#9464-argparser_warning_style), are deprecated and will be removed in `v2.0.0`, in favor of the more fine-grained control the style file offers.

Since the escape codes are nonprintable, not all terminals or text editors may support them. Many terminals do, while *e.g.* [`less`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)") has a dedicated flag, `--raw-control-chars`.

When [`ARGPARSER_USE_STYLES`](environment_variables/environment_variables.md#9458-argparser_use_styles) is set to `"tty"`, the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, keeping files plain 7-bit ASCII for simpler parsing. Note that, when your arguments definition or help file includes non-ASCII characters (as is usual for almost any language other than English varieties), the output contains these characters as well. You can also entirely disable the style inclusion by setting `ARGPARSER_USE_STYLES` to `"never"`, or enable it selectively for files using `"file"` as argument. `"always"`, in turn, activates the styles for both terminals and files.

A number of colors and styles is available. You don't need to remember the SGR codes, they're only internally used and given here for reference of what to expect from the keywords for the colors and styles. Further note that the actual RGB/Hex color values will depend on the output device.

<!-- <table caption="Available colors and their SGR codes"> -->
*Tab. 7: Available colors and their SGR codes.*

| Color                                   | SGR code |
| --------------------------------------- | -------- |
| $\small\textsf{\color{black}black}$     | `30`     |
| $\small\textsf{\color{red}red}$         | `31`     |
| $\small\textsf{\color{green}green}$     | `32`     |
| $\small\textsf{\color{orange}yellow}$   | `33`     |
| $\small\textsf{\color{blue}blue}$       | `34`     |
| $\small\textsf{\color{magenta}magenta}$ | `35`     |
| $\small\textsf{\color{cyan}cyan}$       | `36`     |
| $\small\textsf{\color{lightgray}white}$ | `37`     |

<!-- <table caption="Available styles and their SGR codes"> -->
*Tab. 8: Available styles and their SGR codes.*

| Style         | SGR code |
| ------------- | -------- |
| `normal`      | `22`     |
| `bold`        | `1`      |
| `faint`       | `2`      |
| `italic`      | `3`      |
| `underline`   | `4`      |
| `double`      | `21`     |
| `overline`    | `53`     |
| `crossed-out` | `9`      |
| `blink`       | `5`      |
| `reverse`     | `7`      |

While colors overwrite each other, some styles can be combined. For instance, the default value for error message captions is `"red,bold,reverse"`, meaning to colorize the message in red and to format it in bold font, using reverse video. Other useful combinations may include `"faint"` and `"italic"` or `"bold"` and `"underline"`. The order of giving the colors and styles in the environment variables' values does only matter if multiple colors are given, when the last one "wins". Else, the colors and styles are simply composed (concatenated).

There are a further 24 colors supported, *viz.*, bright and background colors (including bright background colors). By prefixing the color names with `bright_`, you obtain the bright ANSI colors from the 90&ndash;97 range. By suffixing them with `_bg`, you obtain the background colors from the 40&ndash;47 range, and by using both the `bright_` prefix and the `_bg` suffix, you obtain the background colors from the 100&ndash;107 range. The suffix `_fg` is also supported (both with and without `bright_` prefix) and yields the normal foreground colors, just as without specifying a suffix.

Note that not all terminals support bright or background colors and may use substitute colors or ignore the escape sequences. Thus, the Argparser does not, and will never, use these extensions by default, only the eight classic ANSI foreground colors.

Currently, the default values for the styles, and all used message keys, as given in the template [`styles.cfg`](../../resources/styles.cfg), are as follows:
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

[&#129092;&nbsp;9.1. Arguments definition](arguments_definition.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9.3. Include directives&nbsp;&#129094;](include_directives.md)
