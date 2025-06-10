### 6.3. Include directives

Six section names (include directives) are supported in the help and usage files. These are introduced with the [`ARGPARSER_HELP_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#6525-argparser_help_file_include_char) or [`ARGPARSER_USAGE_FILE_INCLUDE_CHAR`](environment_variables/environment_variables.md#6548-argparser_usage_file_include_char), respectively, defaulting to `"@"`.

<!-- <toc title="Table of contents (Include directives)"> -->
#### Table of contents (Include directives)

1. [`@All` directive](#631-all-directive)
1. [`@<ArgumentGroup>` directive](#632-argumentgroup-directive)
1. [`@Header` directive](#633-header-directive)
1. [`@Remark` directive](#634-remark-directive)
1. [`@Usage` directive](#635-usage-directive)
1. [`@Help` directive](#636-help-directive)
<!-- </toc> -->

#### 6.3.1. `@All` directive

The `@All` directive comprises all include directives in the following order: [`@Usage`](#635-usage-directive), [`@Remark`](#634-remark-directive), [`@<ArgumentGroup>`](#632-argumentgroup-directive), and [`@Help`](#636-help-directive), separated from each other by a blank line.

Consequently, the help message generated from the [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#6524-argparser_help_file) with the following content:

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

#### 6.3.2. `@<ArgumentGroup>` directive

The `@<ArgumentGroup>` directive prints the help text for the respective `"<ArgumentGroup>"`, like `"Mandatory options"` for the include directive `@Mandatory options` or `"Optional options"` for the include directive `@Optional options`. Their order in the auto-generated help message would be alphabetical for the keyword arguments, preceded by the group for the positional arguments (the [`ARGPARSER_POSITIONAL_ARG_GROUP`](environment_variables/environment_variables.md#6534-argparser_positional_arg_group)). Thus, if you have reasons for another structure, you need an [`ARGPARSER_HELP_FILE`](environment_variables/environment_variables.md#6524-argparser_help_file), denoting all arguments groups in the order preferred by you.

#### 6.3.3. `@Header` directive

The `@Header` directive comprises the [`@Usage`](#635-usage-directive) and [`@Remark`](#634-remark-directive) include directive, separated from each other by a blank line, and is thus the shorthand for including both.

#### 6.3.4. `@Remark` directive

The `@Remark` directive prints the note that mandatory arguments to long options are mandatory for short options too. This should be given just before all arguments.

#### 6.3.5. `@Usage` directive

The `@Usage` directive prints the line `Usage: <script_name> ...`, with `<script_name>` replaced by [`ARGPARSER_SCRIPT_NAME`](environment_variables/environment_variables.md#6537-argparser_script_name), defaulting to your script's name. This should be given as first line.

#### 6.3.6. `@Help` directive

The `@Help` directive prints the help text for the `--help`, `--usage`, and `--version` flags (if added to the arguments definition by [`ARGPARSER_ADD_HELP`](environment_variables/environment_variables.md#652-argparser_add_help), [`ARGPARSER_ADD_USAGE`](environment_variables/environment_variables.md#653-argparser_add_usage), or [`ARGPARSER_ADD_VERSION`](environment_variables/environment_variables.md#654-argparser_add_version)). Usually, you want to give this at the very end of all options.

[&#129092;&nbsp;`colors_and_styles.md`](colors_and_styles.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`translations/introduction.md`&nbsp;&#129094;](translations/introduction.md)
