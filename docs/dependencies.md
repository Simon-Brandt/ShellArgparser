## 3. Dependencies

By design, the Argparser only requires Bash to run. However, for creating the documentation and for [comparing](comparison/introduction.md#5-comparison-of-command-line-parsers) the different command-line parsers, several other tools are required, which you would need to install, should you want to contribute.

In the following table, "&#10004;" marks the tools necessary for the respective task, "&#10008;" those that aren't required. When no version number is given, any recent version is expected to work.

| Tool                                                                                                                              | Version    | Execution | Documentation | Comparison |
| --------------------------------------------------------------------------------------------------------------------------------- | ---------- | --------- | ------------- | ---------- |
| Bash                                                                                                                              | &geq; 4.0  | &#10004;  | &#10004;      | &#10004;   |
| [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") |            | &#10008;  | &#10004;      | &#10008;   |
| [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html "man7.org &rightarrow; man pages &rightarrow; cat(1)")                   |            | &#10008;  | &#10004;      | &#10008;   |
| [`head`](https://man7.org/linux/man-pages/man1/head.1.html "man7.org &rightarrow; man pages &rightarrow; head(1)")                |            | &#10008;  | &#10004;      | &#10008;   |
| [`ls`](https://man7.org/linux/man-pages/man1/ls.1.html "man7.org &rightarrow; man pages &rightarrow; ls(1)")                      |            | &#10008;  | &#10004;      | &#10008;   |
| [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)")                   |            | &#10008;  | &#10004;      | &#10004;   |
| [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)")          |            | &#10008;  | &#10008;      | &#10004;   |
| [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags")                                  | 1.3.0      | &#10008;  | &#10008;      | &#10004;   |
| [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts")                                | 0.6.4      | &#10008;  | &#10008;      | &#10004;   |
| [Julia](https://julialang.org/ "julialang.org")                                                                                   | &geq; 1.11 | &#10008;  | &#10008;      | &#10004;   |

The [Markdown Tools](https://github.com/Simon-Brandt/MarkdownTools "github.com &rightarrow; Simon-Brandt &rightarrow; MarkdownTools") are required to create the documentation. This does not necessarily apply for small changes, if you change both the [source](docs/src.sh) and the respective documentation chapter by hand. If you modify headings or want to include files, the Markdown Tools are indispensable, since, *e.g.*, they automatically adjust the heading numbering and hyperlinks. The calls to the Markdown Tools within the documentation rely on [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html "man7.org &rightarrow; man pages &rightarrow; cat(1)"), [`head`](https://man7.org/linux/man-pages/man1/head.1.html "man7.org &rightarrow; man pages &rightarrow; head(1)"), [`ls`](https://man7.org/linux/man-pages/man1/ls.1.html "man7.org &rightarrow; man pages &rightarrow; ls(1)"), and [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)") for file inclusion.

For comparing the Argparser to other command-line parsers, [`getopt`](https://man7.org/linux/man-pages/man1/getopt.1.html "man7.org &rightarrow; man pages &rightarrow; getopt(1)"), [shFlags](https://github.com/kward/shflags "github.com &rightarrow; kward &rightarrow; shFlags"), and [docopts](https://github.com/docopt/docopts "github.com &rightarrow; docopt &rightarrow; docopts") must be installed and added to your [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH"). Within the invoked [`process_html_template.sh`](comparison/process_html_template.sh), [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)") is called.

Finally, [Julia](https://julialang.org/ "julialang.org") and its libraries are used to benchmark the scripts. Unless contributing an entirely new feature to the Argparser, you don't need to bother about executing the comparison scripts, and thus don't need to install these dependencies.

For Julia, the following external packages are needed:

- [`CSV.jl`](https://csv.juliadata.org/stable/ "csv.juliadata.org") &geq; 0.10.15
- [`Statistics.jl`](https://docs.julialang.org/en/v1/stdlib/Statistics/ "docs.julialang.org &rightarrow; Statistics.jl") &geq; 1.11.1
- [`StatsPlots.jl`](https://docs.juliaplots.org/stable/generated/statsplots/ "docs.juliaplots.org &rightarrow; StatsPlots.jl") &geq; 0.15.7
- [`Tables.jl`](https://tables.juliadata.org/stable/ "tables.juliadata.org") &geq; 1.12.1

[&#129092;&nbsp;2. Installation](installation.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4. Tutorial&nbsp;&#129094;](tutorial/introduction.md)
