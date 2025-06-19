## 5. Roadmap

Future argparser versions will add several new features and address known issues. The following sections shall give an overview over them.

### 5.1. Future enhancements

The following features are considered for addition in a future version. If you miss one, feel free to open an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues") to propose it.

#### 5.1.1. Mutually exclusive argument groups

- ***Description:*** Arguments in mutually exclusive argument groups can only be given on the command line one at a time. This is useful for contradicting options, like `--verbose` and `-quiet`.
- ***Implementation likelihood:*** High.

#### 5.1.2. Any argument number

- ***Description:*** Currently, the argument numbe rmay only be a natural number, including zero, or `+`. The Python argparse module supports also `?` for an argument with an optional value, and `*` for an argument with as many values as given, starting from zero (not one as with `+`). Still, their implementation requires further considerations for the necessary parsing steps.
- ***Implementation likelihood:*** High.

#### 5.1.3. Script description

- ***Description:*** In the help message, there is usually a short sentence describing the program's purpose. This can be implemented *via* an environment variable, *e.g.* `${ARGPARSER_DESCRIPTION}`.
- ***Implementation likelihood:*** High.

#### 5.1.4. Debug mode

- ***Description:*** A debug mode facilitates the finding of errors within the argparser. As a useful tool in development, it will be added at some point.
- ***Implementation likelihood:*** High.

#### 5.1.5. Value ranges

- ***Description:*** Default and choice values may be specified as ranges. Integer and character ranges should be rather easily implemented, while float ranges suffer from the lack of built-in support for floats in Bash < 5.3.
- ***Implementation likelihood:*** High.

#### 5.1.6. Intermixed positional and keyword arguments

- ***Description:*** Currently, positional arguments must be delimited by a `--` from keyword arguments, and subsequent keyword arguments by a `++` from positional arguments. It may be useful to reflect the rather usual behavior of allowing truly intermixed positional and keyword arguments by distinguishing them based on the argument number an argument requires.
- ***Implementation likelihood:*** Medium.

#### 5.1.7. Single-hyphen long options

- ***Description:*** On certain platforms, long options may be given with only one hyphen, sometimes exclusively, sometimes as an alternative to two hyphens. Even programs like GNU [`find`](https://man7.org/linux/man-pages/man1/find.1.html "man7.org &rightarrow; man pages &rightarrow; find(1)") act like this. However, there is a natural ambiguity whether an argument with one hyphen is a single-hyphen long option or a set of concatenated (merged) short options. Allowing single-hyphen long options would require a far more complex parsing step, when an argument with one hyphen is interpreted as long option, as long as one with this name exists, or as a set of short options, else (if allowed at all).
- ***Implementation likelihood:*** Medium.

#### 5.1.8. POSIX compliance

- ***Description:*** POSIX allows very few constructs for argument parsing, like no long options. Since there are perfectly suitable alternatives for this simple parsing, and the argparser aims at a way more sophisticated command-line interface, opt-in POSIX compliance seems unnecessary for now.
- ***Implementation likelihood:*** Low.

#### 5.1.9. Alternative option prefixes (`+`/`/`)

- ***Description:*** On certain platforms, options are given with other prefixes, like `/` on DOS-like systems. The argparser targets Unix-like platforms, and allowing other characters would require a massive change to the codebase. Further, plus signs are used as tokens for flag negation, so for using them as regular prefixes, the hyphen would take their role. More importantly, there is no such equivalent for the forward slash&mdash;a backslash would feel most natural, but would collide with the path separator on DOS-like platforms. Considering the massive efforts needed to implement this, it is unlikely to ever be done.
- ***Implementation likelihood:*** Almost zero.

### 5.2. Known bugs

- If the column width in the help message is extremely narrow (like 2 characters), the content may be broken on wrong positions, leading to an omission of arguments.

[&#129092;&nbsp;`comparison/summary.md`](comparison/summary.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`reference/introduction.md`&nbsp;&#129094;](reference/introduction.md)
