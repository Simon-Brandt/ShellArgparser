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

## 2. Installation

> [!WARNING]
> The Argparser requires Bash&nbsp;4.4 or higher (try `bash --version`). It is extensively tested with Bash&nbsp;5.2, precisely, with `GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`. With containerized Bash versions &ge;&#8239;4.4, the [tests](../tests) still succeed, but if you encounter errors for versions earlier than 5.2, please file an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues"), such that the minimum requirement can be adjusted, or the bug fixed. For the execution (not invocation) of the Argparser, shells other than Bash aren't supported, and the Argparser aborts with an error message.

No actual installation is necessary, as the Argparser is just a Bash script that can be located in an arbitrary directory of your choice, like `/usr/local/bin`. Thus, the "installation" is as simple as cloning the repository in this very directory:

```bash
# Switch to the installation directory of your choice, e.g., /usr/local/bin.
cd /path/to/directory

# Clone the repository.
git clone https://github.com/Simon-Brandt/ShellArgparser.git
```

To be able to refer to the Argparser directly by its name, without providing the entire path (which enhances the portability of your script to other machines), you may want to add

```bash
PATH="/path/to/ShellArgparser:${PATH}"
```

(replace the `/path/to` with your actual path) to either of the following files (see `info bash` or `man bash`):

- `~/.profile` (local addition, for login shells)
- `~/.bashrc` (local addition, for non-login shells)
- `/etc/profile` (global addition, for login shells)
- `/etc/bash.bashrc` (global addition, for non-login shells)

> [!CAUTION]
> Be wary not to forget the final `${PATH}` component in the above command, or else you will override the [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH") for all future shell sessions, meaning no other (non-builtin) command will be resolvable, anymore.

[&#129092;&nbsp;1. Features](features.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3. Dependencies&nbsp;&#129094;](dependencies.md)
