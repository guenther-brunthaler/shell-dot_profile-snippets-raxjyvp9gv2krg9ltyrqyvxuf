# Searches for and connects to a running ssh-agent for the current user for
# all sessions of that user until the machine is shut down.
#
# Does not care about gpg-agent. (Which is dubious anyway because it saves all
# private keys only weakly encrypted with AES-128 into a normal directory.)
#
# The $SSH_AUTH_SOCK will be created at a fixed location as required by
# programs like "keepassxc" for the ssh-agent's socket.
#
# v2022.59

command -v ssh-agent > /dev/null 2>& 1 || return
test -d "$HOME" || return

SSH_AUTH_SOCK=${XDG_CACHE_HOME:-"$HOME"/.cache}
test -d "$SSH_AUTH_SOCK" || mkdir -- "$SSH_AUTH_SOCK"
SSH_AUTH_SOCK=$SSH_AUTH_SOCK\
/ssh-agent-until-shutdown-8cns6zzm9653up08mq3zc5r3z.socket

if test "$XDG_RUNTIME_DIR" && test -d "$XDG_RUNTIME_DIR"
then
	f_8cns6zzm9653up08mq3zc5r3z=$XDG_RUNTIME_DIR
else
	f_8cns6zzm9653up08mq3zc5r3z=${XDG_CACHE_HOME:-"$HOME"/.cache}
fi
f_8cns6zzm9653up08mq3zc5r3z=$f_8cns6zzm9653up08mq3zc5r3z\
/ssh-agent-until-shutdown-8cns6zzm9653up08mq3zc5r3z.nfo

r_8cns6zzm9653up08mq3zc5r3z=
while :
do
	exec 9>> "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=w9:$r_8cns6zzm9653up08mq3zc5r3z
	test -S "$SSH_AUTH_SOCK" || break
	flock -w 5 -s 9 || break
	r_8cns6zzm9653up08mq3zc5r3z=rL:$r_8cns6zzm9653up08mq3zc5r3z
	exec 5< "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=r5:$r_8cns6zzm9653up08mq3zc5r3z
	read SSH_AGENT_PID <& 5 || break
	expr x"$SSH_AGENT_PID" : x'[1-9][0-9]*$' > /dev/null || break
	kill -0 $SSH_AGENT_PID 2> /dev/null || break
	IFS= read -r c_8cns6zzm9653up08mq3zc5r3z <& 5 || break
	test "$c_8cns6zzm9653up08mq3zc5r3z" \
		= "`cksum /proc/$SSH_AGENT_PID/cmdline 2> /dev/null`" \
	|| break
	r_8cns6zzm9653up08mq3zc5r3z=Suc:$r_8cns6zzm9653up08mq3zc5r3z
	break
done
case $r_8cns6zzm9653up08mq3zc5r3z in
	*r5:*) exec 5<& -
esac
case $r_8cns6zzm9653up08mq3zc5r3z in
	*rL:*) flock -u 9
esac
while :
do
	case $r_8cns6zzm9653up08mq3zc5r3z in
		*Suc:*) break;;
		*w9:*) ;;
		*) break
	esac
	flock -w 5 9 || break
	r_8cns6zzm9653up08mq3zc5r3z=wL:$r_8cns6zzm9653up08mq3zc5r3z
	rm -f -- "$SSH_AUTH_SOCK"
	ssh-agent -a "$SSH_AUTH_SOCK" \
		> "$f_8cns6zzm9653up08mq3zc5r3z" 2> /dev/null \
	|| break
	(
		unset SSH_AGENT_PID SSH_AUTH_SOCK
		. "$f_8cns6zzm9653up08mq3zc5r3z" > /dev/null || exit
		test "$SSH_AGENT_PID" || exit
		kill -0 $SSH_AGENT_PID 2> /dev/null || exit
		cs=`cksum /proc/$SSH_AGENT_PID/cmdline 2> /dev/null` || exit
		test -S "$SSH_AUTH_SOCK" || exit
		printf '%s\n%s\n' "$SSH_AGENT_PID" "$cs" \
			> "$f_8cns6zzm9653up08mq3zc5r3z" \
		|| exit
	) || break
	read SSH_AGENT_PID < "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=Suc:$r_8cns6zzm9653up08mq3zc5r3z
	break
done
case $r_8cns6zzm9653up08mq3zc5r3z in
	*Suc:*wL:*) ;;
	*wL:*) > "$f_8cns6zzm9653up08mq3zc5r3z"
esac
case $r_8cns6zzm9653up08mq3zc5r3z in
	*wL:*) flock -u 9
esac
case $r_8cns6zzm9653up08mq3zc5r3z in
	*w9:*) exec 9>& -
esac
case $r_8cns6zzm9653up08mq3zc5r3z in
	*Suc:*) export SSH_AGENT_PID SSH_AUTH_SOCK;;
	*) unset SSH_AGENT_PID SSH_AUTH_SOCK
esac

unset f_8cns6zzm9653up08mq3zc5r3z c_8cns6zzm9653up08mq3zc5r3z \
	r_8cns6zzm9653up08mq3zc5r3z
