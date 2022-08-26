#! /bin/false
# Export $SHELL. Set to /bin/sh if invalid.
#
# Version 2022.238

case $- in
	*i*) ;;
	*) return
esac

if
	case $SHELL in
		'') ;;
		/*) false
	esac || test ! -x "$SHELL"
then
	SHELL=/bin/sh
fi
export SHELL
