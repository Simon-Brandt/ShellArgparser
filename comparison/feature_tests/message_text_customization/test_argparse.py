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
# Last Modification: 2026-10-14

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-argparse \
#     --test-message-text-customization

# Purpose: Test whether Python's argparse module supports customizing
# the message text.

import argparse
import contextlib
import io
import pathlib
import sys
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from _typeshed import SupportsWrite

# Parse the arguments.  Capture `sys.stdout` with the help message and
# suppress the `SystemExit` raised by `argparse` when the `-h`/`--help`
# flag is passed.  Only the final check for the variables sets the
# test's result as exit code.
def _print_message(
    message: str,
    file: SupportsWrite[str] | None = None,
) -> None:
    filepath = pathlib.Path(__file__).parent / "help_message_argparse.txt"
    with open(filepath, mode="r", encoding="utf-8") as help_file:
        if file:
            file.write(help_file.read())

parser = argparse.ArgumentParser(exit_on_error=False)
parser._print_message = _print_message
group = parser.add_argument_group("Options")
group.add_argument(
    "-v",
    dest="var",
    metavar="VAL",
    required=True,
    type=str,
    help="short option",
)

with contextlib.redirect_stdout(io.StringIO()) as io_buffer:
    with contextlib.suppress(SystemExit):
        parser.parse_args()

actual_output = io_buffer.getvalue()

filepath = pathlib.Path(__file__).parent / "help_message_argparse.txt"
with open(filepath, mode="r", encoding="utf-8") as file:
    expected_output = file.read()

if actual_output == expected_output:
    sys.exit(0)
sys.exit(1)
