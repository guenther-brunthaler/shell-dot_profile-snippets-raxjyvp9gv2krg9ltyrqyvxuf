#! /bin/false
# Add "xworld"-site "man"-path directories to $MANPATH.
#
# Version 2020.109
# Copyright (c) 2019-2020 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

pro_rWB858IAc1YUcQZ9628WWkgWP=$HOME/.cache/manpath.env

{
	test -f "$pro_rWB858IAc1YUcQZ9628WWkgWP" || (

# Create $pro_rWB858IAc1YUcQZ9628WWkgWP.
set -e
cachedir=`dirname -- "$pro_rWB858IAc1YUcQZ9628WWkgWP"`
test -d "$cachedir" \
	|| mkdir -m700 -- "$cachedir"
exec > "$pro_rWB858IAc1YUcQZ9628WWkgWP"

if command -v lsb_release > /dev/null
then
	distro=`lsb_release -is | awk '{print tolower($0)}'`
else
	distro=
fi
if test "$distro" != debian && test -e /etc/debian_version
then
	bdistro=debian
else
	bdistro=
fi

# Workaround for bug: Command substitution does not work in nested
# HERE-DOCUMENTS in dash on armv7l (on x86 it works).
case `id -u` in 0) sbin=/sbin;; *) sbin=; esac

awk -f /dev/fd/5 5<< '---------' << =========

$0 == "" {next} # Ignore lines which became empty after expansion.

$0 == ":" {$0= ""} # Specify an empty entry which will *not* be igored.

$0 == "<---" {
	# Finish group definition, replace previous group.
	for (i in g) delete g[i]
	for (i in a) {
		g[i]= a[i]; delete a[i]
	}
	i= 0
	next
}

!(0 in g) {
	# No previous group? Just append entry to incomplete current group.
	a[i++]= $0; next
}

{
	# There is a previous group. Append a copy of all entries of the
	# previous group prefixed with the current entry to the new incomplete
	# group.
	for (j= 0; j in g; ++j) a[i++]= $0 g[j]
}

END {
	# Append entries from existing $MANPATH, but only if they are not
	# duplicates of paths already present in completed group g[].
	for (i= 0; i in g; ++i) inv[g[i]]= i
	n= split(ENVIRON["MANPATH"], a, ":")
	for (j= 1; j <= n; ++j) {
		if (!(a[j] in inv)) {
			inv[g[i]= a[j]]= i; ++i
		}
	}

	# Assemble new $MANPATH from paths in g[] which actually do exist.
	$0= ""; OFS= ":"; k= 1
	ok= system("true")
	$(k++)= ""
	for (j= 0; j < i; ++j) {
		if (g[j] == "" || system("test -d \"" g[j] "\"") == ok) {
			#print "MANPATH[" k "] = " g[j] >> "/dev/stderr"
			$(k++)= g[j]
		}
	}
	print "MANPATH_rWB858IAc1YUcQZ9628WWkgWP=\"" $0 "\""
}

---------
_internal
:
<---
/tmp
/local
/locally_merged
${distro:+/xworld_}$distro
${distro:+/}$distro
${bdistro:+/xworld_}$bdistro
${bdistro:+/}$bdistro
/xworld
:
<---
/share/man
/man
<---
$HOME
$HOME/.local
/usr/local
:
/usr
<---
=========

)
} && {
	. "$pro_rWB858IAc1YUcQZ9628WWkgWP"
	test -n "$MANPATH_rWB858IAc1YUcQZ9628WWkgWP" \
		&& export MANPATH=$MANPATH_rWB858IAc1YUcQZ9628WWkgWP
}
unset pro_rWB858IAc1YUcQZ9628WWkgWP MANPATH_rWB858IAc1YUcQZ9628WWkgWP
