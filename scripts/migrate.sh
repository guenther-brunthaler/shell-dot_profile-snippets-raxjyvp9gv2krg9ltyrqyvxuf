#! /bin/sh
# Migrate the user's current profile.d to using the new repository
# where THIS script is a part of.
#
# Version 2020.12.1
# Copyright (c) 2020 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

main=$HOME/.profile
pdbase=.profile.d
plink=shellrc
olink=site
tag_dir=profile.d.avail

set -e
cleanup() {
	rc=$?
	test "$T" && rm -- "$T"
	test $rc = 0 || echo "\"$0\" failed!" >& 2
}
T=
trap cleanup 0
trap 'exit $?' INT TERM QUIT HUP

while getopts '' opt
do
	case $opt in
		*) false || exit
	esac
done
shift `expr $OPTIND - 1 || :`

test $# = 0

pd=$HOME/$pdbase
test -d "$pd"

me=$0
test -f "$me"
case $me in
	/*) ;;
	*) me=`pwd`/$me; test -f "$me"
esac
tgt=`dirname -- "$me"`
while test ! -d "$tgt/$tag_dir"
do
	t=`dirname -- "$tgt"`
	test "$t" != "$tgt"
	tgt=$t
done

echo "shellrc directory is '$tgt'"

if
	test -d "$pd/$plink" \
		&& test "`readlink -f -- "$pd/$plink"`" \
			= "`readlink -f -- "$tgt"`"
then
	:
else
	ln -snf -- "$tgt" "$pd/$plink"
	echo "Please make '$pd/$plink' into a relative link!"
fi

find -H "$pd" -type l \
| while read -r sl
do
	ot=`readlink -- "$sl"`
	case $ot in
		"$plink"/*) test -e "$sl" && continue;;
		/* | ../*) continue
	esac
	nt=$plink/${ot#*/}
	test -e "$pd/$nt"
	echo "Migrating '$sl'..."
	ln -snf -- "$nt" "$sl"
done

if test -e "$main"
then
	T=`mktemp -- "${TMPDIR:-/tmp}/${0##*/}.XXXXXXXXXX"`
	p1='~/'$pdbase
	p2='$HOME/'$pdbase
	p3='"$HOME"/'$pdbase
	sed "
		s|$p1/$olink/|$p1/$plink/|g
		s|$p2/$olink/|$p2/$plink/|g
		s|$p3/$olink/|$p3/$plink/|g
	" < "$main" > "$T"
	if cmp -s "$main" "$T"
	then
		:
	else
		echo "Updating '$main':"
		diff -u -- "$main" "$T" || :
		cat < "$T" > "$main"
	fi
fi

echo && { tr '\n' ' ' <<- EOF && echo; } | fold -sw 66
	Migration finished - remove any references to the previous shared
	repository and convert any left-over absolute symbolic links into
	relative ones.
EOF
