<!-- <include command="sed 's/^#/##/;s/<toc>/<toc title="Table of contents (Contribution guide)">/' ../CONTRIBUTING.md"> -->
## 8. Contribution guide

You're very welcome to contribute to the Argparser! Be it fixing spelling mistakes or small bugs, adding or clarifying the [documentation](docs), or even adding new functionality to the Argparser itself, any improvement is highly appreciated.

In order to facilitate the seemless integration of your commits with the Argparser codebase, please try to comply with the following guidelines. Most of them are rather irrelevant for small fixes, so you probably would follow them, anyways. If you have reasons *not* to comply, it would likely not mean that your commit can't be merged, but you should explain *why* the guideline does not apply. After all, it's a *guideline*, not a *law*. And its always possible to adjust things at a later stage.

<!-- <toc title="Table of contents (Contribution guide)"> -->
### Table of contents (Contribution guide)

1. [General advice](#81-general-advice)
   1. [Language](#811-language)
   1. [Commit messages](#812-commit-messages)
1. [Code](#82-code)
   1. [Adding functionality](#821-adding-functionality)
   1. [Coding style](#822-coding-style)
   1. [ShellCheck](#823-shellcheck)
1. [Documentation](#83-documentation)
   1. [Files](#831-files)
   1. [Documentation style](#832-documentation-style)
1. [Translations](#84-translations)
<!-- </toc> -->

### 8.1. General advice

#### 8.1.1. Language

Whatever you may change, the edits must be written in English, preferably American English. This also applies to the text in [issues](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues"), but especially to the documentation and code itself. Exception: If you want to start the endeavor of translating the docs to another language, feel free to do so!

#### 8.1.2. Commit messages

Keep the commit messages brief. Rather explain the reasons in the issue or pull request comment. Write the commit message in the active form, in the simple past, like "Added comma", or "Fixed off-by-one error". By this, the message could be directly used for the release notes of a new Argparser version.

### 8.2. Code

#### 8.2.1. Adding functionality

If you want to add features to the Argparser, write the respective function(s) directly into the main script. By design decision, the Argparser consists of exactly one file, [`argparser`](argparser). This overcomes the general impossibility to find accompanying files (like libraries) from within the script, when its location is arbitrary. Even more importantly, the Argparser can be sourced or executed, leading to different call trees that make it impossible to decide for sure where the components reside.

Novel features require dedicated [tests](tests), [error message translations](docs/reference/translations/translations.md), and/or [tutorial](docs/tutorial/introduction.md) and [reference](docs/reference/introduction.md) sections. You aren't required to write them, but asked to at least provide enough information for others to document the features.

#### 8.2.2. Coding style

The coding style for the Argparser can be seen as a mixture of [Python's PEP 8](https://peps.python.org/pep-0008/ "peps.python.org &rightarrow; PEP 8") and [Google's shell style guide](https://google.github.io/styleguide/shellguide.html "google.github.io &rightarrow; Styleguide &rightarrow; Shellguide") with some project-specific modifications. When in doubt, look at what you find in the existing codebase, or ask in an issue comment. Briefly, the following style is recommended (and in part enforced):

- ***Comments:***
  - Write comments as full sentences, and end them in a period.
  - Use an imperative, rather than declarative style, unless explaining the code's intentions. It is better to comment more, than less, to help understanding the code, later on.
  - Avoid in-line comments, unless necessary and fitting in the line.
  - Separate sentences by two spaces, or a newline for an unrelated thought. This helps the readability within monospaced fonts.
- ***Indentation:***
  - Indent with four spaces per level. Don't use tabs.
  - Indent blocks in functions, loops, conditions, *etc.*, as well as wrapped lines.
- ***Line length:***
  - A line should not exceed 79 characters (80 including the newline character). Wrap an overly long line, indenting any subsequent line from the same command by four additional spaces.
  - In case of long strings, consider using an intermediate variable and successively add the next part of the string to it (this is *e.g.* important for error and warning messages).
  - For conditionals, wrap the line *before* the `&&` or `||`.
  - Comments should wrap at 72 characters (exception: in-line comments).
- ***Whitespace:***
  - Be rather generous with whitespace. Use a space around conditionals and arithmetic or logical operators.
  - Use blank lines to separate blocks of related code from each other.
  - Use Unix linebreaks (LF), not DOS linebreaks (CRLF).
- ***Quoting:***
  - Always quote variables (even shell-internal integers, like `$#`) and command substitutions.
  - Quote strings with double quotes, except the format string of [`printf`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf "gnu.org &rightarrow; Bash Builtins &rightarrow; printf") with single quotes. Double quotes allow variables to be directly interpolated in the strings, which is usually desired.
  - Don't quote `true` and `false` when used as a substitute (mnemonic) of Booleans. Despite them being just strings, this highlights the intention of Booleanness, *i.e.*, that the variable may not hold any value other than `true` or `false` and isn't the literal string `"true"` just by chance.
- ***Functions:***
  - Put all code in functions. This facilitates re-usability, but, more importantly, allows all variables to be local to the Argparser.
  - Define the function using the [`function`](https://www.gnu.org/software/bash/manual/html_node/Shell-Functions.html "gnu.org &rightarrow; Shell Functions") keyword, as well as parentheses after its name. This allows quick identification of function definitions when searching through the code.
  - Use a verb in imperative mode as function name, usually followed by some other words. Abbreviate only very common and often used words, like "arg" for "argument". Use `lowercase_with_underscores` ("snake case") for the name, and begin it with `argparser_`.
  - Start the function with a comment block describing its purpose, arguments, imported nonlocal variables, used environment variables, and output, as applicable.
  - Mark the function for [unsetting](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-unset "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; unset") in `argparser_main`.
- ***Variables:***
  - Always quote variables and enclose them in curly braces, even if no expansion occurs.
  - Don't quote and brace-delimit unexpanded variables in arithmetic contexts (`i`, not `"${i}"`), and don't use braces (but quotes!) for unexpanded special variables (`"$#"`, `"$?"`, *etc.*) and positional parameters (`"$0"`, `"$1"`, *etc.*).
  - Always use local variables (declared in the beginning of a function) to avoid cluttering the namespace with Argparser-internal variables. When a called function needs to set a variable for the caller, use a nonlocal variable, *i.e.*, a variable local to the caller, not the callee. Don't use command substitution to capture the value, since this introduces a subshell for Bash &le; 5.2.
  - Try using a noun as variable identifier. Like for functions, abbreviate only very common and often used words, like "arg" for "argument". Use `lowercase_with_underscores` ("snake case") for the identifier. Don't use a leading underscore to indicate private use, since all variables are local.
  - Use descriptive variable names. This still includes `i`, `j`, *etc.* as loop variables, when they just hold an integer.
  - Argparser environment variables must use `UPPERCASE_WITH_UNDERSCORES` ("screaming snake case") and begin with `ARGPARSER_`.
- ***Arrays:***
  - Use `"$@"` to expand variables, unless `"$*"` is strictly necessary. This helps avoiding errors with a strange [`IFS`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-IFS "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; IFS").
  - Feel free to use both indexed and associative arrays, whenever a collection is necessary.
  - Avoid sparse arrays since copying them with `arr_copy=("${arr[@]}")` makes them dense, again. If this is desired, nothing stands against using sparse arrays.
  - Append to arrays with `arr+=(...)`.
- ***Conditionals:***
  - Always use `[[ ... ]]`, not `[ ... ]`, for testing, which allows many more constructs like regular expressions.
  - Use `==`, not `=`, for comparing equality. This looks better with `!=` and clearly shows that it's a test, not an assignment.
  - When comparing numbers, use the arithmetic expansion in `(( ... ))`, particularly for less-than or greater-than comparisons. Else, the numbers would be compared lexicographically.
- ***Control flow:*** Write the `do`/`then` after `for`/`while`/`if` on the same line as the condition, unless the line gets too long.
- ***Subshells and subprocesses:***
  - Don't use non-builtin (external) commands. This keeps the Argparser's dependencies low and avoids the overhead of forking. For the same reason, avoid subshells, wherever possible. This includes pipelines, command substitutions, and process substitutions. Instead, use intermediate variables for storing temporary results and nonlocal variables for functions.
  - For unavoidable command substitutions, use `$(...)`, not `` `...` ``.
  - In the future, once Bash 5.3 has been adopted enough, the `${...; }` form of non-forking command substitutions may replace the nonlocals. Since this increases the minimum requirement for the Argparser to run, adoption is unclear as of now.
- ***Bashisms:*** Use bashisms (Bash-specific commands and expressions) instead of POSIX-compliant workarounds. The Argparser doesn't aim at POSIX compliance, so use the full set of features Bash has to offer. Arrays, local variables, conditional constructs with `[[ ... ]]` and certain expansions are just some examples of the additionally provided functionality. There is just one section in the Argparser where POSIX compliance is needed, and this is right in the beginning with `argparser_check_shell`, when the Argparser checks that it is run by Bash. Since other shells would fail parsing the function definition, the Argparser could not output a descriptive error message.
- ***Miscellaneous:***
  - Use [`printf`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf "gnu.org &rightarrow; Bash Builtins &rightarrow; printf"), not [`echo`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-echo "gnu.org &rightarrow; Bash Builtins &rightarrow; echo"), which allows more string interpolation options.
  - The Argparser doesn't use the shell option [`errexit`](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#index-set "gnu.org &rightarrow; The Set Builtin &rightarrow; set"), which would interfere with *e.g.* assignments in arithmetic constructs.

#### 8.2.3. ShellCheck

Bash comes with a lot of quirks one needs to be aware of. [ShellCheck](https://github.com/koalaman/shellcheck "github.com &rightarrow; koalaman &rightarrow; shellcheck") is a very powerful linter which flags many common mistakes, and you are highly encouraged to use it, as well. Please use the provided [`.shellcheckrc`](.shellcheckrc) and edit the absolute filepaths to your directory structure.

Only use directives to ignore ShellCheck warnings when the linter is wrong (which happens *e.g.* with indexed *vs.* associative arrays), not because you disagree with a certain coding style. Add a comment after the directive to explain why you disabled the check.

### 8.3. Documentation

#### 8.3.1. Files

For convenience upon writing, the documentation consists of one file, [`.src.md`](docs/.src.md), besides a brief summary in the [`README.md`](README.md). Changes should only happen there, as the [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") handle the creation of the tables of contents, the inclusion of files and command outputs, as well as the splitting of `.src.md` into separate files per section.

For very small changes (like fixing spelling mistakes), you can manually change the respective target file in the documentation, without needing to have the Markdown Tools installed.

#### 8.3.2. Documentation style

The documentation is written in Markdown ([GitHub Flavored Markdown (GFM)](https://github.github.com/gfm/ "github.github.com &rightarrow; GFM") flavor). However, since the specification allows several different tokens for some features (like code blocks), and is rather lenient against whitespace, a few additional, project-specific stylistic guides are needed. If you're using [Visual Studio Code](https://code.visualstudio.com/ "Visual Studio Code"), the [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint "Visual Studio Code &rightarrow; Marketplace &rightarrow; Markdownlint Extension") extension may help you accord to them.

- ***Line length:*** There is no limit to the line length for non-code blocks. To avoid the need for re-ordering the words whenever a word on a previous line is deleted, don't wrap the lines by hand. Instead, use the automatic line wrapping ability of your text editor of choice.
- ***Paragraphs:*** Paragraphs should be separated by one blank line from each other.
- ***Sentences:*** Separate sentences with one space, not two. This goes against the recommendation for [code](#822-coding-style).
- ***Headings:***
  - Headings use the ATX style with hashmarks (`#`), starting with one hashmark for the top-level heading and appending one hashmark per heading level. Don't use the setext style of underlining with equals signs (`=`) and hyphens (`-`), since this only allows two heading levels.
  - Headings must be surrounded by one blank line each.
  - Use little formatting within headings. In-line code is fine, since headings often reflect *e.g.* the name of an environment variable, and need to be typeset accordingly.
  - When a section is large enough to deserve its own documentation file, surround it with a `<!-- <section> -->` comment for the [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") (see there for the exact syntax).
- ***Lists:***
  - Use hyphens (`-`) to markup unnumbered lists, not asterisks (`*`) or plus signs (`+`). Use a literal `1.` for numbered lists, irrespective of the actual number. This facilitates re-ordering the list and deleting elements, without needing to refactor it in its entirety.
  - Top-level lists must be surrounded by one blank line each. Nested lists don't need blank lines.
  - Use exactly one space after the list marker.
- ***Code blocks:***
  - Feel free to use a copious number of code blocks to show code examples.
  - Surround code blocks by blank lines and triple backticks (```` ``` ````). Use a language specification to enable syntax highlighting, even when none exists (like for `text`). Don't use tildes or indented code blocks.
- ***Emphasis:***
  - Emphasize text with asterisks (`*`), *i.e.*, `*italic*`, `**bold**`, and `***italic and bold***`. Don't use underscores (`_`).
  - Use bold font sparingly, to draw attention to a certain point. Use italics for normal emphasis and foreign-language words like Latin abbreviations.
- ***Miscellaneous:***
  - Don't edit tables of contents or heading numbers, the [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") will do it for you. This makes mistakes less likely, especially regarding hyperlinks.

### 8.4. Translations

The Argparser emits a lot of error and warning messages for faulty arguments. Both them and the help and usage messages are internationalized. It would strongly help the Argparser's adoption if it could be localized to more languages&mdash;currently, there are only English and German available. So, if you want to provide translations for the message parts, feel free to add them into the [`translations.yaml`](resources/translations.yaml).

Within the [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") file, just add a new line below each existing translation, start it with the language identifier for your locale after two spaces indentation, add a colon and space, and then the translated text. If it doesn't fit the 79 characters line length, add a greater-than sign (`>`) after the language identifier and write the translation on the next line(s), indented by four spaces. Use `$n` (with n as natural number) as placeholder for the variables the Argparser interpolates. Refer to the [documentation](docs/reference/translations/translations.md) for the meaning of each value.

Try to use the tone and wording commonly found in command-line tool descriptions in your language. Don't just use machine translations, without having checked their validity. By this, the Argparser's output seemlessly integrates into the command-line workflows even in languages other than English.
<!-- </include> -->

[&#129092;&nbsp;7. Roadmap](roadmap.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[9. Reference&nbsp;&#129094;](reference/introduction.md)
