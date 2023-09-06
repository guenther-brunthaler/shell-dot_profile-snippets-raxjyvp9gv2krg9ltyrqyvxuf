#! /bin/false
# v2023.215
#
# Inserts bin directory for additional system-wide binaries into $PATH.

set -- \
	--append /home/admdevel/bin \
	--append /home/group/admdevel/bin \
	--append /home/project/admdevel/bin \
	--stop ${1+"$@"}
. ~/.profile.d/shellrc/libexec/path_hyec3v5m8kd1vjs8k7d1wce62.sh
