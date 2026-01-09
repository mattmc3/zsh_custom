#
# Pre
#

0=${(%):-%N}
MY_ZSH_CUSTOM="${0:A:h:h}"

#
# XDG
#

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

#
# postzshrc
#

# There's not really a postzshrc event, so we're going to fake one by adding a
# function called run_postzshrc to the precmd event. That function only runs once,
# and then unregisters itself after that first run. If the user wants to (or needs to
# because it doesn't play well with a plugin), they can run it themselves manually at
# the very end of their .zshrc, and then it unregisters the precmd event.

(( $+functions[hooks-define-hook] )) ||
  source "$MY_ZSH_CUSTOM/pkg/zsh-hooks.zsh"

# Define our custom hook
hooks-define-hook postzshrc

# Define a function to run our custom hook that gets attached to the first precmd.
function run_postzshrc {
  # Run anything attached to the postzshrc hook
  hooks-run-hook postzshrc_hook

  # Now detach the precmd hook and unfunction this so that it only runs once.
  add-zsh-hook -d precmd run_postzshrc
  unfunction -- run_postzshrc
}

# Attach our function to precmd.
add-zsh-hook precmd run_postzshrc

#
# Post
#

# Mark this lib as loaded
zstyle ':zsh_custom:lib:__init__' loaded 'yes'
