#!/usr/bin/env bash
# if test ! -x "$PYENV_COMMAND_PATH"; then {\
## Give user variant higher priority
# shellcheck disable=SC2154
_check_upath="${GP_PYENV_MIRROR}/user/${versions[0]}/bin/$PYENV_COMMAND"
if test -x "$_check_upath"; then {
	# shellcheck disable=SC2034
	PYENV_COMMAND_PATH="$_check_upath"
}; fi

# Hijack into `pyenv-prefix` to be called from pyenv-whence <arg>
# This is necessary for pyenv-which to recognize an installed but
## unselected python version containing the program.
function pyenv-prefix {
	# Add user prefix paths when called by pyenv-prefix
	if test "${BASH_SOURCE[1]}" == "$PYENV_ROOT/libexec/pyenv-whence"; then {
		local target="${GP_PYENV_MIRROR}/user/$1"
		if test -e "$target"; then {
			echo "$target"
			return
		}; fi
	}; fi
	builtin command pyenv-prefix "$@"
} && export -f pyenv-prefix
# }; fi