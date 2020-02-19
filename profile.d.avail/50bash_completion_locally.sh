#! /bin/false
# Re-enable bash completions for local usage only.
# Version 2020.50

test -z "$BASH_VERSION" && return

# The "/etc/profile.d" script provides a configuration file hook that can be
# used to prevent loading "bash_completion" on per user basis when it's
# installed system wide. To do this:

: echo 'mkdir -p -- "${XDG_CONFIG_HOME:=$HOME/.config}"'
: echo 'echo shopt -u progcomp >> "$XDG_CONFIG_HOME"/bash_completion'
#sed 's/^: //; t; d' $THIS_SNIPPET_FILE | sh | sh -x

# Turn it back on (for example in `~/.bashrc`) if you want to use
# programmable completion for other purposes.
shopt -s progcomp
