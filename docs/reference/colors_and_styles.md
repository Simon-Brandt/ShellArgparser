### 8.2. Colors and styles

The Argparser employs [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters") to set the appearance of error, warning, help, usage, and version messages. To this end, five environment variable are defined, *viz.*, [`ARGPARSER_HELP_STYLE`](environment_variables/environment_variables.md#8528-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](environment_variables/environment_variables.md#8553-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](environment_variables/environment_variables.md#8560-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](environment_variables/environment_variables.md#8521-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](environment_variables/environment_variables.md#8561-argparser_warning_style). Since the escape codes are nonprintable, not any terminal or text editor may support them. Many terminals do, while *e.g.* [`less`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)") has a dedicated flag, `--raw-control-chars`.

When [`ARGPARSER_USE_STYLES_IN_FILES`](environment_variables/environment_variables.md#8556-argparser_use_styles_in_files) is set to `false`, the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, keeping files plain 7-bit ASCII for simpler parsing. Note that, when your arguments definition or help file includes non-ASCII characters (as is usual for almost any language other than English varieties), the output contains these characters as well.

A number of colors and styles is available. You don't need to remember the SGR codes, they're only internally used and given here for reference of what to expect from the keywords for the colors and styles. Further note that the actual RGB/Hex color values will depend on the output device.

<!-- <table caption="Available colors and their SGR codes"> -->
*Tab. 5: Available colors and their SGR codes.*

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
*Tab. 6: Available styles and their SGR codes.*

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

While colors overwrite each other, some styles can be combined. For instance, the default value for `ARGPARSER_ERROR_STYLE` is `"red,bold,reverse"`, meaning to colorize the message in red and to format it in bold font, using reverse video. Other useful combinations may include `"faint"` and `"italic"` or `"bold"` and `"underline"`. The order of giving the colors and styles in the environment variables' values does only matter if multiple colors are given, when the last one "wins". Else, the colors and styles are simply composed (concatenated).

[&#129092;&nbsp;8.1. Arguments definition](arguments_definition.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[8.3. Include directives&nbsp;&#129094;](include_directives.md)
