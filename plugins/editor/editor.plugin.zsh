0=${(%):-%x}
autoload-dir ${0:A:h}/functions
source $ZSH_CUSTOM/.external/belak/zsh-utils/editor/editor.plugin.zsh

setopt NO_BEEP   # Do not beep on error in line editor.
bindkey -e       # emacs
