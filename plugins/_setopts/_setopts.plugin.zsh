# no autocorrect
unsetopt correct
unsetopt correctall

# changing directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# I/O
# Allow comments even in interactive shells.
setopt no_flow_control

# prompting
setopt prompt_subst

# zle
setopt emacs
setopt no_beep  # quiet!
