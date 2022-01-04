# Overrides the system default editor with "ne".
#
# If you *really* prefer nano, comment out the lines below.
# But then again, who does?
#
# Version 2022.4
# Copyright (c) 2019-2022 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

if test -f /usr/bin/ne
then
	EDITOR=/usr/bin/ne
fi

VISUAL=$EDITOR
export EDITOR VISUAL
