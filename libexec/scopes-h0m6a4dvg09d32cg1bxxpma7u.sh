#! /bin/false
# POSIX-compliant portable replacement for the "local"-extension of many
# shells.
#
# Version 2022.101
#
# Copyright (c) 2022 Guenther Brunthaler. All rights reserved.
#
# This shell script snippet is free software.
# Distribution is permitted under the terms of the LGPLv3.

case ${defined_h0m6a4dvg09d32cg1bxxpma7u+true} in
	true) return;;
esac

# The portable "local"-replacement is also much more powerful because it
# provides a destructor-like "finally" mechanism.
#
# It works like this: Start a logical scope by calling
# "scope_h0m6a4dvg09d32cg1bxxpma7u". A good place for this is the beginning of
# a shell function (but it can really be done anywhere). Then declare as many
# variables with "var_h0m6a4dvg09d32cg1bxxpma7u" as you like and/or use
# "finally_h0m6a4dvg09d32cg1bxxpma7u" to queue any number of cleanup commands
# to be executed later. "Declaring" variables will queue destructors for
# restoring the old values later. When you are done, call
# "unwind_h0m6a4dvg09d32cg1bxxpma7u" at the end of the logical scope (such as
# before leaving a function. This will restore all the original variable
# values and also execute all the "finally_h0m6a4dvg09d32cg1bxxpma7u"
# destructors.
#
# Note that
# "scope_h0m6a4dvg09d32cg1bxxpma7u"/"unwind_h0m6a4dvg09d32cg1bxxpma7u" can be
# nested to arbitrary depth. Functions using scope_h0m6a4dvg09d32cg1bxxpma7u
# can thus call other functions using their own
# scope_h0m6a4dvg09d32cg1bxxpma7u.
#
# Arguments for a destructor may be pushed onto the stack using
# pushvar_h0m6a4dvg09d32cg1bxxpma7u() and push_h0m6a4dvg09d32cg1bxxpma7u()
# before queueing the destructor itself with
# finally_h0m6a4dvg09d32cg1bxxpma7u(). The destructor can then pop the pushed
# values off the stack (in reverse order) with
# popvar_h0m6a4dvg09d32cg1bxxpma7u() and use them.
#
# pushvar_h0m6a4dvg09d32cg1bxxpma7u() is more efficient than
# push_h0m6a4dvg09d32cg1bxxpma7u(). Use push_h0m6a4dvg09d32cg1bxxpma7u() only
# if the value to be pushed onto the stack is not already stored within some
# variable.
#
# At the end of your script, call shutdown_scopes_h0m6a4dvg09d32cg1bxxpma7u().
# This is not strictly necessary but recommended. It verifies that no one
# forgot to call unwind_h0m6a4dvg09d32cg1bxxpma7u(). Never "return" without
# calling unwind_h0m6a4dvg09d32cg1bxxpma7u() first from within a
# scope_h0m6a4dvg09d32cg1bxxpma7u inside a function!
# shutdown_scopes_h0m6a4dvg09d32cg1bxxpma7u() also unsets all global variables
# set and functions defined by THIS script snippet, which means the scope
# framework functions cannot be called any longer.
#
# Not all functions need to use
# scope_h0m6a4dvg09d32cg1bxxpma7u/unwind_h0m6a4dvg09d32cg1bxxpma7u. Only such
# functions which need local variables or destructor functionality should do
# so.
#

# Provides: scopes-h0m6a4dvg09d32cg1bxxpma7u
# Requires: trap_errors-3vnzcvh9hfs134g6ln6cy567k

# Push value of variable with name $1 onto the stack.
pushvar_h0m6a4dvg09d32cg1bxxpma7u() {
	eval stk_h0m6a4dvg09d32cg1bxxpma7u_$sp_h0m6a4dvg09d32cg1bxxpma7u=\$$1
	sp_h0m6a4dvg09d32cg1bxxpma7u=`expr $sp_h0m6a4dvg09d32cg1bxxpma7u + 1`
}
sp_h0m6a4dvg09d32cg1bxxpma7u=1

# Pop variable with name $1 off the stack.
popvar_h0m6a4dvg09d32cg1bxxpma7u() {
	sp_h0m6a4dvg09d32cg1bxxpma7u=`expr $sp_h0m6a4dvg09d32cg1bxxpma7u - 1`
	eval $1=\$stk_h0m6a4dvg09d32cg1bxxpma7u_$sp_h0m6a4dvg09d32cg1bxxpma7u
	unset stk_h0m6a4dvg09d32cg1bxxpma7u_$sp_h0m6a4dvg09d32cg1bxxpma7u
}

