# Contribution guide

You're very welcome to contribute to the argparser! Be it fixing spelling mistakes or small bugs, adding or clarifying the [documentation](docs), or even adding new functionality to the argparser itself, any improvement is highly appreciated.

In order to facilitate the seemless integration of your commits with the argparser codebase, please try to comply with the following guidelines. Most of them are rather irrelevant for small fixes, so you probably would follow them, anyways. If you have reasons *not* to comply, it would likely not mean that your commit can't be merged, but you should explain *why* the guideline does not apply. After all, it's a *guideline*, not a *law*. And its always possible to adjust things at a later stage.

<!-- <toc> -->
## Table of contents

1. [General advice](#1-general-advice)
   1. [Language](#11-language)
   1. [Commit messages](#12-commit-messages)
1. [Code](#2-code)
   1. [Adding functionality](#21-adding-functionality)
   1. [Coding style](#22-coding-style)
   1. [ShellCheck](#23-shellcheck)
<!-- </toc> -->

## 1. General advice

### 1.1. Language

Whatever you may change, the edits must be written in English, preferably American English. This also applies to the text in [issues](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues"), but especially to the documentation and code itself. Exception: If you want to start the endeavor of translating the docs to another language, feel free to do so!

### 1.2. Commit messages

Keep the commit messages brief. Rather explain the reasons in the issue or pull request comment. Write the commit message in the active form, in the simple past, like "Added comma", or "Fixed off-by-one error". By this, the message could be directly used for the release notes of a new argparser version.

## 2. Code

### 2.1. Adding functionality

If you want to add features to the argparser, write the respective function(s) directly into the main script. By design decision, the argparser consists of exactly [one file](argparser). This overcomes the general impossibility to find accompanying files (like libraries) from within the script, when its location is arbitrary. Even more importantly, the argparser can be sourced or executed, leading to different call trees that make it impossible to decide for sure where the components reside.

Novel features require dedicated [tests](tests), [error message translations](docs/reference/translations/translations.md), and/or [tutorial](docs/tutorial/introduction.md) and [reference](docs/reference/introduction.md) sections. You aren't required to write them, but asked to at least provide enough information for others to document the features.

### 2.2. Coding style

The coding style for the argparser can be seen as a mixture of [Python's PEP 8](https://peps.python.org/pep-0008/ "peps.python.org &rightarrow; PEP 8") and [Google's shell style guide](https://google.github.io/styleguide/shellguide.html "google.github.io &rightarrow; Styleguide &rightarrow; Shellguide") with some project-specific modifications. When in doubt, look at what you find in the existing codebase, or ask in an issue comment. Briefly, the following style is recommended (and in part enforced):

- ***Comments:***
  - Write comments as full sentences, and end them in a period.
  - Use an imperative, rather than declarative style, unless explaining the code's intentions. It is better to comment more, than less, to help understanding the code, later on.
  - Avoid in-line comments, unless necessary and fitting in the line.
  - Separate sentences by two spaces, or a newline. This helps the readability within monospaced fonts.
- ***Indentation:***
  - Indent with four spaces per level. Don't use tabs.
  - Indent blocks in functions, loops, conditions, *etc.*, as well as wrapped lines.
- ***Line length:***
  - A line should not exceed 79 characters (80 including the newline character). Wrap an overly long line, indenting any subsequent line from the same command by four spaces.
  - In case of long strings, consider using an intermediate variable and successively add the next part of the string to it (this is *e.g.* important for error and warning messages).
  - For conditionals, wrap the line *before* the `&&` or `||`.
  - Comments should wrap at 72 characters (Exception: in-line comments).
- ***Whitespace:***
  - Be rather generous with whitespace. Use a space around conditionals and arithmetic or logical operators.
  - Use blank lines to separate blocks of related code from each other.
  - Use Unix linebreaks (LF), not DOS linebreaks (CRLF).
- ***Quoting:***
  - Always quote variables (even shell-internal integers, like `$#`) and command substitutions.
  - Quote strings with double quotes, except the format string of [`printf`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf "gnu.org &rightarrow; Bash Builtins &rightarrow; printf") with single quotes. Double quotes allow variables to be directly interpolated in the strings, which is usually desired (like within error messages).
  - Don't quote `true` and `false` when used as a substitute of Booleans. Despite them being just strings, this highlights the intention of Booleanness, *i.e.*, that the variable may not hold any value other than `true` or `false` and isn't `"true"` just by chance.
- ***Functions:***
  - Put all code in functions. This facilitates re-usability, but, more importantly, allows all variables to be local to the argparser.
  - Define the function using the [`function`](https://www.gnu.org/software/bash/manual/html_node/Shell-Functions.html "gnu.org &rightarrow; Shell Functions") keyword, as well as parentheses after its name. This allows quick identification of function definitions when searching through the code.
  - Use a verb in imperative mode as function name, likely followed by some other words. Abbreviate only very common and often used words, like "arg" for "argument". Use `lowercase_with_underscores` for the name, and begin it with `argparser_`.
  - Start the function with a comment block describing its purpose, arguments, imported nonlocal variables, used environment variables, and output, as applicable.
- ***Variables:***
  - Always quote variables and enclose them in braces, even if no expansion occurs.
  - Don't quote and brace-delimit unexpanded variables in arithmetic contexts (`i`, not `"${i}"`), and don't use braces (but quotes!) for unexpanded special variables (`"$#"`, `"$?"`, *etc.*) and positional parameters (`"$0"`, `"$1"`, *etc.*).
  - Always use local variables (declared in the beginning of a function) to avoid cluttering the namespace with argparser-internal variables. When a called function needs to set a variable for the caller, use a nonlocal variable, *i.e.*, a variable local to the caller, not the callee. Don't use command substitution to capture the value.
  - Try using a noun as variable identifier. Abbreviate only very common and often used words, like "arg" for "argument". Use `lowercase_with_underscores` for the identifier. Don't use a leading underscore to indicate private use, since all variables are local.
  - Use descriptive variable names. This still includes `i`, `j`, *etc.* as loop variables, when they just hold an integer.
  - Argparser environment variables must use `UPPERCASE_WITH_UNDERSCORES` and begin with `ARGPARSER_`.
- ***Arrays:***
  - Use `$@` to expand variables, unless `$*` is strictly necessary. This helps avoiding errors with a strange [`IFS`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-IFS "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; IFS").
  - Feel free to use both indexed and associative arrays, whenever a collection is necessary.
  - Avoid sparse arrays since copying them with `arr_copy=("${arr[@]}")` makes them dense, again.
  - Append to arrays with `arr+=(...)`.
- ***Conditionals:***
  - Always use `[[ ... ]]`, not `[ ... ]`, for testing, which allows many more constructs like regular expressions.
  - Use `==`, not `=`, for comparing equality.
  - When comparing numbers, use the arithmetic expansion in `(( ... ))`.
- ***Control flow:*** Write the `do`/`then` after `for`/`while`/`if` on the same line as the condition, unless the line gets too long.
- ***Subshells and subprocesses:***
  - Don't use non-builtin (external) commands. This keeps the argparser's dependencies low and avoids the overhead of forking. For the same reason, avoid subshells, wherever possible. This includes pipelines, command substitutions, and process substitutions. Instead, use intermediate variables for storing temporary results and nonlocal variables for functions.
  - For unavoidable command substitutions, use `$(...)`, not `` `...` ``.
  - In the future, once Bash 5.3 has been adopted enough, the `${...; }` form of non-forking command substitutions may replace the nonlocals. Since this increases the minimum requirement for the argparser to run, adoption is unclear as of now.
- ***Bashisms:*** Use bashisms (Bash-specific commands and expressions) instead of POSIX-compliant workarounds. The argparser doesn't aim at POSIX compliance, so use the full set of features Bash has to offer. Arrays, local variables, conditional constructs with `[[ ... ]]` and certain expansions are just some examples of the additionally provided functionality. There is just one section in the argparser where POSIX compliance is needed, and this is right in the beginning, when the argparser checks that it is run by Bash. Since other shells would fail parsing the function definition, the argparser could not output a descriptive error message.
- ***Miscellaneous:***
  - Use [`printf`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf "gnu.org &rightarrow; Bash Builtins &rightarrow; printf"), not [`echo`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-echo "gnu.org &rightarrow; Bash Builtins &rightarrow; echo"), which allows less string interpolation options.
  - The argparser doesn't use the shell option [`errexit`](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#index-set "gnu.org &rightarrow; The Set Builtin &rightarrow; set"), which would interfere with *e.g.* assignments in arithmetic constructs.

### 2.3. ShellCheck

Bash comes with a lot of quirks one needs to be aware of. [ShellCheck](https://github.com/koalaman/shellcheck "github.com &rightarrow; koalaman &rightarrow; shellcheck") is a very powerful linter which flags many common mistakes, and you are highly encouraged to use it, as well. Please use the provided [`.shellcheckrc`](.shellcheckrc) and edit the absolute filepaths to your directory structure.

Only use directives to ignore ShellCheck warnings when the linter is wrong (which happens *e.g.* with indexed *vs.* associative arrays), not because you disagree with a certain coding style. Add a comment after the directive to explain why you disabled the check.
