### 4.1. Feature comparison

The following command-line parsers are compared in the given versions:

- [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts"): Bash-builtin, POSIX-compliant command-line parser, from Bash `v5.2`
- [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"): legacy command-line parser with GNU extensions, from `util-linux v2.39.3`
- [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags"): clone of Google's C++ [`gflags`](https://gflags.github.io/gflags/ "github.io &rightarrow; gflags") library for Unix-like shells, `v1.3.0`
- [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts"): Go implementation of the platform-independent command-line interface description language and parser `docopt` with Bash wrapper, `v0.6.4`
- [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module"): Python module from the stdlib, from Python `v3.13`
- argparser: novel shell command-line parser, `v0.1.0`

In the following table, "&#10008;" marks the absence of a feature, "&#10004;" its presence, and "&#10033;" its partial presence, *e.g.*, due to a not-yet complete implementation.

| Function                                    | `getopts`     | `getopt`      | shFlags      | docopts      | `argparse`    | argparser    |
|---------------------------------------------|---------------|---------------|--------------|--------------|---------------|--------------|
| Short options                               | &#10004;      | &#10004;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Long options                                | &#10008;      | &#10004;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Positional arguments                        | &#10033;[^1]  | &#10033;[^1]  | &#10033;[^1] | &#10004;     | &#10004;      | &#10004;     |
| Mandatory options                           | &#10008;      | &#10008;      | &#10008;     | &#10004;     | &#10004;      | &#10004;     |
| Flags (Boolean options)                     | &#10004;      | &#10004;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Mutually exclusive arguments                | &#10008;      | &#10008;      | &#10008;     | &#10004;     | &#10004;      | &#10008;[^2] |
| Intermixed positional and keyword arguments | &#10008;      | &#10004;      | &#10008;     | &#10004;     | &#10004;      | &#10008;[^3] |
| Argument groups                             | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Positional arguments delimiter `--`         | &#10004;      | &#10004;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Positional arguments delimiter `++`         | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10008;      | &#10004;     |
| Single-hyphen long options                  | &#10008;[^4]  | &#10004;      | &#10008;     | &#10008;     | &#10004;      | &#10008;[^3] |
| Alternative option prefixes (`+`/`/`)       | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10008;[^3] |
| Default values                              | &#10008;      | &#10008;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Choice values                               | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Any argument number (multi-value arguments) | &#10008;      | &#10008;      | &#10008;     | &#10004;     | &#10004;      | &#10033;[^2] |
| Metavariables (value names)                 | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Data type checking                          | &#10008;      | &#10008;      | &#10004;     | &#10008;     | &#10004;      | &#10004;     |
| Deprecation note                            | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Option merging                              | &#10004;      | &#10004;      | &#10008;     | &#10004;     | &#10004;      | &#10004;     |
| Option abbreviation                         | &#10008;[^4]  | &#10004;      | &#10008;     | &#10004;     | &#10004;      | &#10004;     |
| Flag counting                               | &#10008;      | &#10008;      | &#10008;     | &#10033;[^5] | &#10004;      | &#10004;     |
| Flag negation (`no-var`)                    | &#10008;[^4]  | &#10008;      | &#10004;     | &#10008;     | &#10008;      | &#10004;     |
| Flag inversion (`+a`)                       | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10008;      | &#10004;     |
| Inheritable arguments definition            | &#10033;[^6]  | &#10033;[^6]  | &#10033;[^6] | &#10033;[^6] | &#10004;      | &#10004;     |
| Arguments definition files                  | &#10033;[^6]  | &#10033;[^6]  | &#10033;[^6] | &#10033;[^6] | &#10004;      | &#10004;     |
| Arguments auto-set to variables             | &#10008;      | &#10008;      | &#10004;     | &#10004;     | &#10008;      | &#10004;     |
| Error/warning silencing                     | &#10004;      | &#10004;      | &#10008;     | &#10008;     | &#10008;      | &#10004;     |
| Help message                                | &#10008;      | &#10008;      | &#10004;     | &#10004;     | &#10004;      | &#10004;     |
| Usage message                               | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Version message                             | &#10008;      | &#10008;      | &#10008;     | &#10004;     | &#10004;      | &#10004;     |
| Stylized messages                           | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10008;      | &#10004;     |
| Customizable message text                   | &#10033;[^7]  | &#10033;[^7]  | &#10004;     | &#10008;     | &#10004;      | &#10004;     |
| Customizable help options                   | &#10033;[^8]  | &#10004;      | &#10008;     | &#10033;[^9] | &#10004;      | &#10004;     |
| Customizable exit codes                     | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10033;[^10] | &#10004;     |
| Configurable parsing                        | &#10008;      | &#10004;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Internationalization / localization         | &#10004;      | &#10004;      | &#10008;     | &#10008;     | &#10004;      | &#10004;     |
| Debug mode                                  | &#10008;      | &#10008;      | &#10008;     | &#10008;     | &#10008;      | &#10008;[^2] |
| Shell independence (Bash, Dash, ksh93...)   | &#10004;[^11] | &#10004;      | &#10004;     | &#10004;     | &#10008;[^12] | &#10004;     |
| POSIX compliance                            | &#10004;      | &#10033;[^13] | &#10008;     | &#10008;     | &#10008;      | &#10008;[^3] |

[^1]: Not rejected, but not parsed and only usable by manual parsing.
[^2]: Not (entirely) supported, but to be implemented in a future version.
[^3]: By design decision, might still be implemented in a future version.
[^4]: Not applicable for lack of long options.
[^5]: By using repeatable flags.
[^6]: As (possibly exported) variable.
[^7]: Not builtin, only due to need to write messages manually.
[^8]: Except the common `?`.
[^9]: By overriding the default `-h,--help`
[^10]: Not upon errors, with an exit code of `2`.
[^11]: Regarding its application in scripts, would need equivalent builtins in other shells.
[^12]: Not applicable as not designed for usage from within shells.
[^13]: Opt-in feature *via* environment variable (`POSIXLY_CORRECT`).

[&#129092;&nbsp;`toc.md`](toc.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`example_scripts/getopts.md`&nbsp;&#129094;](example_scripts/getopts.md)
