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

### 6.3. Runtime comparison

Using the [Julia](https://julialang.org/ "julialang.org") script [`analyze_runtime.jl`](../../comparison/analyze_runtime.jl), we can compare the different runtimes of the command-line parsers (with the `--exit` flag to exit prior running [`process_html_template.sh`](../../comparison/process_html_template.sh)). The violin plots of 1000 iterations each are shown in the following figure:

<!-- <figure file="../comparison/stats.svg" caption="Violin plot of all command-line parsers' runtimes"> -->
![Violin plot of all command-line parsers' runtimes](../../comparison/stats.svg)
*Fig. 1: Violin plot of all command-line parsers' runtimes.*

The runtime statistics are given in the following table:

<!-- <table caption="Runtimes of all command-line parsers"> -->
*Tab. 4: Runtimes of all command-line parsers.*

<!-- <include command="sed --regexp-extended 's/\w+\.sh/`&`/;s/,/ | /g;s/^/| /;s/$/ |/;2i | --- | --- | --- | --- |' ../comparison/stats.csv"> -->
| Parser | Mean | Std dev | Median |
| --- | --- | --- | --- |
| getopts | 1.8 | 0.6 | 2.0 |
| getopt | 5.6 | 1.4 | 6.0 |
| shFlags | 246.0 | 40.8 | 257.0 |
| docopts | 11.7 | 3.0 | 11.0 |
| Shell Argparser | 142.4 | 2.0 | 142.0 |
<!-- </include> -->

As you can see, and unsurprisingly, the runtimes of the compiled programs (`docopts`, `getopt`, and `getopts`) is far lower than that of the interpreted programs (`argparser` and `shflags`). Nonetheless, even the two Bash scripts achieve a runtime of less than 150 and 300&nbsp;ms each. Thereby, the median runtime of the Argparser is lower (and more repeatable) than that of shFlags, while the tool offers far more features. This can be attributed to the design decision of using only Bash builtins within the Argparser, whereas shFlags forks into multiple subshells for external programs and even functions.

For usual scripts, the runtime overhead of the command-line parsing should be negligible, compared to the actual script's runtime, such that the various tools can be chosen by their set of features, and not their runtime.

[&#129092;&nbsp;6.2.5. Argparser](example_scripts/argparser.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.4. Code length comparison&nbsp;&#129094;](code_length_comparison.md)
