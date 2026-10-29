# wget exits with an error if WGETRC names a file that is not there, and it
# never creates one.
# old: ~/.wgetrc
[[ -f $XDG_CONFIG_HOME/wgetrc ]] && export WGETRC=${WGETRC:-$XDG_CONFIG_HOME/wgetrc}
# old: ~/.wget-hsts
alias wget="${aliases[wget]:-wget} --hsts-file=$XDG_STATE_HOME/wget-hsts"
