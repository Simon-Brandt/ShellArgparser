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

## 3. Dependencies

By design, the Argparser only requires Bash to run. However, for testing the Argparser, for creating the documentation and for [comparing](comparison/introduction.md#6-comparison-of-command-line-parsers) the different command-line parsers, several other tools are required, which you might need to install, should you want to contribute. Most of which (especially all programs for testing) should be pre-installed in any Unix-like environment. Note, however, that the scripts use long options, which may not be supported by your specific software version.

In the following table, "&#10004;" marks the tools necessary for the respective task, "&#10008;" those that aren't required. When no version number is given, any recent version is expected to work.

<!-- <table caption="Dependencies of the Argparser execution, tests, documentation, and feature comparison"> -->
*Tab. 1: Dependencies of the Argparser execution, tests, documentation, and feature comparison.*

| Tool                                                                                                                              | Version         | Execution | Tests    | Documentation | Comparison |
| --------------------------------------------------------------------------------------------------------------------------------- | --------------- | --------- | -------- | ------------- | ---------- |
| Bash                                                                                                                              | &ge;&#8239;4.0  | &#10004;  | &#10004; | &#10004;      | &#10004;   |
| [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html "man7.org &rightarrow; man pages &rightarrow; cat(1)")                   |                 | &#10008;  | &#10008; | &#10004;      | &#10004;   |
| [`cp`](https://man7.org/linux/man-pages/man1/cp.1.html "man7.org &rightarrow; man pages &rightarrow; cp(1)")                      |                 | &#10008;  | &#10008; | &#10008;      | &#10004;   |
| [`dash`](https://man7.org/linux/man-pages/man1/dash.1.html "man7.org &rightarrow; man pages &rightarrow; dash(1)")                |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`diff`](https://man7.org/linux/man-pages/man1/diff.1.html "man7.org &rightarrow; man pages &rightarrow; diff(1)")                |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`dirname`](https://man7.org/linux/man-pages/man1/dirname.1.html "man7.org &rightarrow; man pages &rightarrow; dirname(1)")       |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)")          |                 | &#10008;  | &#10008; | &#10008;      | &#10004;   |
| [`head`](https://man7.org/linux/man-pages/man1/head.1.html "man7.org &rightarrow; man pages &rightarrow; head(1)")                |                 | &#10008;  | &#10008; | &#10004;      | &#10008;   |
| [`ls`](https://man7.org/linux/man-pages/man1/ls.1.html "man7.org &rightarrow; man pages &rightarrow; ls(1)")                      |                 | &#10008;  | &#10008; | &#10004;      | &#10008;   |
| [`readlink`](https://man7.org/linux/man-pages/man1/readlink.1.html "man7.org &rightarrow; man pages &rightarrow; readlink(1)")    |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)")                   |                 | &#10008;  | &#10004; | &#10004;      | &#10004;   |
| [`sort`](https://man7.org/linux/man-pages/man1/sort.1.html "man7.org &rightarrow; man pages &rightarrow; sort(1)")                |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`tee`](https://man7.org/linux/man-pages/man1/tee.1.html "man7.org &rightarrow; man pages &rightarrow; tee(1)")                   |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [`tr`](https://man7.org/linux/man-pages/man1/tr.1.html "man7.org &rightarrow; man pages &rightarrow; tr(1)")                      |                 | &#10008;  | &#10004; | &#10008;      | &#10008;   |
| [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags")                                  | 1.3.0           | &#10008;  | &#10008; | &#10008;      | &#10004;   |
| [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts")                                | 0.6.4           | &#10008;  | &#10008; | &#10008;      | &#10004;   |
| [Julia](https://julialang.org/ "julialang.org")                                                                                   | &ge;&#8239;1.11 | &#10008;  | &#10008; | &#10008;      | &#10004;   |
| [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") |                 | &#10008;  | &#10008; | &#10004;      | &#10008;   |

The test scripts in the [tests](../tests) directory call [`dash`](https://man7.org/linux/man-pages/man1/dash.1.html "man7.org &rightarrow; man pages &rightarrow; dash(1)"), [`diff`](https://man7.org/linux/man-pages/man1/diff.1.html "man7.org &rightarrow; man pages &rightarrow; diff(1)"), [`dirname`](https://man7.org/linux/man-pages/man1/dirname.1.html "man7.org &rightarrow; man pages &rightarrow; dirname(1)"), [`readlink`](https://man7.org/linux/man-pages/man1/readlink.1.html "man7.org &rightarrow; man pages &rightarrow; readlink(1)"), [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)"), [`sort`](https://man7.org/linux/man-pages/man1/sort.1.html "man7.org &rightarrow; man pages &rightarrow; sort(1)"), [`tee`](https://man7.org/linux/man-pages/man1/tee.1.html "man7.org &rightarrow; man pages &rightarrow; tee(1)"), and [`tr`](https://man7.org/linux/man-pages/man1/tr.1.html "man7.org &rightarrow; man pages &rightarrow; tr(1)"). Whenever you want to contribute a feature or fix a bug, you must make sure that the tests pass. This is most easily done by running [`run_tests.sh`](../tests/run_tests.sh) prior committing the changes, to make sure that everything works right from the start.

The [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") are required to create the documentation. This does not necessarily apply for small changes, if you change both the [source](docs/src.sh) and the respective documentation chapter's file by hand. If you modify headings or want to include files, the Markdown Tools are indispensable, since, *e.g.*, they automatically adjust the heading numbering and hyperlinks. The calls to the Markdown Tools within the documentation rely on [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html "man7.org &rightarrow; man pages &rightarrow; cat(1)"), [`head`](https://man7.org/linux/man-pages/man1/head.1.html "man7.org &rightarrow; man pages &rightarrow; head(1)"), [`ls`](https://man7.org/linux/man-pages/man1/ls.1.html "man7.org &rightarrow; man pages &rightarrow; ls(1)"), and [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)") for file inclusion.

For comparing the Argparser to other command-line parsers, [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html "man7.org &rightarrow; man pages &rightarrow; cat(1)"), [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"), [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags"), and [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts") must be installed and added to your [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH"). Within the invoked [`process_html_template.sh`](comparison/process_html_template.sh), [`cp`](https://man7.org/linux/man-pages/man1/cp.1.html "man7.org &rightarrow; man pages &rightarrow; cp(1)") and [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)") are called.

Finally, [Julia](https://julialang.org/ "julialang.org") and its libraries are used to benchmark the scripts. Unless contributing an entirely new feature to the Argparser, you don't need to bother about executing the comparison scripts, and thus don't need to install these dependencies.

For Julia, the following external packages are needed:

- [`CSV.jl`](https://csv.juliadata.org/stable/ "csv.juliadata.org") &ge;&#8239;0.10.15
- [`Statistics.jl`](https://docs.julialang.org/en/v1/stdlib/Statistics/ "docs.julialang.org &rightarrow; Statistics.jl") &ge;&#8239;1.11.1
- [`StatsPlots.jl`](https://docs.juliaplots.org/stable/generated/statsplots/ "docs.juliaplots.org &rightarrow; StatsPlots.jl") &ge;&#8239;0.15.7
- [`Tables.jl`](https://tables.juliadata.org/stable/ "tables.juliadata.org") &ge;&#8239;1.12.1

[&#129092;&nbsp;2. Installation](installation.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4. License&nbsp;&#129094;](license_note.md)
