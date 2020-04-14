#! /bin/sh

case $- in
	*i*) ;;
	*) return
esac
if { command -v tput && tput setaf 2>& 5; } 5>& 2 > /dev/null 2>& 1
then
	PS1='\n\[\033[1;3'`
		case \`id -u\` in
			0) echo 1;;
			*) echo 2
		esac
	`'m\]\u@\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]'`:
		`'\n\[\033[37;41m\]${?#0}\[\033[1;40;34m\]$\[\033[0m\] '
else
	PS1='\n\u@\h \w\n${?#0}$ '
fi
export PS1
