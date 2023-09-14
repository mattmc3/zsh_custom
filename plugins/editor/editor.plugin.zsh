#
# editor - Set keybindings.
#
# https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh

#
# Requirements
#

# Return if requirements are not found.
[[ "$TERM" != 'dumb' ]] || return 1

#
# Zstyles
#

# enable ../.. dot-expansion
zstyle ':prezto:module:editor' dot-expansion 'yes'

#
# Init
#

# Use Prezto's editor module.
plugin-load sorin-ionescu/prezto/modules/editor

#
# Options
#

# Undo Prezto options.
setopt NO_beep

#
# Keybindings
#

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
zmodload -i zsh/complist
bindkey -M menuselect '^o' accept-and-infer-next-history
