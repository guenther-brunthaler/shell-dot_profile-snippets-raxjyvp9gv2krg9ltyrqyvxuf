#! /bin/false
# Add "xworld"-site binary directories to $PATH.
#
# Version 2020.141
# Copyright (c) 2019-2020 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

pro_rWB858IAc1YUcQZ9628WWkgWP=$HOME/.cache/profile.vars

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
	# Append entries from existing $PATH, but only if they are not
	# duplicates of paths already present in completed group g[].
	for (i= 0; i in g; ++i) inv[g[i]]= i
	n= split(ENVIRON["PATH"], a, ":")
	for (j= 1; j <= n; ++j) {
		if (!(a[j] in inv)) {
			inv[g[i]= a[j]]= i; ++i
		}
	}

	# Assemble new $PATH from paths in g[] which actually do exist.
	$0= ""; OFS= ":"; k= 1
	ok= system("true")
	for (j= 0; j < i; ++j) {
		if (g[j] == "" || system("test -d \"" g[j] "\"") == ok) {
			#print "PATH[" k "] = " g[j] >> "/dev/stderr"
			$(k++)= g[j]
		}
	}
	print "PATH_rWB858IAc1YUcQZ9628WWkgWP=\"" $0 "\""
}

---------
<---
/internal
/tmp
/local
/locally_merged
${distro:+/}$distro
${bdistro:+/}$bdistro
:
<---
/xworld
:
<---
$sbin
/bin
<---
$HOME
$HOME/.local
/usr/local
:
/usr
<---
=========
# In the definitions above, $PATH will be assembled by group first
# (separated by "<--" where later groups have higher priority) and by line
# within the group next (where earlier lines have higher priority). The last
# group is special: It specifies all possible starting prefixes for $PATH
# entries. (Those prefixes will NOT be attempted to be added to $PATH on
# their own.)

)
} && {
	. "$pro_rWB858IAc1YUcQZ9628WWkgWP"
	test -n "$PATH_rWB858IAc1YUcQZ9628WWkgWP" \
		&& export PATH=$PATH_rWB858IAc1YUcQZ9628WWkgWP
}
unset pro_rWB858IAc1YUcQZ9628WWkgWP PATH_rWB858IAc1YUcQZ9628WWkgWP
