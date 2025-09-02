<!-- <include file="introduction.md"> -->
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

[![DOI](https://zenodo.org/badge/874059620.svg)](https://doi.org/10.5281/zenodo.17037185)

The Argparser is designed to be an easy-to-use, yet powerful command-line argument parser for your shell scripts. It is mainly targeting Bash, but other shells are supported, as well. Shells other than Bash just require a slightly different method of invokation (*i.e.*, running the Argparser in a pipe or process substitution, not by sourcing it).

Applying the Argparser should lead to shorter and more concise code than the traditionally used [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)")/[`getopts`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-getopts "gnu.org &rightarrow; Bourne Shell Builtins &rightarrow; getopts") or a bare suite of conditionals in a [`case..esac`](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#index-case "gnu.org &rightarrow; Conditional Constructs &rightarrow; case") statement allow. More importantly, the user-friendliness of Argparser-powered command-line parsing is far superior thanks to a wide range of checked conditions with meaningful error messages.

The Argparser is entirely written in pure Bash, without invoking external commands. Thus, using it does not add additional dependencies to your script&mdash;except of course the Argparser itself&mdash;, especially not differing versions/implementations of a program (like with [`awk`](https://man7.org/linux/man-pages/man1/awk.1p.html "man7.org &rightarrow; man pages &rightarrow; awk(1p)")). Additionally, its design choices of not calling external commands and running almost without forking into subshells lead to a good runtime despite the extensive parsing and checking steps. The Argparser is inspired by the Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module.

[Table of contents&nbsp;&#129094;](toc.md)
<!-- </include> -->
