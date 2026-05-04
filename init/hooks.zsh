# Use zsh-hooks package
source $MY_ZSH_CUSTOM/pkg/zsh-hooks.zsh

# There's not really a postzshrc event, so we're going to fake one by adding a
# function called run_postzshrc to the precmd event. That function only runs once,
# and then unregisters itself after that first run. If the user wants to (or needs to
# because it doesn't play well with a plugin), they can run it themselves manually at
# the very end of their .zshrc, and then it unregisters the precmd event.

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

# Now you can add postzshrc commands with
# hooks-add-hook postzshrc_hook myfunc

# termcd: cd to a queued directory written to cache by termcd or any subprocess.
zmodload zsh/datetime
function _termcd_precmd {
  local f="${XDG_CACHE_HOME:-$HOME/.cache}/termcd/${TTY##*/}"
  local dir mtime
  [[ -f "$f" ]] && dir=$(<"$f") || return
  mtime=$(stat -f %m "$f" 2>/dev/null)
  rm -f "$f"
  [[ -n "$mtime" ]] && (( EPOCHSECONDS - mtime > 5 )) && return
  [[ -d "$dir" ]] && cd -- "$dir"
}
add-zsh-hook precmd _termcd_precmd
