### 4.7. Help and usage message localization

It is even possible to localize your script's help and usage message. For the usage message, all you need is an [`ARGPARSER_TRANSLATION_FILE`](../reference/environment_variables/environment_variables.md#8542-argparser_translation_file), a simplified YAML file giving the translation of the auto-generated parts in the messages. For each section, you give the language identifier for the language you want the message to be translated to, *i.e.*, the [`ARGPARSER_LANGUAGE`](../reference/environment_variables/environment_variables.md#8529-argparser_language). For the usage message, this suffices, but in the help message, also non-auto-generated parts are included, especially each argument's help text. For them to be translated, you need a dedicated [`ARGPARSER_ARG_DEF_FILE`](../reference/environment_variables/environment_variables.md#8510-argparser_arg_def_file) and possibly a localized [`ARGPARSER_HELP_FILE`](../reference/environment_variables/environment_variables.md#8524-argparser_help_file).

If you set these environment variables to files whose filename contains the language, like so:

<!-- <include command="ls -1 ../resources/arguments_*.csv ../resources/help_message_*.txt" lang="console"> -->
```console
$ ls -1 ../resources/arguments_*.csv ../resources/help_message_*.txt
../resources/arguments_de.csv
../resources/arguments_en.csv
../resources/help_message_de.txt
../resources/help_message_en.txt
```
<!-- </include> -->

then, in your script, you can set the `ARGPARSER_ARG_DEF_FILE` and `ARGPARSER_HELP_FILE` accordingly, as in our new script `try_localization.sh`. There, we dynamically extract the language as the first two characters of the `LANG` (or, alternatively, `LC_ALL` or `LANGUAGE`) environment variable. Its value is defined as the language, the country or territory, and the codeset, like `"en_US.UTF-8"` or `"de_DE.UTF-8"`.

<details open>

<summary>Contents of <code>try_localization.sh</code></summary>

<!-- <include command="sed '3,11d;/shellcheck/d' ../tutorial/try_localization.sh" lang="bash"> -->
```bash
#!/bin/bash

# Set the Argparser, reading the arguments definition, help message, and
# translation from a file.
dir="$(dirname "$(readlink --canonicalize-existing "$0")")"
dir="$(readlink --canonicalize-existing "${dir}/../resources/")"
ARGPARSER_ARG_DEF_FILE="${dir}/arguments_${LANG::2}.csv"
ARGPARSER_HELP_FILE="${dir}/help_message_${LANG::2}.txt"
ARGPARSER_LANGUAGE="${LANG::2}"
ARGPARSER_TRANSLATION_FILE="${dir}/translation.yaml"

# Set the arguments.
args=(
    id
    pos_1
    pos_2
    var_1
    var_2
    var_3
    var_4
    var_5
    var_6
    var_7
)
source argparser -- "$@"
```
<!-- </include> -->

</details>

You need to manually translate the arguments definition (only the argument groups and the help texts) in the new arguments definition file:

<!-- <include command="cat ../resources/arguments_de.csv" lang="console"> -->
```console
$ cat ../resources/arguments_de.csv
id    | short_opts | long_opts | val_names | defaults | choices | type | arg_no | arg_group              | notes      | help
pos_1 |            |           | pos_1     | 2        | 1,2     | int  | 1      | Positionale Argumente  |            | ein positionales Argument mit Vorgabe und Auswahl
pos_2 |            |           | pos_2     |          |         | int  | 2      | Positionale Argumente  |            | zwei positionale Argumente ohne Vorgabe oder Auswahl
var_1 | a          | var-1     | VAL_1     |          |         | uint | 1      | Erforderliche Optionen |            | ein Wert ohne Vorgabe oder Auswahl
var_2 | b          | var-2     | VAL_2     |          |         | int  | +      | Erforderliche Optionen |            | mindestens ein Wert ohne Vorgabe oder Auswahl
var_3 | c          | var-3     | VAL_3     |          | A,B     | char | +      | Erforderliche Optionen |            | mindestens ein Wert mit Auswahl
var_4 | d          |           | VAL_4     | A        | A,B,C   | char | 1      | Optionale Optionen     |            | ein Wert mit Vorgabe und Auswahl
var_5 |            | var-5     | VAL_5     | E        |         | str  | 1      | Optionale Optionen     |            | ein Wert mit Vorgabe
var_6 | f          | var-6     | VAL_6     | false    |         | bool | 0      | Optionale Optionen     |            | kein Wert (Flag) mit Vorgabe
var_7 | g          | var-7     | VAL_7     | true     |         | bool | 0      | Optionale Optionen     | deprecated | kein Wert (Flag) mit Vorgabe
```
<!-- </include> -->

The same is necessary for the printable part of the help file:

<!-- <include command="sed '1,14d' ../resources/help_message_de.txt" lang="console"> -->
```console
$ sed '1,14d' ../resources/help_message_de.txt
# Print the header.
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
@Header

# Print the positional arguments.
Die folgenden Argumente sind positional.
@Positionale Argumente

# Print the options from the "Erforderliche Optionen" group.
Die folgenden Optionen haben keinen Vorgabewert.
@Erforderliche Optionen

# Print the options from the "Optionale Optionen" group.
Die folgenden Optionen haben einen Vorgabewert.
@Optionale Optionen

# Print the three help options.
Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
@Help
```
<!-- </include> -->

Finally, we need a translation file for the auto-generated parts. Note that here, only the German locale is used, while you may want to add further rows if your target users come from multiple countries.

<details open>

<summary>Beginning of <code>translation.yaml</code></summary>

<!-- <include command="sed '1,4d;80q' ../resources/translation.yaml" lang="yaml"> -->
```yaml
# 1.    Define the translations for the arguments parsing.
---
Positional arguments:
  en: Positional arguments
  de: Positionale Argumente

Help options:
  en: Help options
  de: Hilfsoptionen

Error:
  en: Error
  de: Fehler

Warning:
  en: Warning
  de: Warnung
...

# 2.    Define the translations for help messages.
# 2.1.  Define the translations for the usage line (part of the header).
---
Usage:
  en: Usage
  de: Aufruf

Arguments:
  en: ARGUMENTS
  de: ARGUMENTE

Options:
  en: OPTIONS
  de: OPTIONEN
...

# 2.2.  Define the translations for the remark (part of the header).
---
Mandatory arguments:
  en: >
    Mandatory arguments to long options are mandatory for short options too.
  de: >
    Erforderliche Argumente für lange Optionen sind auch für kurze
    erforderlich.
...

# 2.3.  Define the translations for the help column.
---
Deprecated:
  en: DEPRECATED
  de: VERALTET

Default:
  en: default
  de: Vorgabe

--help:
  en: display this help and exit
  de: diese Hilfe anzeigen und beenden

--usage:
  en: display the usage and exit
  de: den Aufruf anzeigen und beenden

--version:
  en: display the version and exit
  de: die Version anzeigen und beenden

false:
  en: false
  de: falsch

true:
  en: true
  de: wahr
...
```
<!-- </include> -->

</details>

Regarding the structure of the simplified and strictly line-oriented YAML file, the groups used as identifiers for the translations are given without indentation, followed by a colon. This creates a key in an associative array. The respective value is another associative array, this time holding the translation, with the language identifier as key and the translated string as value. The key must be indented by exactly two spaces, followed by a colon and another space. Then, either the translation can be given or a greater-than sign (`">"`). All lines given afterwards that are indented by exactly four spaces are concatenated and used as translated string. In the translation, you can (and should) use the format specifier `$n`, with $n \in \{1, 2, 3, 4\},$ to denote the $n$-th position that the Argparser should use for the interpolation with variable values, which cannot be directly given in the translation.

You can optionally add line comments, though not in-line comments, and structure the file using empty lines or YAML blocks with three hyphens (`"---"`) or three dots (`"..."`). Since the purpose of the YAML file is to store a translation, not to serialize arbitrary data, more advanced features (like JSON-like in-line associative arrays) aren't supported by the Argparser, and an error is thrown for unrecognized structures.

If a group identifier is missing, the Argparser will emit a warning if and only if the state which uses the translation is reached, most commonly when the user requests the help message. In order not to miss a key, you can simply re-use the YAML file provided with the Argparser.

Now, the Argparser is given the arguments definition, help, and translation file for the current locale. Thus, the help message can be generated in localized form, according to the user's `LANG`.

You might also want to set the locale only for your script upon invokation from another script. Then, just prefix the invokation with the desired locale for the `LANG` variable. By this, you limit the effect of changing to the script call (just as we did above for the Argparser environment variables):

```console
$ LANG=en_US.UTF-8 bash try_localization.sh --help
...
$ LANG=de_DE.UTF-8 bash try_localization.sh --help
...
```

The former command prints the American English help message, the latter its German translation, as you can see in full detail, here:

<!-- <include command="LANG=de_DE.UTF-8 bash ../tutorial/try_localization.sh -h" lang="console"> -->
```console
$ LANG=de_DE.UTF-8 bash ../tutorial/try_localization.sh -h
Eine kurze Kopfzeile fasst zusammen, wie die Hilfe-Meldung zu interpretieren
ist.
Aufruf: try_localization.sh [OPTIONEN] ARGUMENTE -- [pos_1] pos_2

Erforderliche Argumente für lange Optionen sind auch für kurze erforderlich.

Die folgenden Argumente sind positional.
Positionale Argumente:
[pos_1={1,2}]         ein positionales Argument mit Vorgabe und Auswahl
                      (Vorgabe: 2)
pos_2                 zwei positionale Argumente ohne Vorgabe oder Auswahl

Die folgenden Optionen haben keinen Vorgabewert.
Erforderliche Optionen:
-a,   --var-1=VAL_1   ein Wert ohne Vorgabe oder Auswahl
-b,   --var-2=VAL_2   mindestens ein Wert ohne Vorgabe oder Auswahl
-c,   --var-3={A,B}   mindestens ein Wert mit Auswahl

Die folgenden Optionen haben einen Vorgabewert.
Optionale Optionen:
[-d={A,B,C}]          ein Wert mit Vorgabe und Auswahl (Vorgabe: "A")
      [--var-5=VAL_5] ein Wert mit Vorgabe (Vorgabe: "E")
[-f], [--var-6]       kein Wert (Flag) mit Vorgabe (Vorgabe: falsch)
[-g], [--var-7]       (VERALTET) kein Wert (Flag) mit Vorgabe (Vorgabe: wahr)

Es gibt grundsätzlich drei Optionen für die Hilfe-Meldungen.
[-h,  [--help]        diese Hilfe anzeigen und beenden (Vorgabe: falsch)
-?],
[-u], [--usage]       den Aufruf anzeigen und beenden (Vorgabe: falsch)
[-V], [--version]     die Version anzeigen und beenden (Vorgabe: falsch)
```
<!-- </include> -->

Likewise, the usage message is localized:

<!-- <include command="LANG=de_DE.UTF-8 bash ../tutorial/try_localization.sh -u" lang="console"> -->
```console
$ LANG=de_DE.UTF-8 bash ../tutorial/try_localization.sh -u
Aufruf: try_localization.sh [-h,-? | -u | -V] [-d={A,B,C}] [-f] [-g] [--var-5=VAL_5] -a=VAL_1 -b=VAL_2... -c={A,B}... [{1,2}] pos_2
```
<!-- </include> -->

[&#129092;&nbsp;4.6. Help and usage message files](help_and_usage_message_files.md)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4.8. Version messages&nbsp;&#129094;](version_messages.md)
