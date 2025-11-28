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

# Shell Argparser

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17037185.svg)](https://doi.org/10.5281/zenodo.17037185)

The Argparser is designed to be an easy-to-use, yet powerful command-line argument parser for your shell scripts. It is mainly targeting Bash, but other shells are supported, as well.

Applying the Argparser should lead to shorter and more concise code than the traditional [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)") and [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") allow. More importantly, the user-friendliness of Argparser-powered command-line parsing is far superior thanks to a wide range of checked conditions with meaningful error messages. The Argparser is inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module.

<!-- <toc> -->
## Table of contents

1. [Features](#1-features)
1. [Quick start](#2-quick-start)
1. [Documentation](#3-documentation)
1. [Dependencies](#4-dependencies)
1. [License](#5-license)
1. [Contributions](#6-contributions)
<!-- </toc> -->

## 1. Features

- Parsing of positional and keyword (option) arguments
- Any number of short and long option names for the same option (as aliases)
- Default and choice values, type checking, deprecation note
- Error and warning messages for wrongly or not set arguments
- Assignment of arguments' values to corresponding script variables
- Automatic creation of help, usage, and version message
- Full internationalization / localization support
- Inheritable arguments definition across multiple scripts
- Large configurability by environment variables and companion files to your script

## 2. Quick start

No installation of the Argparser is necessary, just clone the repository and add its location to the [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH") variable. Alternatively, you may move the [Argparser executable](argparser) into a directory which is already covered by your `PATH`. All other files within the repository serve documentation and testing purposes, and you don't need to keep them.

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Simon-Brandt/ShellArgparser.git

# Adjust the PATH.
PATH="/path/to/ShellArgparser:${PATH}"
```

A very simple quick-start script may look like this:

<details open>

<summary>Contents of <code>try_argparser.sh</code></summary>

<!-- <include command="sed '3,28d;/shellcheck/d' tutorial/try_argparser.sh" lang="bash"> -->
```bash
#!/usr/bin/env bash

# Define the arguments.
args=(
    "id    | short_opts | long_opts   | val_names | defaults | choices | type | arg_no | arg_group            | notes      | help                                              "
    "pos_1 |            |             | pos_1     | 2        | 1,2     | int  | 1      | Positional arguments |            | one positional argument with default and choice   "
    "pos_2 |            |             | pos_2     |          |         | int  | 2      | Positional arguments |            | two positional arguments without default or choice"
    "var_1 | a,A        | var-1,var-a | VAL_1     |          |         | uint | 1      | Mandatory options    |            | one value without default or choice               "
    "var_2 | b,B        | var-2,var-b | VAL_2     |          |         | int  | +      | Mandatory options    |            | at least one value without default or choice      "
    "var_3 | c,C        | var-3,var-c | VAL_3     |          | A,B     | char | +      | Mandatory options    |            | at least one value with choice                    "
    "var_4 | d,D        | var-4,var-d | VAL_4     | A        | A-C     | char | 1      | Optional options     |            | one value with default and choice                 "
    "var_5 | e,E        | var-5,var-e | VAL_5     | E        |         | str  | 1      | Optional options     |            | one value with default                            "
    "var_6 | f,F        | var-6,var-f | VAL_6     | false    |         | bool | 0      | Optional options     |            | no value (flag) with default                      "
    "var_7 | g,G        | var-7,var-g | VAL_7     | true     |         | bool | 0      | Optional options     | deprecated | no value (flag) with default                      "
)
source argparser -- "$@"

# The arguments can now be accessed as keys and values of the
# associative array "args".  Further, they are set as variables to the
# environment, from which they are expanded by globbing.
for arg in "${!var@}"; do
    printf 'The keyword argument "%s" is set to "%s".\n' \
        "${arg}" "${args[${arg}]}"
done | sort

index=1
for arg in "${!pos@}"; do
    printf 'The positional argument "%s" on index %s is set to "%s".\n' \
        "${arg}" "${index}" "${args[${arg}]}"
    (( index++ ))
done
```
<!-- </include> -->

</details>

First, you need to define the arguments your script shall accept, in a tabular manner. To this end, you can use the `--create-arg-def` flag, *i.e.*, run `argparser --create-arg-def`, which will prompt you to enter the arguments definition. Then, you [`source`](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") the Argparser with the current command line (sourcing means in-place execution without forking). Upon this, the Argparser will parse your script's command line, check the arguments for validity, set default values, and assign the values to variables in your script's environment. Many of these steps can be customized by [environment variables](docs/reference/environment_variables/overview.md). The script's remainder just prints the optional and required keyword and positional arguments, and is not a part of the Argparser invokation.

## 3. Documentation

The Argparser's extensive documentation is stored in the [docs](docs) directory, which you should consult to learn all the functionality the Argparser provides. Each file provides a chapter (section) of the documentation, and arrows on the bottom allow you to navigate through the sections, without needing to care about which file stores the requested chapter.

If you want to read the documentation end-to-end, start with the [introduction](docs/introduction.md). For searching through the entire documentation, you can open the [source file](docs/.src.md) that is used to generate the chapters, or use the main [table of contents](docs/toc.md).

## 4. Dependencies

The Argparser is a plain Bash script that does not invoke external commands (only Bash builtins) by design decision. This allows running your script on multiple platforms, as long as Bash is installed, without adding further dependencies to your script. When [contributing](#6-contributions), you may need several other software tools listed and explained in the [documentation](docs/dependencies.md).

For simply running the Argparser, only Bash is required. **Bash&nbsp;&ge;&#8239;4.4** is known to be mandatory, but testing occurred mainly on Bash&nbsp;5.2. Thus, please file an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues") if you encounter errors for versions earlier than 5.2, such that the minimum version can be updated, here (or the bug can be fixed).

## 5. License

The Argparser is licensed under the terms and conditions of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0 "apache.org &rightarrow; Licenses &rightarrow; Apache License, Version 2.0"). This applies to all source code files (all shell scripts and [Julia](https://julialang.org/ "julialang.org") files) and the documentation (all Markdown files), but not to the HTML, SVG, TeX, PDF, and CSV files in the [comparison](comparison) directory, any file in the [resources](resources) directory, as well as the Argparser's [Dockerfile](tests/argparser.dockerfile), the [`.shellcheckrc`](.shellcheckrc), and the [`.gitignore`](.gitignore), which are all placed in the Public Domain.

The Apache License v2.0 allows running, modifying, and distributing the Argparser, even in commercial settings, provided that the license is distributed along the source code or compiled objects. *(This is not legal advice. Read the [license](LICENSE) for the exact terms.)*

## 6. Contributions

Please open an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues") if you:

- found a bug in the Argparser
- discovered an error in the [documentation](docs) (even a spelling or grammar mistake!)
- want to propose a new feature
- want to contribute code (please don't start a pull request prior opening an issue)
- need help with running the Argparser, after having consulted the docs to no avail
- want to enhance the documentation
- want to provide [translations](docs/reference/translations/introduction.md) for the error and warning messages (*very* appreciated!)

You're invited to fix issues yourself, especially trivial mistakes in the docs. To this end, [fork](https://github.com/Simon-Brandt/ShellArgparser/fork) the repository, make the necessary changes, and open a [pull request (PR)](https://github.com/Simon-Brandt/ShellArgparser/compare "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Pull Requests") to merge your changes.

Prior committing non-trivial edits, especially for code, please make sure to have read and followed the [contribution guidelines](CONTRIBUTING.md). This makes it easier to merge the modifications.
