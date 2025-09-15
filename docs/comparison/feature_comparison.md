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

### 6.1. Feature comparison

The following command-line parsers are compared in the given versions:

- [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts"): Bash-builtin, POSIX-compliant command-line parser, from `bash v5.2`
- [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"): legacy command-line parser with GNU extensions, from `util-linux v2.39.3`
- [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags"): clone of Google's C++ [`gflags`](https://gflags.github.io/gflags/ "github.io &rightarrow; gflags") library for Unix-like shells, `v1.3.0`
- [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts"): Go implementation of the platform-independent command-line interface description language and parser [`docopt`](http://docopt.org/ "docopt.org") with Bash wrapper, `v0.6.4`
- [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module"): Python module from the stdlib, from Python `v3.13`
- Argparser: novel shell command-line parser, `v1.0.0`

In the following table, "&#10008;" marks the absence of a feature, "&#10004;" its presence, and "&#10033;" its partial presence, *e.g.*, due to a not-yet complete implementation.

<!-- <table caption="Present or absent features of various command-line parsers"> -->
*Tab. 3: Present or absent features of various command-line parsers.*

| Function                                    | Argparser    | `argparse`    | `getopts`     | `getopt`      | shFlags      | docopts      |
| ------------------------------------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------ |
| Short options                               | &#10004;     | &#10004;      | &#10004;      | &#10004;      | &#10004;     | &#10004;     |
| Long options                                | &#10004;     | &#10004;      | &#10008;      | &#10004;      | &#10004;     | &#10004;     |
| Positional arguments                        | &#10004;     | &#10004;      | &#10033;[^1]  | &#10033;[^1]  | &#10033;[^1] | &#10004;     |
| Mandatory options                           | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10004;     |
| Flags (Boolean options)                     | &#10004;     | &#10004;      | &#10004;      | &#10004;      | &#10004;     | &#10004;     |
| Mutually exclusive arguments                | &#10008;[^2] | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10004;     |
| Intermixed positional and keyword arguments | &#10004;     | &#10004;      | &#10008;      | &#10004;      | &#10008;     | &#10004;     |
| Argument groups                             | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Positional arguments delimiter `--`         | &#10004;     | &#10004;      | &#10004;      | &#10004;      | &#10004;     | &#10004;     |
| Positional arguments delimiter `++`         | &#10004;     | &#10008;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Single-hyphen long options                  | &#10008;[^3] | &#10004;      | &#10008;[^4]  | &#10004;      | &#10008;     | &#10008;     |
| Alternative option prefixes (`+`/`/`)       | &#10008;[^3] | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Default values                              | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10004;     | &#10004;     |
| Choice values                               | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Any argument number (multi-value arguments) | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10004;     |
| Metavariables (value names)                 | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Data type checking                          | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10004;     | &#10008;     |
| Deprecation note                            | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Option merging                              | &#10004;     | &#10004;      | &#10004;      | &#10004;      | &#10004;     | &#10004;     |
| Option abbreviation                         | &#10004;     | &#10004;      | &#10008;[^4]  | &#10004;      | &#10004;     | &#10004;     |
| Flag counting                               | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10033;[^5] |
| Flag negation (`--no-var`)                  | &#10004;     | &#10008;      | &#10008;[^4]  | &#10008;      | &#10004;     | &#10008;     |
| Flag inversion (`+a`)                       | &#10004;     | &#10008;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Inheritable arguments definition            | &#10004;     | &#10004;      | &#10033;[^6]  | &#10033;[^6]  | &#10033;[^6] | &#10033;[^6] |
| Arguments definition files                  | &#10004;     | &#10004;      | &#10033;[^6]  | &#10033;[^6]  | &#10033;[^6] | &#10033;[^6] |
| Arguments auto-set to variables             | &#10004;     | &#10008;      | &#10008;      | &#10008;      | &#10004;     | &#10004;     |
| Error/warning silencing                     | &#10004;     | &#10008;      | &#10004;      | &#10004;      | &#10008;     | &#10008;     |
| Help message                                | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10004;     | &#10004;     |
| Usage message                               | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Version message                             | &#10004;     | &#10004;      | &#10008;      | &#10008;      | &#10008;     | &#10004;     |
| Stylized messages                           | &#10004;     | &#10008;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Customizable message text                   | &#10004;     | &#10004;      | &#10033;[^7]  | &#10033;[^7]  | &#10004;     | &#10008;     |
| Customizable help options                   | &#10004;     | &#10004;      | &#10033;[^8]  | &#10004;      | &#10008;     | &#10033;[^9] |
| Customizable exit codes                     | &#10004;     | &#10033;[^10] | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Configurable parsing                        | &#10004;     | &#10004;      | &#10008;      | &#10004;      | &#10008;     | &#10008;     |
| Internationalization / localization         | &#10004;     | &#10004;      | &#10004;      | &#10004;      | &#10008;     | &#10008;     |
| Debug mode                                  | &#10004;     | &#10008;      | &#10008;      | &#10008;      | &#10008;     | &#10008;     |
| Shell independence (Bash, Dash, ksh93...)   | &#10004;     | &#10008;[^11] | &#10033;[^12] | &#10004;      | &#10004;     | &#10004;     |
| POSIX compliance                            | &#10008;[^3] | &#10008;      | &#10004;      | &#10033;[^13] | &#10008;     | &#10008;     |

[^1]: Not rejected, but not parsed and only usable by manual parsing.
[^2]: Not supported, but to be implemented in a future version.
[^3]: By design decision, might still be implemented in a future version.
[^4]: Not applicable for lack of long options.
[^5]: By using repeatable flags.
[^6]: As (possibly exported) variable.
[^7]: Not builtin, only due to need to write messages manually.
[^8]: Except the common `?`.
[^9]: By overriding the default `-h,--help`
[^10]: Not upon errors, with an exit code of `2`.
[^11]: Not applicable as not designed for usage from within shells.
[^12]: Regarding its application in scripts, would need equivalent builtins in other shells.
[^13]: Opt-in feature *via* environment variable (`POSIXLY_CORRECT`).

[&#129092;&nbsp;Table of contents (Feature comparison)](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.2. Example scripts&nbsp;&#129094;](example_scripts/introduction.md)
