#! /bin/false
# Invokes the "xd" utility from a package such as xd/utils/debian in order
# to quickly change the current directory.
#
# v2021.89
if command -v xd > /dev/null 2>& 1
then
	xd() { cd -- "`command xd -- ${1+"$@"}`"; }
fi
