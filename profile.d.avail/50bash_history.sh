#! /bin/false
# Version 2020.50

if test -n "$BASH_VERSION"
then
	# Enable time stamps in bash history.
	export HISTTIMEFORMAT="{%F %T} "
	shopt -s histreedit histverify

	# don't put duplicate lines or lines starting with space in the
	# history. See bash(1) for more options
	HISTCONTROL=ignoreboth

	# append to the history file, don't overwrite it
	shopt -s histappend

	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	export HISTSIZE=1000
	export HISTFILESIZE=2000
fi
