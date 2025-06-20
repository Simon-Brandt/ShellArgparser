#### 4.2.5. Argparser

<details open>

<summary>Contents of <code>argparser_wrapper.sh</code></summary>

<!-- <include command="sed '3,10d;/shellcheck/d' ../comparison/argparser_wrapper.sh" lang="bash"> -->
```bash
#!/bin/bash

# Parse the arguments.
args=(
    "id       | short_opts | long_opts | val_names   | defaults | choices | type | arg_no | arg_group            | help                                                            "
    "in_file  |            |           | source      |          |         | file | 1      | Positional arguments | the template HTML file to fill in                               "
    "out_file |            |           | destination |          |         | file | 1      | Positional arguments | the output HTML file                                            "
    "name     | n          | name      | NAME        |          |         | str  | 1      | Mandatory options    | the name of the homepage's owner                                "
    "age      | a          | age       | AGE         |          |         | uint | 1      | Mandatory options    | the current age of the homepage's owner                         "
    "role     | r          | role      | ROLE        |          | u,m,b   | char | 1      | Mandatory options    | the role of the homepage's owner (u: user, m: moderator, b: bot)"
    "verbose  | v          | verbose   |             | false    |         | bool | 0      | Optional options     | output verbose information                                      "
)
source argparser -- "$@"

# Set the role to its long form.
case "${role}" in
    u) role="User" ;;
    m) role="Moderator" ;;
    b) role="Bot" ;;
esac

# Run the HTML processor.
if [[ "$0" == */* ]]; then
    cd "${0%/*.sh}" || exit 1
fi
source process_html_template.sh
```
<!-- </include> -->

</details>

Example calls:

```bash
# Long options.
bash argparser_wrapper.sh --verbose --name="A. R. G. Parser" --age=2 --role=b -- template.html argparser.html

# Short options.
bash argparser_wrapper.sh -v -n "A. R. G. Parser" -a 2 -r b -- template.html argparser.html

# Leading positional arguments.
bash argparser_wrapper.sh template.html argparser.html -v -n "A. R. G. Parser" -a 2 -r b

# Positional arguments delimiter "++".
bash argparser_wrapper.sh -v -n "A. R. G. Parser" -- template.html argparser.html ++ -a 2 -r b

# Help, usage, and version messages.
bash argparser_wrapper.sh --help
bash argparser_wrapper.sh --usage
bash argparser_wrapper.sh --version
```

Notes:

- Trailing positional arguments must be delimited with `--` since the Argparser aggregates all values after option names to them, as design decision.
- Intermixing positional and keyword arguments can be emulated by using the positional arguments delimiter `++`. True intermixing is yet disabled as design decision.

[&#129092;&nbsp;`docopts.md`](docopts.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`../summary.md`&nbsp;&#129094;](../summary.md)
