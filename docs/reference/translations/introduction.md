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

### 9.5. Translations

In order to facilitate translators the translation of the Argparser-generated strings, most importantly the error and warning messages, and including the interpolated variables, they are listed here for reference, sorted by their occurrence in the provided [translations.yaml](../../../resources/translations.yaml). Further, this should give an overview over the most likely reasons for argument parsing failures.

> [!NOTE]
> The translation keys in the simplified [YAML](https://en.wikipedia.org/wiki/YAML "wikipedia.org &rightarrow; YAML") file are subject to change, if messages are added or removed. Since missing keys only generate warnings (which can even be silenced using [`ARGPARSER_SILENCE_WARNINGS`](../environment_variables/environment_variables.md#9440-argparser_silence_warnings)), such changes are *not* considered breaking changes, and by this would *not* lead to an increase in the Argparser's major version number. However, as few modifications as possible are anticipated; and only when other breaking changes are introduced, larger refactorings should occur.

[&#129092;&nbsp;9.4.2. `ARGPARSER_ADD_HELP`](../environment_variables/environment_variables.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Table of contents (Translations)&nbsp;&#129094;](toc.md)
