## 6. Roadmap

Future Argparser versions will add several new features and address known issues. The following sections shall give an overview over them.

### 6.1. Future enhancements

The following features are considered for addition in a future version. If you miss one, feel free to open an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues") to propose it. Note that the feature descriptions are rather open-ended collections of rough idea sketches, instead of precise milestones, so any idea may change, once a better way has been found.  Further, the implementation likelihood only means how desirable a feature seems for the Argparser, not when it will be implemented.

#### 6.1.1. Argument relations

- ***Description:*** Sometimes, multiple arguments may only be given together, or the existence of one argument mandates the existence of another one, which on itself could also be given alone. Secondly, options may contradict each other, like `--verbose` and `--quiet`, and so can only be given in an exclusive fashion on the command line. To enable this behavior, it is likely necessary to introduce another array showing the relations these arguments have. For example, some syntax like `var_a | var_b` may show contravalence (XOR) for mandatory arguments or exclusion (NAND) for optional arguments. This relation would set both arguments as mutually exclusive. Other operators, like `<-` for a prependency or `<->` for a biconditional, will need to be introduced for the aforementioned cases. However, in order to specify a minimal and clear syntax which facilitates application in scripts, and to find an optimal way of parsing, more exploratory trial work needs to be done.
- ***Implementation likelihood:*** High.

#### 6.1.2. Any argument number

- ***Description:*** Currently, the argument number may only be a natural number, including zero, or `+`. The Python [`argparse`](https://docs.python.org/3/library/argparse.html "python.org &rightarrow; Python documentation &rightarrow; argparse module") module supports also `?` for an argument with one optional value, and `*` for an argument accepting as many values as given, starting from zero (not one as with `+`). Still, their implementation requires further considerations for the necessary parsing and error reporting steps.
- ***Implementation likelihood:*** High.

#### 6.1.3. Debug mode

- ***Description:*** A debug mode facilitates the finding of errors within the Argparser. As a useful tool in development, it will be added at some point.
- ***Implementation likelihood:*** High.

#### 6.1.4. Intermixed positional and keyword arguments

- ***Description:*** Currently, positional arguments must be delimited by a `--` from keyword arguments, and subsequent keyword arguments by a `++` from positional arguments. It may be useful to reflect the rather usual behavior of allowing truly intermixed positional and keyword arguments by distinguishing them based on the argument number an argument requires.
- ***Implementation likelihood:*** Medium.

#### 6.1.5. Single-hyphen long options

- ***Description:*** On certain platforms, long options may be given with only one hyphen, sometimes exclusively, sometimes as an alternative to two hyphens. Even programs like GNU [`find`](https://man7.org/linux/man-pages/man1/find.1.html "man7.org &rightarrow; man pages &rightarrow; find(1)") act like this. However, there is a natural ambiguity whether an argument with one hyphen is a single-hyphen long option or a set of concatenated (merged) short options. Allowing single-hyphen long options would require a far more complex parsing step, when an argument with one hyphen is interpreted as long option, as long as one with this name exists, or as a set of short options, else (if allowed at all).
- ***Implementation likelihood:*** Medium.

#### 6.1.6. Usage message include directives

- ***Description:*** Currently, for an [`ARGPARSER_USAGE_FILE`](reference/environment_variables/environment_variables.md#8445-argparser_usage_file), only the [`@All`](reference/include_directives.md#831-all-directive) [include directive](reference/include_directives.md#83-include-directives) is supported. Should there be demand to provide more fine-grained control, more directives could be added.
- ***Implementation likelihood:*** Medium.

#### 6.1.7. License note

- ***Description:*** Usually, a [version message](tutorial/version_messages.md#48-version-messages) indicates the script's license, or at least gives a note about the lack of warranty for functionality of free software. The Argparser instead only gives the script's name (the [`ARGPARSER_SCRIPT_NAME`](reference/environment_variables/environment_variables.md#8435-argparser_script_name)) and the version number (the [`ARGPARSER_VERSION`](reference/environment_variables/environment_variables.md#8455-argparser_version)). Adding the dummy text for the warranty is easy, but would mean that any script employing the Argparser would indentify itself as free software. This would also hold for the (highly discouraged) proprietary software that may use the Argparser, thus misleading the users. Therefore, some environment variable may be needed to control the addition.  
Moreover, it could be even deemed useful to add a `-l,--license` flag to the default options, which would output an `ARGPARSER_LICENSE_FILE`'s contents, showing the exact license&mdash;or just its name?
- ***Implementation likelihood:*** Medium.

#### 6.1.8. POSIX compliance

- ***Description:*** POSIX allows very few constructs for argument parsing, like no long options. Since there are perfectly suitable alternatives for this simple parsing, and the Argparser aims at a way more sophisticated command-line interface, opt-in POSIX compliance seems unnecessary for now.
- ***Implementation likelihood:*** Low.

#### 6.1.9. Alternative option prefixes (`+`/`/`)

- ***Description:*** On certain platforms, options are given with other prefixes, like `/` on DOS-like systems. The Argparser targets Unix-like platforms, and allowing other characters would require a massive change to the codebase. Further, plus signs are used as tokens for flag negation, so for using them as regular prefixes, the hyphen would take their role. More importantly, there is no such equivalent for the forward slash&mdash;a backslash would feel most natural, but would collide with the path separator on DOS-like platforms. Considering the massive efforts needed to implement this, it is unlikely to ever be done.
- ***Implementation likelihood:*** Almost zero.

### 6.2. Known bugs

- If the column width in the help message is extremely narrow (like 2 characters), the content may be broken on wrong positions, leading to an omission of arguments.

[&#129092;&nbsp;5.4. Summary](comparison/summary.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[7. Contribution guide&nbsp;&#129094;](contribution_guide.md)
