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
#     --test-option-abbreviation

# Purpose: Test whether Python's argparse module supports option
# abbreviation ("--ar").

import argparse
import sys

# Parse the arguments.  The final check for the variables sets the
# test's result as exit code.
parser = argparse.ArgumentParser(exit_on_error=False)
group = parser.add_argument_group("Options")
group.add_argument(
    "--var",
    dest="var",
    metavar="VAL",
    required=True,
    type=str,
    help="long option",
)

try:
    args = parser.parse_args()
except argparse.ArgumentError:
    sys.exit(1)

if args.var == "1":
    sys.exit(0)
sys.exit(1)
