#!/bin/sh
set -e
# shellcheck disable=SC1091
. ./test/env.sh
# This test tries to install the "conditional_symlinks" module in which
# there are two modules, one that should be linked because the variable
# DO_LINK is set and another that should not be linked because DO_NOT_LINK
# is empty
$COVERAGE ./pont.sh -q conditional_symlinks

# Assertions
sync
[ -e "$PONT_TARGET/dolinkme" ] ||
	{ echo "Allowed conditional not linked"; exit 1; }
[ ! -e "$PONT_TARGET/dontlinkme" ] ||
 	{ echo "Disallowed conditional linked"; exit 1; }
