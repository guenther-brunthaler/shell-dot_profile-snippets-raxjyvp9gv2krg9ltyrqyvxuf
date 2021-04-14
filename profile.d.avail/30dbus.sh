#! /bin/false
# v2021.104

while :
do
	test -f /usr/bin/dbus-daemon || break
	case $XDG_RUNTIME_DIR in
		'') break
	esac
	test -d "$XDG_RUNTIME_DIR" || break
	test ! -d "$XDG_RUNTIME_DIR"/session-dbus \
		&& mkdir -- "$XDG_RUNTIME_DIR"/session-dbus
	while :
	do
		test -e "$XDG_RUNTIME_DIR"/session-dbus/pid \
			&& test -s "$XDG_RUNTIME_DIR"/session-dbus/pid \
			&& kill -0 `cat < "$XDG_RUNTIME_DIR"\`:
				\`/session-dbus/pid` \
			&& break
		> "$XDG_RUNTIME_DIR"/session-dbus/pid
		> "$XDG_RUNTIME_DIR"/session-dbus/addr
		/usr/bin/dbus-daemon \
			--syslog --fork --session \
			--address="unix:path=$XDG_RUNTIME_DIR`:
				`/session-dbus/socket" \
			--print-address=5 --print-pid=6 \
			5> "$XDG_RUNTIME_DIR"/session-dbus/addr \
			6> "$XDG_RUNTIME_DIR"/session-dbus/pid
		while :
		do
			test -s "$XDG_RUNTIME_DIR"/session-dbus/pid \
				&& kill -0 `cat < "$XDG_RUNTIME_DIR"\`:
					\`/session-dbus/pid` \
				&& break
			sleep 1
		done
		break
	done
	while :
	do
		read -r DBUS_SESSION_BUS_ADDRESS \
			< "$XDG_RUNTIME_DIR"/session-dbus/addr
		case $DBUS_SESSION_BUS_ADDRESS in
			'') sleep 1;;
			*) break
		esac
	done
	export DBUS_SESSION_BUS_ADDRESS
	return
done
unset DBUS_SESSION_BUS_ADDRESS
