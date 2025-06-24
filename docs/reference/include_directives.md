### 7.3. Include directives

Six section names (include directives) are supported in the help and usage files. These are introduced with the [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#7525-argparser_help_file_include_char) or [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#7548-argparser_usage_file_include_char), respectively, defaulting to `"@"`.

<!-- <toc title="Table of contents (Include directives)"> -->
#### Table of contents (Include directives)

1. [`@All` directive](#731-all-directive)
1. [`@<ArgumentGroup>` directive](#732-argumentgroup-directive)
1. [`@Header` directive](#733-header-directive)
1. [`@Remark` directive](#734-remark-directive)
1. [`@Usage` directive](#735-usage-directive)
1. [`@Help` directive](#736-help-directive)
<!-- </toc> -->

#### 7.3.1. `@All` directive

The `@All` directive comprises all include directives in the following order: [`@Usage`](#735-usage-directive), [`@Remark`](#734-remark-directive), [`@<ArgumentGroup>`](#732-argumentgroup-directive), and [`@Help`](#736-help-directive), separated from each other by a blank line.

Consequently, the help message generated from the [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#7524-argparser_help_file) with the following content:

```text
@All
```

is exactly identical to the one from the following content:

```text
@Usage

@Remark

@<ArgumentGroup>

@Help
```

(note the blank lines), and indentical to the auto-generated help message.

#### 7.3.2. `@<ArgumentGroup>` directive

The `@<ArgumentGroup>` directive prints the help text for the respective `"<ArgumentGroup>"`, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. Their order in the auto-generated help message would be alphabetical for the keyword arguments, preceded by the group for the positional arguments (the [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables/environment_variables.md#7534-argparser_positional_arg_group)). Thus, if you have reasons for another structure, you need an [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#7524-argparser_help_file), denoting all arguments groups in the order preferred by you.

#### 7.3.3. `@Header` directive

The `@Header` directive comprises the [`@Usage`](#735-usage-directive) and [`@Remark`](#734-remark-directive) include directive, separated from each other by a blank line, and is thus the shorthand for including both.

#### 7.3.4. `@Remark` directive

The `@Remark` directive prints the note that mandatory arguments to long options are mandatory for short options too. This should be given just before all arguments.

#### 7.3.5. `@Usage` directive

The `@Usage` directive prints the line `Usage: <script_name> ...`, with `<script_name>` replaced by [`ARGPARSER_SCRIPT_NAME`](environment_variables/environment_variables.md#7537-argparser_script_name), defaulting to your script's name. This should be given as first line.

#### 7.3.6. `@Help` directive

The `@Help` directive prints the help text for the `--help`, `--usage`, and `--version` flags (if added to the arguments definition by [`ARGPARSER_ADD_HELP`](environment_variables/environment_variables.md#752-argparser_add_help), [`ARGPARSER_ADD_USAGE`](environment_variables/environment_variables.md#753-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](environment_variables/environment_variables.md#754-argparser_add_version)). Usually, you want to give this at the very end of all options.

[&#129092;&nbsp;`colors_and_styles.md`](colors_and_styles.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`translations/introduction.md`&nbsp;&#129094;](translations/introduction.md)
