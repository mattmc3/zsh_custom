#
# Requirements
#

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

zstyle -t ":zsh_custom:plugin:__init__" loaded ||
  source $MY_ZSH_CUSTOM/plugins/__init__/__init__.plugin.zsh

#
# Init
#

antibody bundle zsh-users/zsh-history-substring-search

#
# Keybinds
#

zmodload zsh/terminfo

# Emacs
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Vi
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Up and down
local keymap
for keymap in 'main' 'emacs' 'viins'; do
  bindkey -M "$keymap" "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M "$keymap" "$terminfo[kcud1]" history-substring-search-down
done

#
# Wrap up
#

zstyle ":zsh_custom:plugin:history-substring-search" loaded yes
