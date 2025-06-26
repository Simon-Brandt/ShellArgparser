### 5.3. Runtime comparison

Using the [Julia](https://julialang.org/ "julialang.org") script [`analyse_runtime.jl`](../../comparison/analyse_runtime.jl), we can compare the different runtimes of the command-line parsers. The violin plots of 1000 iterations each are shown in the following figure:

![Violin plot of all command-line parsers' runtimes](../../comparison/stats.svg)

The runtime statistics are given in the following table:

<!-- <include command="sed --regexp-extended 's/\w+\.sh/`&`/;s/,/ | /g;s/^/| /;s/$/ |/;2i | --- | --- | --- | --- |' ../comparison/stats.csv"> -->
| Script | Mean | Std dev | Median |
| --- | --- | --- | --- |
| `argparser_wrapper.sh` | 138.758 | 2.479028354331911 | 138.0 |
| `docopts_wrapper.sh` | 23.521 | 7.075848120658521 | 23.0 |
| `getopt_wrapper.sh` | 17.514 | 5.234042338307862 | 19.0 |
| `getopts_wrapper.sh` | 15.286 | 4.482666427283912 | 16.0 |
| `shflags_wrapper.sh` | 209.409 | 47.234000145761236 | 217.0 |
<!-- </include> -->

As you can see, and unsurprisingly, the runtimes of the compiled programs (`docopts`, `getopt`, and `getopts`) is far lower than that of the interpreted programs (`argparser` and `shflags`). Nonetheless, even the two Bash scripts achieve a runtime of less than 300&nbsp;ms each. Thereby, the median runtime of the Argparser is lower (and more repeatable) than that of shFlags, while offering far more features. This can be attributed to the design decision of using only Bash builtins within the Argparser, whereas shFlags forks into multiple subshells for external tools.

For usual scripts, the runtime overhead of the command-line parsing should be negligible, compared to the actual script's runtime, such that the various tools can be chosen by their set of features, and not their runtime.


[&#129092;&nbsp;5.2.5. Argparser](example_scripts/argparser.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[5.4. Summary&nbsp;&#129094;](summary.md)
