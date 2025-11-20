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

## 7. Roadmap

Future Argparser versions will add several new features and address known issues. The following sections shall give an overview over them. Beforehand, we'll discuss the release policy for the Argparser and list the release notes.

### 7.1. Release and versioning policy

The Argparser uses [semantic versioning (SemVer)](https://semver.org/ "semver.org") for the releases, *i.e.*, version numbers given by major version, minor version, and patch, separated by dots. There is only one supported minor version at a time (for bugfixes) to reduce developer burden, with new versions being released in strictly monotonic succession, regarding their version numbers.

Besides the SemVer version numbers, each version is assigned a codename (because why not?). Since the Argparser evolved from a very early command-line argument parser used in an analysis pipeline for Placentalia (an infraclass of mammals, precisely, the extant Eutheria), the codenames are placental mammals' species names. The major versions determine the taxonomic order, the minor version is given by the genus, and the patch version by the species name, in alphabetic order (as far as possible, *i.e.*, as long as there are species names beginning with the respective letter). For the first major series of releases, we use rodent names. So the first Argparser release, `v1.0.0`, is codenamed *"[Acomys airensis](https://en.wikipedia.org/wiki/Western_Saharan_spiny_mouse "wikipedia.org &rightarrow; Western Saharan spiny mouse")"*.

The following table lists all versions released so far:

<!-- <table caption="List of Argparser releases"> -->
*Tab. 6: List of Argparser releases.*

| Version number | Codename                         |
| -------------- | -------------------------------- |
| `v1.3.0`       | *Dasyprocta azarae*              |
| `v1.2.1`       | *Callospermophilus madrensis*    |
| `v1.2.0`       | *Callospermophilus lateralis*    |
| `v1.1.2`       | *Biswamoyopterus laoensis*       |
| `v1.1.1`       | *Biswamoyopterus gaoligongensis* |
| `v1.1.0`       | *Biswamoyopterus biswasi*        |
| `v1.0.1`       | *Acomys cahirinus*               |
| `v1.0.0`       | *Acomys airensis*                |

You can obtain the version number of your Argparser copy by querying `argparser --version`:

<!-- <include command="argparser --version" lang="console"> -->
```console
$ argparser --version
Version: argparser v1.3.0 "Dasyprocta azarae"
```
<!-- </include> -->

In the spirit of SemVer, you can then gauge the need to update to a newer Argparser version by comparing the version numbers of your copy and the latest [release](https://github.com/Simon-Brandt/ShellArgparser/releases "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Releases").

Bugfixes (increment of patch version) should be released immediately once it is confirmed that they actually fix the bug, while new features are added on a longer timescale (increment of minor version). Breaking changes (increment of major version) are kept unreleased for the longest time, trying to accumulate several changes to release them altogether. However, if a pending change severely hinders the Argparser's further development, the breaking change will be released sooner.

Breaking changes in the sense of SemVer *only* apply to modifications to the code that are expected or proven to change the Argparser's behavior in a way that can be seen by your script when normally running the Argparser. That is, a breaking change may be the modification of an environment variable's default value or an alteration of the output generated when [`ARGPARSER_WRITE_ARGS`](reference/environment_variables/environment_variables.md#9465-argparser_write_args) is set to `true`. In contrast, at least for now, the Argparser's internal state is completely hidden from a normal Argparser call. While it is possible to use the functions for your own purpose (by setting [`ARGPARSER_UNSET_FUNCTIONS`](reference/environment_variables/environment_variables.md#9447-argparser_unset_functions) to `false`), any change is considered an implementation detail, as long as the Argparser's output remains unchanged. The help, usage, version, error, and warning messages are intended for human view, and not to be parsed by scripts. Consequently, their structure and contents may change at any time.

Likewise, changes to the tests, comparison scripts, and documentation are *not* considered for assessing changes as breaking and may occur at any point. In other words, SemVer only applies to the [Argparser exectutable](../argparser), while all other files are just distributed with it under the same version number.

To simplify the transition to newer Argparser versions, it is expected to have scripts in the repository that try to flag changed behavior for your script, whenever breaking changes are made. Whether it may be possible to automatically upgrade your code to comply with the new features, strongly depends on the changes' complexity and can't be judged, here.

<!-- <include command="sed '1,20d;s/^#/###/;s/<toc>/<toc title="Table of contents (Release notes)">/' ../RELEASE_NOTES.md" md-file="../RELEASE_NOTES.md"> -->
### 7.2. Release notes

<!-- <toc title="Table of contents (Release notes)"> -->
#### Table of contents (Release notes)

1. [`v1.3.0` *"Dasyprocta azarae"*](#721-v130-dasyprocta-azarae)
1. [`v1.2.1` *"Callospermophilus madrensis"*](#722-v121-callospermophilus-madrensis)
1. [`v1.2.0` *"Callospermophilus lateralis"*](#723-v120-callospermophilus-lateralis)
1. [`v1.1.2` *"Biswamoyopterus laoensis"*](#724-v112-biswamoyopterus-laoensis)
1. [`v1.1.1` *"Biswamoyopterus gaoligongensis"*](#725-v111-biswamoyopterus-gaoligongensis)
1. [`v1.1.0` *"Biswamoyopterus biswasi"*](#726-v110-biswamoyopterus-biswasi)
1. [`v1.0.1` *"Acomys cahirinus"*](#727-v101-acomys-cahirinus)
1. [`v1.0.0` *"Acomys airensis"*](#728-v100-acomys-airensis)
<!-- </toc> -->

#### 7.2.1. `v1.3.0` *"Dasyprocta azarae"*

This is the first Shell Argparser release in the `1.3.x` series, and the eighth in the `1.x` series. This **minor release** comprises the following changes:

- New features:
  - The colorization and stylization feature has been greatly expanded, now using an optional style file (the `ARGPARSER_STYLE_FILE`). By this, elements within messages can be individually stylized, instead of only the entire message.
  - The Argparser now supports background and bright ANSI colors. Since these colors aren't supported by all terminals, you need to opt into them with an `ARGPARSER_STYLE_FILE`.
  - Messages can now be output with a frame with caption, where both can even be colored. Since this feature involves Unicode characters, you need to opt into it with an `ARGPARSER_STYLE_FILE`.
  - As a result of the much more colored default output when writing to a terminal, the Argparser now supports the `NO_COLOR` environment variable to adhere to the informal [no-color standard](https://no-color.org/ "no-color.org"). By this, the colorization can be globally disabled, but also re-enabled selectively for the Argparser by turning on `ARGPARSER_USE_STYLES`.
- Deprecations:
  - `ARGPARSER_USE_STYLES_IN_FILES` has been renamed to `ARGPARSER_USE_STYLES` with more options. The old name is still supported, but will be removed in `v2.0.0`.
  - `ARGPARSER_HELP_STYLE`, `ARGPARSER_USAGE_STYLE`, `ARGPARSER_VERSION_STYLE`, `ARGPARSER_ERROR_STYLE`, and `ARGPARSER_WARNING_STYLE` are deprecated.  Use an `ARGPARSER_STYLE_FILE` instead. The environment variables are still supported, with a marginally different visual appearance due to the message part stylization, but will be removed in `v2.0.0`.
- Other improvements:
  - The arguments definition creation now has Readline mode enabled for the prompts. This allows you to edit your input using the arrow keys, and much more.
  - Choice value ranges aren't expanded (resolved) anymore for printing, yielding clearer and terser messages.
  - Overlong error and warning messages (those exceeding `ARGPARSER_MAX_WIDTH`) are now line-wrapped.  The usage message now yields columnar output when being overlong in row-like orientation.
  - The line-wrapping algorithm now supports multiple levels of delimiters for wrapping, improving the visual appearance of&mdash;mainly&mdash;help messages.
  - The argument lookup has been sped up, yielding ca. 15&#8239;% higher performance for the entire parsing sequence.
  - The ANSI escape codes for the same style specification are now concatenated, yielding smaller files (when writing the styles to files).
  - The Argparser options are now grouped in the help message.
  - There is a new summary file, listing the release notes. These are now also included in the documentation.
  - The test suite has been expanded.

Codename: *"Dasyprocta azarae"* ([Azara's agouti](https://en.wikipedia.org/wiki/Azara%27s_agouti))

#### 7.2.2. `v1.2.1` *"Callospermophilus madrensis"*

This is the second Shell Argparser release in the `1.2.x` series, and the seventh in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where empty colors and styles could be given without error upon style checking.
  - A bug was fixed where a translation key used a duplicate name in the translation file, overriding the correct error message.
  - A bug was fixed where empty columns weren't dropped when creating the arguments definition.
- Other improvements:
  - The documentation has been slightly improved.

Codename: *"Callospermophilus madrensis"* ([Sierra Madre ground squirrel](https://en.wikipedia.org/wiki/Sierra_Madre_ground_squirrel))

#### 7.2.3. `v1.2.0` *"Callospermophilus lateralis"*

This is the first Shell Argparser release in the `1.2.x` series, and the sixth in the `1.x` series. This **minor release** comprises the following changes:

- New features:
  - Positional and keyword arguments can now be intermixed on the command line (enabled by the `--allow-arg-intermixing` flag).
  - It's now possible to selectively show/hide headings in the help message by doubling the include character.
- Bug fixes:
  - A bug was fixed in the release preparation script where the most recent Argparser version would not be given in the first place of the release table in the documentation.

Codename: *"Callospermophilus lateralis"* ([Golden-mantled ground squirrel](https://en.wikipedia.org/wiki/Golden-mantled_ground_squirrel))

#### 7.2.4. `v1.1.2` *"Biswamoyopterus laoensis"*

This is the third Shell Argparser release in the `1.1.x` series, and the fifth in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where non-flags were usable as flags when they're also given with value.

Codename: *"Biswamoyopterus laoensis"* ([Laotian giant flying squirrel](https://en.wikipedia.org/wiki/Biswamoyopterus_laoensis))

#### 7.2.5. `v1.1.1` *"Biswamoyopterus gaoligongensis"*

This is the second Shell Argparser release in the `1.1.x` series, and the fourth in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where arguments with a `+` argument count could be used as flags (without values).
  - A bug was fixed where a new version number replaced the previous versions instead of being added to the list in the issue template for bug reports.
- Other improvements:
  - The usability of the release preparation script has been improved, allowing the version numbers to start with a `v`.

Codename: *"Biswamoyopterus gaoligongensis"* ([Mount Gaoligong flying squirrel](https://en.wikipedia.org/wiki/Mount_Gaoligong_flying_squirrel))

#### 7.2.6. `v1.1.0` *"Biswamoyopterus biswasi"*

This is the first Shell Argparser release in the `1.1.x` series, and the third in the `1.x` series. This **minor release** comprises the following changes:

- New features:
  - There is a new debug mode (enabled by the `--debug` flag).
  - The arguments definition can now be created from user input (by the `--create-arg-def` flag).
- Other improvements:
  - The Argparser's command-line parsing has been changed from self-sourcing to linear function calls, simplifying the code structure.
  - The `nounset` and `pipefail` shell options are now disabled within the Argparser and don't propagate to its functions, anymore.
  - The documentation has been slightly improved.

Codename: *"Biswamoyopterus biswasi"* ([Namdapha flying squirrel](https://en.wikipedia.org/wiki/Namdapha_flying_squirrel))

#### 7.2.7. `v1.0.1` *"Acomys cahirinus"*

This is the second Shell Argparser release in the `1.0.x` series, and the second in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where some arguments could be omitted from the help message when using very narrow columns.
- Other improvements:
  - The CI now actually run the tests, instead of failing to find the test files.
  - There is a new script to simplify the preparation of releases.
  - The documentation has been slightly improved.

Codename: *"Acomys cahirinus"* ([Cairo spiny mouse](https://en.wikipedia.org/wiki/Cairo_spiny_mouse))

#### 7.2.8. `v1.0.0` *"Acomys airensis"*

This is the initial Shell Argparser release, the first in the `1.0.x` series, and the first in the `1.x` series. This **major release** comprises the following features:

- positional and keyword (option) arguments
- short and long option names
- default and choice values
- type checking
- deprecation notes
- argument assignment as variables
- help, usage, version, error, and warning messages
- localization, currently for US English and German

Codename: *"Acomys airensis"* ([Western Saharan spiny mouse](https://en.wikipedia.org/wiki/Western_Saharan_spiny_mouse))
<!-- </include> -->

### 7.3. Future enhancements

The following features are considered for addition in a future version. If you miss one, feel free to open an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues") to propose it. Note that the feature descriptions are rather open-ended collections of rough idea sketches, instead of precise milestones, so any idea may change, once a better way has been found.  Further, the implementation likelihood only means how desirable a feature seems for the Argparser, not when it will be implemented.

#### 7.3.1. Argument relations

- ***Description:*** Sometimes, multiple arguments may only be given together, or the existence of one argument mandates the existence of another one, which on itself could also be given alone. Secondly, options may contradict each other, like `--verbose` and `--quiet`, and so can only be given in an exclusive fashion on the command line. To enable this behavior, it is likely necessary to introduce another array showing the relations these arguments have. For example, some syntax like `var_a | var_b` may show contravalence (XOR) for mandatory arguments or exclusion (NAND) for optional arguments. This relation would set both arguments as mutually exclusive. Other operators, like `<-` for a prependency or `<->` for a biconditional, will need to be introduced for the aforementioned cases. However, in order to specify a minimal and clear syntax which facilitates application in scripts, and to find an optimal way of parsing, more exploratory trial work needs to be done.
- ***Implementation likelihood:*** High.

#### 7.3.2. Environment variables and configuration files

- ***Description:*** Besides command-line arguments, many programs are also configurable using environment variables and configuration files. Notably, even the Argparser itself supports them for its own options, so exposing the respective parts can provide this functionality also to Argparser-employing scripts.
- ***Implementation likelihood:*** High.

#### 7.3.3. Single-hyphen long options

- ***Description:*** On certain platforms, long options may be given with only one hyphen, sometimes exclusively, sometimes as an alternative to two hyphens. Even programs like GNU [`find`](https://man7.org/linux/man-pages/man1/find.1.html "man7.org &rightarrow; man pages &rightarrow; find(1)") act like this. However, there is a natural ambiguity whether an argument with one hyphen is a single-hyphen long option or a set of concatenated (merged) short options. Allowing single-hyphen long options would require a far more complex parsing step, when an argument with one hyphen is interpreted as long option, as long as one with this name exists, or as a set of short options, else (if allowed at all).
- ***Implementation likelihood:*** Medium.

#### 7.3.4. Usage message include directives

- ***Description:*** Currently, for an [`ARGPARSER_USAGE_FILE`](reference/environment_variables/environment_variables.md#9449-argparser_usage_file), only the [`@All`](reference/include_directives.md#931-all-directive) [include directive](reference/include_directives.md#93-include-directives) is supported. Should there be demand to provide more fine-grained control, more directives could be added.
- ***Implementation likelihood:*** Medium.

#### 7.3.5. License note

- ***Description:*** Usually, a [version message](tutorial/version_messages.md#58-version-messages) indicates the script's license, or at least gives a note about the lack of warranty for functionality of free software. The Argparser instead only gives the script's name (the [`ARGPARSER_SCRIPT_NAME`](reference/environment_variables/environment_variables.md#9438-argparser_script_name)) and the version number (the [`ARGPARSER_VERSION_NUMBER`](reference/environment_variables/environment_variables.md#9461-argparser_version_number)). Adding the dummy text for the warranty is easy, but would mean that any script employing the Argparser would indentify itself as free software. This would also hold for the (highly discouraged) proprietary software that may use the Argparser, thus misleading the users. Therefore, some environment variable may be needed to control the addition.  
Moreover, it could be even deemed useful to add a `-l,--license` flag to the default options, which would output an `ARGPARSER_LICENSE_FILE`'s contents, showing the exact license&mdash;or just its name?
- ***Implementation likelihood:*** Medium.

#### 7.3.6. Programmable argument completion

- ***Description:*** When typing long option names on the command line, without wanting or being allowed to abbreviate the names, hitting `TAB` could auto-complete the option name using programmable completion. However, the complexity and benefits of such a feature still need to be figured out.
- ***Implementation likelihood:*** Medium/Low.

#### 7.3.7. POSIX compliance

- ***Description:*** POSIX allows very few constructs for argument parsing, like no long options. Since there are perfectly suitable alternatives for this simple parsing, and the Argparser aims at a way more sophisticated command-line interface, opt-in POSIX compliance seems unnecessary for now.
- ***Implementation likelihood:*** Low.

#### 7.3.8. Alternative option prefixes (`+`/`/`)

- ***Description:*** On certain platforms, options are given with other prefixes, like `/` on DOS-like systems. The Argparser targets Unix-like platforms, and allowing other characters would require a massive change to the codebase. Further, plus signs are used as tokens for flag negation, so for using them as regular prefixes, the hyphen would take their role. More importantly, there is no such equivalent for the forward slash&mdash;a backslash would feel most natural, but would collide with the path separator on DOS-like platforms. Considering the massive efforts needed to implement this, it is unlikely to ever be done.
- ***Implementation likelihood:*** Almost zero.

### 7.4. Known bugs

*Currently none.*

### 7.5. Deprecations and removals

Upon developing the Argparser, breaking changes are inevitable. Obeying [SemVer](https://semver.org/ "semver.org"), the following breaking changes are currently under way:

- Deprecations with removal in `v2.0.0`:
  - [`ARGPARSER_USE_STYLES_IN_FILES`](reference/environment_variables/environment_variables.md#9459-argparser_use_styles_in_files) has been replaced by [`ARGPARSER_USE_STYLES`](reference/environment_variables/environment_variables.md#9458-argparser_use_styles) in `v1.3.0`, which now also offers disabling message stylizations for terminals or both terminals and files. The old behavior of `ARGPARSER_USE_STYLES_IN_FILES` (with `true` and `false` as possible values) can be accessed by setting `ARGPARSER_USE_STYLES` to `always` (`true`) or `tty` (`false`), respectively.
  - [`ARGPARSER_HELP_STYLE`](reference/environment_variables/environment_variables.md#9430-argparser_help_style), [`ARGPARSER_USAGE_STYLE`](reference/environment_variables/environment_variables.md#9455-argparser_usage_style), [`ARGPARSER_VERSION_STYLE`](reference/environment_variables/environment_variables.md#9463-argparser_version_style), [`ARGPARSER_ERROR_STYLE`](reference/environment_variables/environment_variables.md#9422-argparser_error_style), and [`ARGPARSER_WARNING_STYLE`](reference/environment_variables/environment_variables.md#9464-argparser_warning_style) have been superseded by more fine-grained stylization possibilities in `v1.3.0`, optionally using an [`ARGPARSER_STYLE_FILE`](reference/environment_variables/environment_variables.md#9443-argparser_style_file). Even though the environment variables only affect the visual appearance of the help, usage, version, error, and warning messages, which are excluded from SemVer, keeping them active until `v2.0.0` does little or no harm. While deprecated, they can still be set and will override the default styles *and* the style file's styles.  
  Due to how the new styles are implemented, the visual output is not entirely identical, but close to the previous workings. Particularly, the [`ARGPARSER_SCRIPT_NAME`](reference/environment_variables/environment_variables.md#9438-argparser_script_name) is needed in all five message types, but set *via* the same message key (`script_name`). Thus, when either of `ARGPARSER_HELP_STYLE`, `ARGPARSER_USAGE_STYLE`, `ARGPARSER_VERSION_STYLE`, `ARGPARSER_ERROR_STYLE`, or `ARGPARSER_WARNING_STYLE`, in this order, is set, its style definition overrides the latter ones' for the script name. Further, the help style overrides the usage style, if both are given, since they also share all message keys.

[&#129092;&nbsp;6.5. Summary](comparison/summary.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[8. Contribution guide&nbsp;&#129094;](contribution_guide.md)
