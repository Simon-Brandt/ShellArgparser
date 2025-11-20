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

### 6.5. Summary

When comparing the different approaches to command-line parsing, it is apparent that&mdash;as expected&mdash;the more recent parsers have a larger set of features. While the Bash-builtin [`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") parser comprises only minimal functionality (not even long options), it is the only one that solely implements the POSIX standard. A slightly greater number of features comes with GNU [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"), like long options and the ability to abbreviate them.

Later parsers as [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags") and especially [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts") implement far more sophisticated functionality, like default values, mandatory options, or even an auto-generated help message. Still, they lack, *e.g.*, choice values or the ability to localize messages.

Most of the Argparser's features are inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module, with extensions like the `++` positional arguments delimiter or the ability to negate and invert flags. This renders the Argparser far more powerful than even docopts, while at the same time trying to be more user-friendly.

This is especially noticeable for error messages when building the command line, where the Argparser gives detailled error messages instead of a generic text that just states that something failed. Further, the docopt(s) specification is rather complex, requiring elaborate comprehension on how to write the help message. The Argparser, in contrast, aims at a clearer user interface even for the programmer, by requiring a tabular arguments definition with headers.

Further, the development of shFlags and docopts seemingly has stalled, with no release or even commit for years. This renders it unlikely that these libraries will implement additional functionality, increasing the potential use for the Argparser.

Regarding the runtimes, the compiled tools are faster by one to two orders of magnitude. Still, the interpreted Bash scripts behind the Argparser and shFlags achieve a median runtime of about 120&nbsp;ms and 280&nbsp;ms, respectively, making the runtime a less important criterion when deciding which command-line parsing library to use.

Most importantly, the code length needed to use the parser is drastically reduced for the Argparser, with all other libraries needing the five- to eightfold number of lines to achieve the same thing&mdash;with an even higher ratio for more complex use cases.

Finally, the Argparser is extensively documented, unlike the other tools relying on a brief readme or man page. This hopefully makes the transition to the Argparser&mdash;if deemed useful at all&mdash;easier.

[&#129092;&nbsp;6.4. Code length comparison](code_length_comparison.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[7. Roadmap&nbsp;&#129094;](../roadmap.md)
