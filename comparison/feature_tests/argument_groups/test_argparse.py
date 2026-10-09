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
# Last Modification: 2026-10-09

# Usage: Run this script from test_features.sh as
# bash test_features.sh \
#     --test-argparse \
#     --test-argument-groups

# Purpose: Test whether Python's argparse module supports argument
# groups.

import argparse
import contextlib
import io
import sys

# Parse the arguments.  Capture `sys.stdout` with the help message and
# suppress the `SystemExit` raised by `argparse` when the `-h`/`--help`
# flag is passed.  Only the final check for the variables sets the
# test's result as exit code.
parser = argparse.ArgumentParser(exit_on_error=False)
group = parser.add_argument_group("Options")
group.add_argument(
    "-v",
    dest="var",
    metavar="VAL",
    required=True,
    type=str,
    help="short option",
)

io_buffer = io.StringIO()
with contextlib.redirect_stdout(io_buffer):
    try:
        parser.parse_args()
    except SystemExit:
        pass

if "Options:" in io_buffer.getvalue():
    sys.exit(0)
sys.exit(1)
