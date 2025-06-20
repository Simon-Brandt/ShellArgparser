## 2. Installation

> [!WARNING]
> The Argparser requires Bash 4.0 or higher (try `bash --version`). It is extensively tested with Bash 5.2, precisely, with `GNU bash, Version 5.2.21(1)-release (x86_64-pc-linux-gnu)`. With `BASH_COMPAT` set to `40` or higher, the [tests](../tests) still succeed, but if you encounter errors for versions earlier than 5.2, please file an [issue](https://github.com/Simon-Brandt/ShellArgparser/issues/new "github.com &rightarrow; Simon-Brandt &rightarrow; ShellArgparser &rightarrow; Issues"), such that the minimum requirement can be adjusted. For the execution (not invokation) of the Argparser, shells other than Bash aren't supported, and the Argparser aborts with an error message.

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
> Be wary not to forget the final `${PATH}` component in the above command, or else you will override the [`PATH`](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#index-PATH "gnu.org &rightarrow; Bourne Shell Variables &rightarrow; PATH")) for all future shell sessions, meaning no other (non-builtin) command will be resolvable, anymore.

[&#129092;&nbsp;`features.md`](features.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`tutorial/introduction.md`&nbsp;&#129094;](tutorial/introduction.md)
