#! /bin/false
# Add "xworld"-site binary directories to $PATH.
#
# Version 2020.57
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

{
	echo "One-time \$PATH initialization..."; echo
	if command -v lsb_release > /dev/null
	then
		distro=`lsb_release -is | awk '{print tolower($0)}'`
		echo "Linux distribution suffix: $distro"
	else
		distro=
	fi
	if test "$distro" != debian && test -e /etc/debian_version
	then
		bdistro=debian
		echo "Base Linux distribution suffix: $bdistro"
	else
		bdistro=
	fi
	echo; echo "Testing path permutations as possible \$PATH directories."
	echo "This will take a while - please wait ..."
} >& 2
uid=`id -u`

set --
pfxlen=0
while read d
do
	case $d in
		'') continue;; # Ignore empty (after expansion) entries.
		:) d=;; # A verbatim empty entry which will not be ignored.
		+) shift $pfxlen; pfxlen=$#; continue # End of group.
	esac
	case $pfxlen in
		0) set -- "$@" "$d";;
		*)
			i=0 # Append $d to a copy of all prefixes.
			while test $i != $pfxlen
			do
				j=0 # Put copy of ${i}th argument into $x.
				while test $j != $#
				do
					c=$1; shift; set -- "$@" "$c"
					test $i = $j && x=$c
					j=`expr $j + 1`
				done
				# Append a copy of the current entry to all
				# members of the last group.
				set -- "$@" "$x$d"; i=`expr $i + 1`
				printf . >& 2
			done
		esac
done << EOF
$HOME
$HOME/.local
/usr/local
:
/usr
+
`case $uid in 0) echo /sbin; esac`
/bin
+
:
/tmp
/local
/locally_merged
/xworld
`case $distro in '') ;; *) echo /xworld_$distro; esac`
${distro:+/}$distro
`case $bdistro in '') ;; *) echo /xworld_$bdistro; esac`
${bdistro:+/}$bdistro
+
:
_internal
+
EOF

# Remove permuted paths which do not actually exist.
i=0
while test $i != $#
do
	if test -d "$1"
	then
		set -- "$@" "$1"
		: echo "PATH entry '$1'" >& 2
		i=`expr $i + 1`
	fi
	shift
done

# Append entries from existing $PATH, but only if they actually exist and are
# not duplicates of paths already added earlier.
r=$PATH
while test "$r"
do
	c=${r%%:*}
	case $c in
		"$r") r=;;
		*) r=${r#"$c:"}
	esac
	i=0; j=
	while test $i != $#
	do
		case $1 in "$c") j=$i; esac
		set -- "$@" "$1"; shift
		i=`expr $i + 1`
	done
	case $j in '') ;; *) continue; esac
	test ! -d "$c" && continue
	set -- "$@" "$c"
	: echo "PATH entry '$c' (from old \$PATH)" >& 2
done

# Assemble new $PATH.
npath=
for c
do
	npath=$npath${npath:+:}$c
done

{
	echo " finished."; echo
	echo "Updating \$PATH cache '$pro_rWB858IAc1YUcQZ9628WWkgWP'."
	echo "Delete this cache file in order to enforce a re-scan."
} >& 2
echo "PATH_rWB858IAc1YUcQZ9628WWkgWP=\"$npath\""

)
} && {
	. "$pro_rWB858IAc1YUcQZ9628WWkgWP"
	test -n "$PATH_rWB858IAc1YUcQZ9628WWkgWP" \
		&& export PATH=$PATH_rWB858IAc1YUcQZ9628WWkgWP
}
unset pro_rWB858IAc1YUcQZ9628WWkgWP PATH_rWB858IAc1YUcQZ9628WWkgWP
