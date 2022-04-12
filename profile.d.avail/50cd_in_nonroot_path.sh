#! /bin/false
# v2022.101.1
#
# Adds the current directory at the end of the $PATH
# but only if the current user is not the superuser.

if test "$EUID" != 0 && test "$USER" != root
then
	set -- \
		--append . \
		--stop ${1+"$@"}
	. ~/.profile.d/shellrc/libexec/path_hyec3v5m8kd1vjs8k7d1wce62.sh
fi