# Push value $* onto the stack.
push_h0m6a4dvg09d32cg1bxxpma7u() {
	v3_h0m6a4dvg09d32cg1bxxpma7u=$*
	pushvar_h0m6a4dvg09d32cg1bxxpma7u v3_h0m6a4dvg09d32cg1bxxpma7u
}

# Schedule an expression for evaluation when
# unwind_h0m6a4dvg09d32cg1bxxpma7u() is called.
finally_h0m6a4dvg09d32cg1bxxpma7u() {
	push_h0m6a4dvg09d32cg1bxxpma7u "$@"
}

# Define a new scope where unwind_h0m6a4dvg09d32cg1bxxpma7u() will stop.
scope_h0m6a4dvg09d32cg1bxxpma7u() {
	push_h0m6a4dvg09d32cg1bxxpma7u
}

# Schedule another list of variables to be restored when
# unwind_h0m6a4dvg09d32cg1bxxpma7u() is called.
var_h0m6a4dvg09d32cg1bxxpma7u() {
	for v2_h0m6a4dvg09d32cg1bxxpma7u
	do
		eval v3_h0m6a4dvg09d32cg1bxxpma7u=\${$v2_h0m6a4dvg09d32cg1bxxpma7u+set}
		case $v3_h0m6a4dvg09d32cg1bxxpma7u in
			'')
				finally_h0m6a4dvg09d32cg1bxxpma7u \
					unset $v2_h0m6a4dvg09d32cg1bxxpma7u
				;;
			*)
				pushvar_h0m6a4dvg09d32cg1bxxpma7u \
					$v2_h0m6a4dvg09d32cg1bxxpma7u
				finally_h0m6a4dvg09d32cg1bxxpma7u \
					popvar_h0m6a4dvg09d32cg1bxxpma7u \
						$v2_h0m6a4dvg09d32cg1bxxpma7u
		esac
	done
}

# Excute all scheduled "finally_h0m6a4dvg09d32cg1bxxpma7u" expressions until
# beginning of scope_h0m6a4dvg09d32cg1bxxpma7u().
unwind_h0m6a4dvg09d32cg1bxxpma7u() {
	while :
	do
		popvar_h0m6a4dvg09d32cg1bxxpma7u v1_h0m6a4dvg09d32cg1bxxpma7u
		case $v1_h0m6a4dvg09d32cg1bxxpma7u in
			'') break
		esac
		eval "$v1_h0m6a4dvg09d32cg1bxxpma7u"
	done
}

# Verify that all resources on the stack have been cleaned up and all
# scheduled destructors have been run. Then unset all global variables set by
# the scope_h0m6a4dvg09d32cg1bxxpma7u helpers framework. This effectively
# shuts down the framework.
#
# WARNING: This function must only be called at the top-level of a script! Do
# not call it from within a sourced script unless you are positive that your
# caller does not also use the scopes framework!
shutdown_scopes_h0m6a4dvg09d32cg1bxxpma7u() {
	case $sp_h0m6a4dvg09d32cg1bxxpma7u in
		1) ;;
		*) echo "Resource leak!" >& 2; false || exit
	esac
	unset sp_h0m6a4dvg09d32cg1bxxpma7u v1_h0m6a4dvg09d32cg1bxxpma7u \
		v2_h0m6a4dvg09d32cg1bxxpma7u v3_h0m6a4dvg09d32cg1bxxpma7u \
		defined_h0m6a4dvg09d32cg1bxxpma7u
	unset -f finally_h0m6a4dvg09d32cg1bxxpma7u \
		popvar_h0m6a4dvg09d32cg1bxxpma7u \
		push_h0m6a4dvg09d32cg1bxxpma7u \
		pushvar_h0m6a4dvg09d32cg1bxxpma7u \
		scope_h0m6a4dvg09d32cg1bxxpma7u \
		shutdown_scopes_h0m6a4dvg09d32cg1bxxpma7u \
		unwind_h0m6a4dvg09d32cg1bxxpma7u \
		var_h0m6a4dvg09d32cg1bxxpma7u
}

# Protect this script snippet against multiple inclusions.
defined_h0m6a4dvg09d32cg1bxxpma7u=true
