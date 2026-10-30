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
#     --test-mutually-exclusive-arguments

# Purpose: Test whether Python's argparse module supports mutually
# exclusive arguments.

import argparse
import sys

# Parse the arguments.  Suppress the provoked `argparse.ArgumentError`.
# Only the final check for the variables sets the test's result as exit
# code.
parser = argparse.ArgumentParser(exit_on_error=False)
group = parser.add_argument_group("Options")
exclusive_group = group.add_mutually_exclusive_group(required=True)
exclusive_group.add_argument(
    "-a",
    dest="var_a",
    action="store_true",
    help="flag",
)
exclusive_group.add_argument(
    "-b",
    dest="var_b",
    action="store_true",
    help="flag",
)

try:
    args = parser.parse_args()
except argparse.ArgumentError as error:
    if "argument -b: not allowed with argument -a" in str(error):
        sys.exit(0)
sys.exit(1)
