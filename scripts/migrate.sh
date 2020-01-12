#! /bin/sh
# Migrate the user's current profile.d to using the new repository
# where THIS script is a part of.
#
# Version 2020.12
# Copyright (c) 2020 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

tag_dir=profile.d.avail
pd=$HOME/.profile.d
plink=shellrc

set -e
trap 'test $? = 0 || echo "\"$0\" failed!" >& 2' 0

while getopts '' opt
do
	case $opt in
		*) false || exit
	esac
done
shift `expr $OPTIND - 1 || :`

test $# = 0

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
echo && { tr '\n' ' ' <<- EOF && echo; } | fold -sw 66
	Migration finished - remove any references to the previous shared
	repository and convert any left-over absolute symbolic links into
	relative ones.
EOF
