export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
[[ -d $XDG_CACHE_HOME/wget ]] || mkdir -p $XDG_CACHE_HOME/wget
alias wget="${aliases[wget]:-wget} --hsts-file=$XDG_CACHE_HOME/wget/wget-hsts"
