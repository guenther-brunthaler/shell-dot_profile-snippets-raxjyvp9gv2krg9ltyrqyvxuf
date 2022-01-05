# Load $SSH_AUTH for long-running ssh-agent only for current shell and only
# when alias (for "set ssh") is invoked for current shell.
#
# v2022.5

alias sssh='. ~/.profile.d/shellrc/profile.d.avail/50ssh-agent-until-shutdown.sh'
