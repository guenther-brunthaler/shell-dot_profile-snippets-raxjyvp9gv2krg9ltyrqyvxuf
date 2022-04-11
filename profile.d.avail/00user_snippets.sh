#! /bin/false
# Source all the shell snippets for the "site-snippets" framework for the
# current user. Either source this from your ~/.profile or copy the code
# there.
#
# Version 2022.101

# This also ensures the scopes framework is already loaded and won't be
# loaded again if some sourced snippet also sources it.
. ~/.profile.d/shellrc/libexec/scopes-h0m6a4dvg09d32cg1bxxpma7u.sh

scope_h0m6a4dvg09d32cg1bxxpma7u
	var_h0m6a4dvg09d32cg1bxxpma7u sh_35sklax1b53k1rdx057lvnx8n
	for sh_35sklax1b53k1rdx057lvnx8n in ~/.profile.d/*.sh
	do
		. "$sh_35sklax1b53k1rdx057lvnx8n"
	done
unwind_h0m6a4dvg09d32cg1bxxpma7u
shutdown_scopes_h0m6a4dvg09d32cg1bxxpma7u
