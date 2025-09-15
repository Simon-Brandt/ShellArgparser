#!/usr/bin/env bash

###############################################################################
#                                                                             #
# Copyright 2025 Simon Brandt                                                 #
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
# Last Modification: 2025-09-15

# Usage: Run this script with "bash prepare_release.sh".

# Purpose: Prepare a release for the Argparser.

# Define the arguments.
# shellcheck disable=SC2190  # Indexed, not associative array.
declare codename
declare version_number
args=(
    "id             | val_names      | type | arg_no | arg_group            | help                  "
    "version_number | version_number | str  | 1      | Positional arguments | the version number    "
    "codename       | codename       | str  | 1      | Positional arguments | the version's codename"
)
source argparser -- "$@"

# Strip the leading "v" from the version number, if erroneously given
# with it.
version_number="${version_number#v}"

# Define the pattern and replacement text for the modification date.
# Both are always the same, unlike the patterns for the version info.
pattern_date='# Last Modification: 20[0-9]{2}-[0-9]{2}-[0-9]{2}'
printf -v replacement_date '# Last Modification: %(%F)T' -1

# Replace the modification date and version info in the Argparser.
pattern_version='argparser_version="[1-9][0-9]*\.[0-9]+\.[0-9]+ '
pattern_version+='\\"[[:alpha:]]+ [[:alpha:]]+\\""'
replacement_version='argparser_version="'"${version_number}"
replacement_version+=' \\"'"${codename}"'\\""'
sed --in-place --regexp-extended \
    --expression="s/${pattern_date}/${replacement_date}/" \
    --expression="s/${pattern_version}/${replacement_version}/" \
    argparser

# Replace the modification date and version info in the test suite.
pattern_version='argparser v[1-9][0-9]*\.[0-9]+\.[0-9]+ '
pattern_version+='"[[:alpha:]]+ [[:alpha:]]+"'
replacement_version='argparser v'"${version_number}"' "'"${codename}"'"'
sed --in-place --regexp-extended \
    --expression="s/${pattern_date}/${replacement_date}/" \
    --expression="s/${pattern_version}/${replacement_version}/" \
    tests/run_tests.sh

# Add the version info to the list of Argparser releases in the issue
# template for bugs.
pattern_version='        - v[1-9][0-9]*\.[0-9]+\.[0-9]+ "[[:alpha:]]+ '
pattern_version+='[[:alpha:]]+"'
replacement_version='        - v'"${version_number}"' "'"${codename}"'"'
sed --in-place --regexp-extended \
    --expression="0,/${pattern_version}/s//${replacement_version}\n&/" \
    .github/ISSUE_TEMPLATE/bug.yaml

# Add the version info to the list of Argparser releases in the
# documentation and replace the version info for the exemplary --version
# call.
pattern_version_1='\| v[1-9][0-9]*\.[0-9]+\.[0-9]+ *\| '
pattern_version_1+='\*[[:alpha:]]+ [[:alpha:]]+\* \|'
replacement_version_1='| v'"${version_number}"' | *'"${codename}"'* |'

pattern_version_2='argparser v[1-9][0-9]*\.[0-9]+\.[0-9]+ '
pattern_version_2+='"[[:alpha:]]+ [[:alpha:]]+"'
replacement_version_2='argparser v'"${version_number}"' "'"${codename}"'"'

sed --in-place --regexp-extended \
    --expression="0,/${pattern_version_1}/s//${replacement_version_1}\n&/" \
    --expression="s/${pattern_version_2}/${replacement_version_2}/" \
    docs/.src.md
