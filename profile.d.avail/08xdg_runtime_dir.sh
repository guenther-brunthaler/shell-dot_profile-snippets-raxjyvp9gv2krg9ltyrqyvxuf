#! /bin/sh
# Set up $XDG_RUNTIME_DIR (unless already set).

# Version 2022.55
# Copyright (c) 2019-2022 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

L_3qunzp66f5emuf5xvt9avr6qy=${XDG_DATA_HOME:-"$HOME"/.local/share}
mkdir -p -- "$L_3qunzp66f5emuf5xvt9avr6qy"
L_3qunzp66f5emuf5xvt9avr6qy=$L_3qunzp66f5emuf5xvt9avr6qy/`
		:
	`xdg_runtime_dir-ngjjaq42wb5238hup1bmwjtpp.d

if test "$XDG_RUNTIME_DIR" && test -d "$XDG_RUNTIME_DIR"
then
	eq_3qunzp66f5emuf5xvt9avr6qy=maybe
else
	if
		test -L "$L_3qunzp66f5emuf5xvt9avr6qy" \
		&& test -d "$L_3qunzp66f5emuf5xvt9avr6qy"
	then
		XDG_RUNTIME_DIR=`readlink -- "$L_3qunzp66f5emuf5xvt9avr6qy"`
		eq_3qunzp66f5emuf5xvt9avr6qy=true
	else
		XDG_RUNTIME_DIR=`id -u`
		XDG_RUNTIME_DIR=`mktemp -d -- "${TMPDIR:-/tmp}/run-\`:
			\`$XDG_RUNTIME_DIR".XXXXXXXXXX`
		eq_3qunzp66f5emuf5xvt9avr6qy=false
	fi
fi
export XDG_RUNTIME_DIR

if test "$eq_3qunzp66f5emuf5xvt9avr6qy" = maybe
then
	if
		test -L "$L_3qunzp66f5emuf5xvt9avr6qy" \
		&& test "`readlink -- "$L_3qunzp66f5emuf5xvt9avr6qy"`" \
			== "$XDG_RUNTIME_DIR"
	then
		eq_3qunzp66f5emuf5xvt9avr6qy=true
	else
		eq_3qunzp66f5emuf5xvt9avr6qy=false
	fi
fi
if test $eq_3qunzp66f5emuf5xvt9avr6qy = false
then
	ln -snf -- "$XDG_RUNTIME_DIR" "$L_3qunzp66f5emuf5xvt9avr6qy"
fi

test -w "$L_3qunzp66f5emuf5xvt9avr6qy" || unset XDG_RUNTIME_DIR

unset L_3qunzp66f5emuf5xvt9avr6qy eq_3qunzp66f5emuf5xvt9avr6qy
