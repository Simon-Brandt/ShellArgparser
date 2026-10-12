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
#     --test-usage-message

# Purpose: Test whether Python's argparse module creates a usage
# message.

import argparse
import sys

# Set the arguments.  Instead of parsing them, directly create the usage
# message.  Only the final check for the variables sets the test's
# result as exit code.
parser = argparse.ArgumentParser(color=False)
group = parser.add_argument_group("Options")
group.add_argument(
    "-v",
    dest="var",
    metavar="VAL",
    required=True,
    type=str,
    help="short option",
)

actual_output = parser.format_usage()
expected_output = "usage: test_argparse.py [-h] -v VAL"

if actual_output.startswith(expected_output):
    sys.exit(2)  # Indicate partial support for feature.
sys.exit(1)
