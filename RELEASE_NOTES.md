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

# Release notes

<!-- <toc> -->
## Table of contents

1. [`v1.3.0` *"Dasyprocta azarae"*](#1-v130-dasyprocta-azarae)
1. [`v1.2.1` *"Callospermophilus madrensis"*](#2-v121-callospermophilus-madrensis)
1. [`v1.2.0` *"Callospermophilus lateralis"*](#3-v120-callospermophilus-lateralis)
1. [`v1.1.2` *"Biswamoyopterus laoensis"*](#4-v112-biswamoyopterus-laoensis)
1. [`v1.1.1` *"Biswamoyopterus gaoligongensis"*](#5-v111-biswamoyopterus-gaoligongensis)
1. [`v1.1.0` *"Biswamoyopterus biswasi"*](#6-v110-biswamoyopterus-biswasi)
1. [`v1.0.1` *"Acomys cahirinus"*](#7-v101-acomys-cahirinus)
1. [`v1.0.0` *"Acomys airensis"*](#8-v100-acomys-airensis)
<!-- </toc> -->

## 1. `v1.3.0` *"Dasyprocta azarae"*

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

## 2. `v1.2.1` *"Callospermophilus madrensis"*

This is the second Shell Argparser release in the `1.2.x` series, and the seventh in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where empty colors and styles could be given without error upon style checking.
  - A bug was fixed where a translation key used a duplicate name in the translation file, overriding the correct error message.
  - A bug was fixed where empty columns weren't dropped when creating the arguments definition.
- Other improvements:
  - The documentation has been slightly improved.

Codename: *"Callospermophilus madrensis"* ([Sierra Madre ground squirrel](https://en.wikipedia.org/wiki/Sierra_Madre_ground_squirrel))

## 3. `v1.2.0` *"Callospermophilus lateralis"*

This is the first Shell Argparser release in the `1.2.x` series, and the sixth in the `1.x` series. This **minor release** comprises the following changes:

- New features:
  - Positional and keyword arguments can now be intermixed on the command line (enabled by the `--allow-arg-intermixing` flag).
  - It's now possible to selectively show/hide headings in the help message by doubling the include character.
- Bug fixes:
  - A bug was fixed in the release preparation script where the most recent Argparser version would not be given in the first place of the release table in the documentation.

Codename: *"Callospermophilus lateralis"* ([Golden-mantled ground squirrel](https://en.wikipedia.org/wiki/Golden-mantled_ground_squirrel))

## 4. `v1.1.2` *"Biswamoyopterus laoensis"*

This is the third Shell Argparser release in the `1.1.x` series, and the fifth in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where non-flags were usable as flags when they're also given with value.

Codename: *"Biswamoyopterus laoensis"* ([Laotian giant flying squirrel](https://en.wikipedia.org/wiki/Biswamoyopterus_laoensis))

## 5. `v1.1.1` *"Biswamoyopterus gaoligongensis"*

This is the second Shell Argparser release in the `1.1.x` series, and the fourth in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where arguments with a `+` argument count could be used as flags (without values).
  - A bug was fixed where a new version number replaced the previous versions instead of being added to the list in the issue template for bug reports.
- Other improvements:
  - The usability of the release preparation script has been improved, allowing the version numbers to start with a `v`.

Codename: *"Biswamoyopterus gaoligongensis"* ([Mount Gaoligong flying squirrel](https://en.wikipedia.org/wiki/Mount_Gaoligong_flying_squirrel))

## 6. `v1.1.0` *"Biswamoyopterus biswasi"*

This is the first Shell Argparser release in the `1.1.x` series, and the third in the `1.x` series. This **minor release** comprises the following changes:

- New features:
  - There is a new debug mode (enabled by the `--debug` flag).
  - The arguments definition can now be created from user input (by the `--create-arg-def` flag).
- Other improvements:
  - The Argparser's command-line parsing has been changed from self-sourcing to linear function calls, simplifying the code structure.
  - The `nounset` and `pipefail` shell options are now disabled within the Argparser and don't propagate to its functions, anymore.
  - The documentation has been slightly improved.

Codename: *"Biswamoyopterus biswasi"* ([Namdapha flying squirrel](https://en.wikipedia.org/wiki/Namdapha_flying_squirrel))

## 7. `v1.0.1` *"Acomys cahirinus"*

This is the second Shell Argparser release in the `1.0.x` series, and the second in the `1.x` series. This **patch release** comprises the following changes:

- Bug fixes:
  - A bug was fixed where some arguments could be omitted from the help message when using very narrow columns.
- Other improvements:
  - The CI now actually run the tests, instead of failing to find the test files.
  - There is a new script to simplify the preparation of releases.
  - The documentation has been slightly improved.

Codename: *"Acomys cahirinus"* ([Cairo spiny mouse](https://en.wikipedia.org/wiki/Cairo_spiny_mouse))

## 8. `v1.0.0` *"Acomys airensis"*

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
