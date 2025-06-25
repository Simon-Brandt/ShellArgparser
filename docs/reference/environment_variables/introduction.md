### 8.5. Environment variables

The Argparser defines a large set of environment variables, each following the naming pattern `"ARGPARSER_*"`. They are used to control the behavior of the argument parsing, help and usage message generation, and much more. Note that, if for some reason your script or environment is using a variable with the same name as one of the Argparser variables, the Argparser might not work as expected. If you want to be 100&#8239;% safe, you can unset any variable following the given pattern prior setting any desired Argparser variables and sourcing the Argparser&mdash;with the caveat that in turn the program that set the variable might not work, anymore.

[&#129092;&nbsp;8.4.1. `Positional arguments`](../translations/translations.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&#129094;](toc.md)
