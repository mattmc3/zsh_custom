0=${(%):-%N}

fpath=("${0:A:h}/functions" $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)

alias get="git"
alias clone="g.clone"
