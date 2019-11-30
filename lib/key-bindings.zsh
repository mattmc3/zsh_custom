# use the default OMZ key-bindings
source $ZSH/lib/key-bindings.zsh

# add our own
# https://github.com/changs/slimzsh/blob/master/keys.zsh

export KEYTIMEOUT=1  # remove lag
bindkey -s '\el' "ls\n"
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey '^[[Z' reverse-menu-complete
