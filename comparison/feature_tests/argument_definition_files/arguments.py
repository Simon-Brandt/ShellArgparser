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

# Usage: Import this module from test_argparse.py.

# Purpose: Define the arguments for the argument definition file test.

import argparse

def create_argparser(*args: str):
    parser = argparse.ArgumentParser(exit_on_error=False)
    group = parser.add_argument_group("Options")

    if "var" in args:
        group.add_argument(
            "-v",
            dest="var",
            metavar="VAL",
            required=True,
            type=str,
            help="short option",
        )

    return parser
