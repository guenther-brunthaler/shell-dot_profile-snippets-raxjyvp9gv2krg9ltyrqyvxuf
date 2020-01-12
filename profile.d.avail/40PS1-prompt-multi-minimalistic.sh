#! /bin/sh
# Set up a multi-line prompt where the current host, user and directory are
# shown in an individual line. The prompt in the current line is minimalstic -
# just the prompt character, optionally prefixed with the return code of the
# last command (only if not successful) and a space. This avoids making the
# shell prompt part in the line containing the cursor too long in case of a
# long current directory path. It also makes the current line perfect for
# pasting unchanged into e-mails for sending shell instructions to someone.
#
# Version 2020.12
#
# Copyright (c) 2020 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

case $- in
	*i*) ;;
	*) return
esac

if test -x /usr/bin/tput && tput setaf > /dev/null 2>& 1
then
	PS1='\n\[\033[1;3'`
		case \`id -u\` in
			0) echo 1;;
			*) echo 2
		esac
	`'m\]\u@\h\[\033[34m\]:\[\033[0m\] '
	PS1=$PS1'\[\033[0;33m\]\w\[\033[0m\]\n'
	PS1=$PS1'\[\033[37;41m\]${?#0}\[\033[1;40;34m\]\$\[\033[0m\] '
else
	PS1='\n\u@\h: \w\n'
	PS1=$PS1'${?#0}\$ '
fi
