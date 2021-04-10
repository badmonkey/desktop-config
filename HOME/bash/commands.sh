#
# extra commands
#


# $-  contains i or s
function is-interactive {
    if [[ $- == *i* ]]; then
        return 0
    else
        return 1
    fi
}

# shopt -q login_shell
# or  $0 ~= "-bash"
function is-login-shell {
	if shopt -q login_shell; then
		return 0
	else
		return 1
	fi
}


function is-start-session {
	if [ -z "$BASH_SESSION_START" ]; then
		return 0
	else
		return 1
	fi
}


shorten_path() {
	local ret=

    local p="$1"

    local tmp="${p//\//}"
    local -i delims=$(( ${#p} - ${#tmp} ))

    for (( dir=0; dir < 2; dir++ )); do
        (( dir == delims )) && break

        local left="${p#*/}"
        local name="${p:0:${#p} - ${#left}}"
        p="${left}"
        ret+="${name%/}/"
    done
	if (( delims <= 2 )); then
        # no dirs between LP_PATH_KEEP leading dirs and current dir
        ret+="${p##*/}"
    else
        local base="${p##*/}"

        p="${p:0:${#p} - ${#base}}"

        [[ ${ret} != "/" ]] && ret="${ret%/}" # strip trailing slash

        local -i len_left=$(( max_len - ${#ret} - ${#base} - ${#mask} ))

        ret+="/…/${p:${#p} - ${len_left}}${base}"
    fi
	echo "$ret"
}


work-dir() {
	shorten_path "$(dirs +0)"
}


dirstack-top() {
	if [ -n "${DIRSTACK[1]}" ]; then
		echo $(basename "${DIRSTACK[1]}")
	else
		echo "none"
	fi
}


virtual-env-name() {
	if [ -n "$VIRTUAL_ENV" ]; then
		echo $(basename "$VIRTUAL_ENV")
	else
		echo ""
	fi
}
