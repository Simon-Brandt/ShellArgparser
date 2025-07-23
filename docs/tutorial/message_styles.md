### 4.10. Message styles

It is possible to customize the appearance of help, usage, version, error, and warning messages using the respective environment variable, *viz.* [`ARGPARSER_HELP_STYLE`](../reference/environment_variables/environment_variables.md#8427-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](../reference/environment_variables/environment_variables.md#8451-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](../reference/environment_variables/environment_variables.md#8458-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](../reference/environment_variables/environment_variables.md#8419-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](../reference/environment_variables/environment_variables.md#8459-argparser_warning_style). Using [Select Graphic Rendition (SGR) ANSI escape sequence codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters "wikipedia.org &rightarrow; ANSI escape code &rightarrow; Select Graphic Rendition parameters"), messages can be colorized and stylized. This is especially useful to quickly see errors when logging, but requires that the terminal or text editor, with which you opened the log file, supports interpreting the escape codes. This is, *e.g.*, supported by [`less --raw-control-chars <filename>`](https://man7.org/linux/man-pages/man1/less.1.html "man7.org &rightarrow; man pages &rightarrow; less(1)"). Further, when [`ARGPARSER_USE_STYLES_IN_FILES`](../reference/environment_variables/environment_variables.md#8454-argparser_use_styles_in_files) is set to `false` (the default), the escape sequences are only included when `STDOUT`/`STDERR` is a terminal, not a file.

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

Colors overwrite each other, whereas styles may be combined, like `"red,bold,reverse"` as default value for `ARGPARSER_ERROR_STYLE`. Styles may be given in any order; for colors, the last one is effectively visible. Still, the escape codes are concatenated in their order of definition in the style setting.

[&#129092;&nbsp;4.9. Error and warning messages](error_and_warning_messages.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.11. Standalone usage&nbsp;&#129094;](standalone_usage.md)
