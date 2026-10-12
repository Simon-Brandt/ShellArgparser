#!/usr/bin/env python3

###############################################################################
#                                                                             #
# Copyright 2026 Simon Brandt                                                 #
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

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2026-10-12

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-argparse \
#     --test-internationalization-localization

# Purpose: Test whether Python's argparse module supports
# internationalization/localization.

import argparse
import contextlib
import gettext
import io
import pathlib
import sys

# Parse the arguments.  Capture `sys.stdout` with the translated help
# message and suppress the `SystemExit` raised by `argparse` when the
# `-h`/`--help` flag is passed.  Only the final check for the variables
# sets the test's result as exit code.
locale_dir = pathlib.Path(__file__).parent / "translations_argparse"
translation = gettext.translation(
    domain="translations",
    localedir=locale_dir,
    languages=["de"],
)
argparse._ = translation.gettext  # type: ignore
argparse.ngettext = translation.ngettext  # type: ignore

parser = argparse.ArgumentParser(exit_on_error=False)
group = parser.add_argument_group(translation.gettext("Options"))
group.add_argument(
    "-v",
    dest="var",
    metavar="VAL",
    required=True,
    type=str,
    help=translation.gettext("short option"),
)

with contextlib.redirect_stdout(io.StringIO()) as io_buffer:
    with contextlib.suppress(SystemExit):
        parser.parse_args()

actual_output = io_buffer.getvalue()
expected_output = """\
Aufruf: test_argparse.py [-h] -v VAL

Optionen
  -h, --help  diese Hilfsnachricht anzeigen und beenden

Optionen
  -v VAL      kurze Option
"""

if actual_output == expected_output:
    sys.exit(0)
sys.exit(1)
