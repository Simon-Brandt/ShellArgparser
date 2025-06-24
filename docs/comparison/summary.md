### 5.3. Summary

When comparing the different approaches to command-line parsing, it is apparent that&mdash;as expected&mdash;the more recent parsers have a larger set of features. While the Bash-builtin `getopts` parser comprises only minimal functionality (not even long options), it is the only one that implements the POSIX standard. A slightly greater number of features comes with GNU `getopt`, like long options and the ability to abbreviate them.

Later parsers as shFlags and especially docopts implement far more sophisticated functionality, like default values, mandatory options, or even an auto-generated help message. Still, they lack, *e.g.*, choice values or the ability to localize messages.

Most of the Argparser's features are inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module, with extensions like the `++` positional arguments delimiter or the ability to negate and invert flags. This renders the Argparser far more powerful than even docopts, while at the same time trying to be more user-friendly.

This is especially noticeable for error messages when building the command line, where the Argparser gives detailled error messages instead of a generic text that just states that something failed. Further, the docopt(s) specification is rather complex, requiring elaborate comprehension on how to write the help message. The Argparser, in contrast, aims at a clearer user interface even for the programmer, by requiring a tabular arguments definition with optional headers.

Further, the development of shFlags and docopts seemingly have stalled, with no release or even commit for years. This renders it unlikely that these libraries will implement additional functionality, increasing the potential use for the Argparser.

Finally, the Argparser is extensively documented, unlike the other tools relying on a brief readme or man page. This hopefully makes the transition to the Argparser&mdash;if deemed useful at all&mdash;easier.

[&#129092;&nbsp;`example_scripts/argparser.md`](example_scripts/argparser.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`../roadmap.md`&nbsp;&#129094;](../roadmap.md)
