#! /bin/false
# Version 2019.286

if test -n "$BASH_VERSION"
then
	# If not running interactively, don't do anything further.
	case $- in
	    *i*)
		# check the window size after each command and, if necessary,
		# update the values of LINES and COLUMNS.
		shopt -s checkwinsize

		if test -f ~/.bash_aliases
		then
			. ~/.bash_aliases
		fi
	esac

	if test -f ~/.bashrc
	then
		# Finally, source ~/.bashrc too.
		. ~/.bashrc
	fi
fi
