# Load plugin functions.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

antibody bundle romkatv/powerlevel10k kind:clone
antibody bundle sindresorhus/pure kind:fpath

autoload -Uz promptinit && promptinit
if [[ -n "$ZSH_THEME" ]]; then
  prompt $ZSH_THEME
fi
