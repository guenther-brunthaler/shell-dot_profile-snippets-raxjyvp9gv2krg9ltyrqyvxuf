# Searches for and connects to a running ssh-agent for the current user for
# all sessions of that user until the machine is shut down.
#
# Does not care about gpg-agent. (Which is dubious anyway because it saves all
# private keys only weakly encrypted with AES-128 into a normal directory.)
#
# v2022.4

command -v ssh-agent > /dev/null 2>& 1 || return
test -d "$XDG_RUNTIME_DIR" || return

f_8cns6zzm9653up08mq3zc5r3z=$XDG_RUNTIME_DIR/\
ssh-agent-until-shutdown-8cns6zzm9653up08mq3zc5r3z.nfo

r_8cns6zzm9653up08mq3zc5r3z=
while :
do
	exec 9>> "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=w9:$r_8cns6zzm9653up08mq3zc5r3z
	flock -w 5 -s 9 || break
	r_8cns6zzm9653up08mq3zc5r3z=rL:$r_8cns6zzm9653up08mq3zc5r3z
	exec 5< "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=r5:$r_8cns6zzm9653up08mq3zc5r3z
	read SSH_AGENT_PID <& 5 || break
	expr x"$SSH_AGENT_PID" : x'[1-9][0-9]*$' > /dev/null || break
	kill -0 $SSH_AGENT_PID 2> /dev/null || break
	IFS= read -r SSH_AUTH_SOCK <& 5 || break
	test "$SSH_AUTH_SOCK" \
		= "`cksum /proc/$SSH_AGENT_PID/cmdline 2> /dev/null`" || break
	IFS= read -r SSH_AUTH_SOCK <& 5 || break
	test -S "$SSH_AUTH_SOCK" || break
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
	ssh-agent > "$f_8cns6zzm9653up08mq3zc5r3z" 2> /dev/null || break
	(
		unset SSH_AGENT_PID SSH_AUTH_SOCK
		. "$f_8cns6zzm9653up08mq3zc5r3z" > /dev/null || exit
		test "$SSH_AGENT_PID" || exit
		kill -0 $SSH_AGENT_PID 2> /dev/null || exit
		cs=`cksum /proc/$SSH_AGENT_PID/cmdline 2> /dev/null` || exit
		test -S "$SSH_AUTH_SOCK" || exit
		printf '%s\n%s\n%s\n' \
			"$SSH_AGENT_PID" "$cs" "$SSH_AUTH_SOCK" \
			> "$f_8cns6zzm9653up08mq3zc5r3z" \
		|| exit
	) || break
	exec 5< "$f_8cns6zzm9653up08mq3zc5r3z" || break
	r_8cns6zzm9653up08mq3zc5r3z=r5.2:$r_8cns6zzm9653up08mq3zc5r3z
	read SSH_AGENT_PID <& 5 || break
	IFS= read -r SSH_AUTH_SOCK <& 5 || break
	IFS= read -r SSH_AUTH_SOCK <& 5 || break
	r_8cns6zzm9653up08mq3zc5r3z=Suc:$r_8cns6zzm9653up08mq3zc5r3z
	break
done
case $r_8cns6zzm9653up08mq3zc5r3z in
	*r5.2:*) exec 5<& -
esac
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

unset f_8cns6zzm9653up08mq3zc5r3z r_8cns6zzm9653up08mq3zc5r3z
