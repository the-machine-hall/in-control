#!/bin/bash

_action="off"
_pduPort="../config/power-source"

# Where am I really located?
# Adapted from comments on http://stackoverflow.com/a/246128
_scriptDir=$( dirname $( readlink -f "$0" ) )

${_scriptDir}/${_pduPort}/controls/${_action}

exit

