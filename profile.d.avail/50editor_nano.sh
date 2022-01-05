# Overrides the system default editor with "nano".
#
# If you *really* prefer nano, comment out the lines below.
# But then again, who does?
#
# Version 2022.5
# Copyright (c) 2022 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

if test -f /usr/bin/nano
then
	EDITOR=/usr/bin/nano
fi

VISUAL=$EDITOR
export EDITOR VISUAL
