export WGETRC="${WGETRC:-${XDG_CONFIG_HOME:-$HOME/.config}/wgetrc}"
alias wget="${aliases[wget]:-wget} --hsts-file=${XDG_STATE_HOME:-$HOME/.local/state}/wget-hsts"
