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

### 6.4. Code length comparison

A second [Julia](https://julialang.org/ "julialang.org") script, [`analyze_code_length.jl`](../../comparison/analyze_code_length.jl), allows us to compare the actual number of code lines required to use the command-line parsers, and by this the complexity of employing them (including all the manual parsing steps). Thereby, only the lines for the parsing are counted, not the call to the HTML processor, no comments, and no blank lines (except of those lying in the help messages and thus being part of the syntax).

<!-- <figure file="../comparison/code_lengths.svg" caption="Bar plot of all command-line parsers' code lengths"> -->
![Bar plot of all command-line parsers' code lengths](../../comparison/code_lengths.svg)  
*Fig. 2: Bar plot of all command-line parsers' code lengths.*

The code length statistics are given in the following table:

<!-- <table caption="Code lengths of all command-line parsers"> -->
*Tab. 5: Code lengths of all command-line parsers.*

<!-- <include command="sed --regexp-extended 's/\w+\.sh/`&`/;s/,/ | /g;s/^/| /;s/$/ |/;2i | --- | --- | --- |' ../comparison/code_lengths.csv"> -->
| Parser | Code length (absolute) | Code length (relative) |
| --- | --- | --- |
| getopts | 102 | 6.4 |
| getopt | 131 | 8.2 |
| shFlags | 87 | 5.4 |
| docopts | 94 | 5.9 |
| Shell Argparser | 16 | 1.0 |
<!-- </include> -->

As you can see, the parsers' number of code lines ranges from 87 to 131 lines, with the Argparser requiring just 16 lines, one fifth to one eighth of the others. So, owing to the Argparser's sophisticated set of features, only very few manual parsing steps are required, and even them are fast to implement.


[&#129092;&nbsp;6.3. Runtime comparison](runtime_comparison.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.5. Summary&nbsp;&#129094;](summary.md)
