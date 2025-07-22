### 8.3. Include directives

Six section names (include directives) are supported in the help files, and one (`@All`) in the usage files. These are introduced with the [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#8426-argparser_help_file_include_char) or [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#8449-argparser_usage_file_include_char), respectively, defaulting to `"@"`.

<!-- <toc title="Table of contents (Include directives)"> -->
#### Table of contents (Include directives)

1. [`@All` directive](#831-all-directive)
1. [`@<ArgumentGroup>` directive](#832-argumentgroup-directive)
1. [`@Description` directive](#833-description-directive)
1. [`@Header` directive](#834-header-directive)
1. [`@Help` directive](#835-help-directive)
1. [`@Remark` directive](#836-remark-directive)
1. [`@Usage` directive](#837-usage-directive)
<!-- </toc> -->

#### 8.3.1. `@All` directive

For help messages, the `@All` directive comprises all include directives in the following order: [`@Usage`](#837-usage-directive), [`@Description`](#833-description-directive), [`@Remark`](#836-remark-directive), [`@<ArgumentGroup>`](#832-argumentgroup-directive), and [`@Help`](#835-help-directive), separated from each other by a blank line.

Consequently, the help message generated from the [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#8425-argparser_help_file) with the following content:

```text
@All
```

is exactly identical to the one from the following content:

```text
@Usage

@Description

@Remark

@<ArgumentGroup>

@Help
```

(note the blank lines), and indentical to the auto-generated help message.

For usage messages, `@All` prints the usual usage message, which currently isn't subdivided into distinct include directives.

#### 8.3.2. `@<ArgumentGroup>` directive

The `@<ArgumentGroup>` directive prints the help message block for the respective `"<ArgumentGroup>"`, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. Their order in the auto-generated help message would be alphabetical for the keyword arguments, preceded by the group for the positional arguments (the [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables/environment_variables.md#8435-argparser_positional_arg_group)). Thus, if you have reasons for another structure, you need an [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#8425-argparser_help_file), denoting all arguments groups in the order preferred by you.

#### 8.3.3. `@Description` directive

The `@Description` directive prints the contents of [`ARGPARSER_HELP_DESCRIPTION`](environment_variables/environment_variables.md#8423-argparser_help_description), wrapped to fit the help message's [`ARGPARSER_MAX_WIDTH`](environment_variables/environment_variables.md#8434-argparser_max_width). If `ARGPARSER_HELP_DESCRIPTION` is empty (the default), nothing is printed.

#### 8.3.4. `@Header` directive

The `@Header` directive comprises the [`@Usage`](#837-usage-directive), [`@Description`](#833-description-directive) and [`@Remark`](#836-remark-directive) include directive, separated from each other by a blank line, and is thus the shorthand for including all three.

#### 8.3.5. `@Help` directive

The `@Help` directive prints the help text for the `--help`, `--usage`, and `--version` flags (if added to the arguments definition by [`ARGPARSER_ADD_HELP`](environment_variables/environment_variables.md#842-argparser_add_help), [`ARGPARSER_ADD_USAGE`](environment_variables/environment_variables.md#843-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](environment_variables/environment_variables.md#844-argparser_add_version)). Usually, you want to give this at the very end of all options.

#### 8.3.6. `@Remark` directive

The `@Remark` directive prints the note that mandatory arguments to long options are mandatory for short options too. This should be given just before all arguments.

#### 8.3.7. `@Usage` directive

The `@Usage` directive prints the line `Usage: <script_name> ...`, with `<script_name>` replaced by [`ARGPARSER_SCRIPT_NAME`](environment_variables/environment_variables.md#8438-argparser_script_name), defaulting to your script's name. This should be given as first line.

[&#129092;&nbsp;8.2. Colors and styles](colors_and_styles.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[8.4. Environment variables&nbsp;&#129094;](environment_variables/introduction.md)
