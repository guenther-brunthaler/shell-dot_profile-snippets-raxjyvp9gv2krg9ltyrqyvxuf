# Overrides the system default editor with "vim".
#
# If you *really* prefer nano, comment out the lines below.
# But then again, who does?
#
# Version 2022.4
# Copyright (c) 2019-2022 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

if test -f /usr/bin/vim
then
	EDITOR=/usr/bin/vim
fi

VISUAL=$EDITOR
export EDITOR VISUAL
