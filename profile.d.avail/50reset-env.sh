# Start with a fresh shell environment as if just logged in.
# Version 2020.50.1

alias reset-env="`
	a='exec env -i'
	while read e
	do
		eval \"ena=\\\${\$e+true}\"
		eval \"test \\\"\\\$\$e\\\" || ena=\"
		case \$ena in
			'') ;;
			*) a=\"\$a \$e=\\\"\\\$\$e\\\"\"
		esac
	done <<- EOF
		DBUS_SESSION_BUS_ADDRESS
		DISPLAY
		HOME
		LANG
		LANGUAGE
		LC_ADDRESS
		LC_ALL
		LC_COLLATE
		LC_CTYPE
		LC_IDENTIFICATION
		LC_MEASUREMENT
		LC_MESSAGES
		LC_MONETARY
		LC_NAME
		LC_NUMERIC
		LC_PAPER
		LC_TELEPHONE
		LC_TIME
		SSH_AUTH_SOCK
		TERM
	EOF
	case \$SHELL in
		'') unset SHELL;;
		*) command -v \"\$SHELL\" > /dev/null 2>& 1 || unset SHELL
	esac
	case \${SHELL+true} in
		'') a=\"\$a /bin/sh\";;
		*) a=\"\$a \\\"\\\$SHELL\\\"\"
	esac
	echo \"\$a -l\"
`"
