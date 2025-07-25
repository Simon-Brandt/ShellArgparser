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

### 6.2. Example scripts

The example scripts assume a made-up use case, where we want to parse a command line for an HTML template processor.

Imagine us operating a webserver running a discussion forum. When users registrate *via* the web interface, on our server, a script runs that maps the clicks from the client-side GUI to the server-side CLI by converting the buttons to command-line arguments. Then, another script uses this command line to create a new user on our system.

We want to create a brief homepage for the user, listing his name, age, and role on our forum. The name can be about anything, the age shall be an integer, and the role be either "user", "moderator", or "bot". For the sake of simplicity, we abbreviate this to "u", "m", and "b" on the command line.

Consequently, our script requires these three parameters. Since it is implemented as very simple HTML template processor that just fills in some missing values, we need the path to the template file, and the path to the output. Further, for debugging and/or logging purposes, we want an optional verbose output to `STDOUT`, indicating what is being done. Finally, we want a help and a usage message to remind us on the script's interface, and a version message to be able to reason about regressions and improvements over time.

This gives us nine arguments our script shall handle. As the number of expected command-line arguments increases, it becomes more and more unwieldy to pass them just as positional arguments&mdash;after all, we would need to remember their order anytime we run the script, or call the help message beforehand. Additionally, we could not omit arguments, not even the help or usage message calling, without making the parsing ambiguous. Consequently, we choose keyword arguments for all but the filepaths, which we decide to keep positional, with the source file coming before the target file.

Thus, the command-line parser we choose needs to support both positional and keyword arguments, optional and mandatory arguments, flags (for the verbosity), data types (for the age), and choice values (for the role). We can now decide to implement the parsing steps by hand, or use an existing program or library for the task. Still, parsing steps that the program doesn't support need to be implemented by us.

The following scripts perform this parsing, and shall give you an overview about the complexity of command-line parsing with the existing tools compared to the Argparser. Keep an eye on the code's length and readability.

The actual HTML template processing is done in [`process_html_template.sh`](../../../comparison/process_html_template.sh), which is [sourced](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-source "gnu.org &rightarrow; Bash Builtins &rightarrow; source") by each script to guarantee identity among all scripts. In a real-world scenario, both parts (the command-line parsing and template processing) would likely be in the same file.

Note that the scripts implement one more option, `-e`/`--exit`. This facilitates the scripts' abortion before running the HTML processor to compare the actual [runtime](../runtime_comparison.md#63-runtime-comparison) of the command-line parser, below, and not include the [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html "man7.org &rightarrow; man pages &rightarrow; sed(1)") steps in the HTML processor.

[&#129092;&nbsp;6.1. Feature comparison](../feature_comparison.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[6.2.1. `getopts`&nbsp;&#129094;](getopts.md)
