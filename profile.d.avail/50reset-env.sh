# Start with a fresh shell environment as if just logged in.
# Version 2020.50

alias reset-env="`
	a='exec env -i'
	for e in TERM HOME LANG LANGUAGE
	do
		eval \"ena=\\\${\$e+true}\"
		eval \"test \\\"\\\$\$e\\\" || ena=\"
		case \$ena in
			'') ;;
			*) a=\"\$a \$e=\\\"\\\$\$e\\\"\"
		esac
	done
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
