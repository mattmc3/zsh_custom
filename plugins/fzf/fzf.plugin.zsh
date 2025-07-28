#
# fzf: Configure the fuzzy finder.
#

if ! (( $+commands[fzf] )); then
  echo "fzf not found" >&2
  return 1
fi

# https://github.com/ajeetdsouza/fzf
if (( $+functions[cached-eval] )); then
  cached-eval 'fzf-zsh' fzf --zsh
else
  source <(fzf --zsh)
fi

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:fzf' loaded 'yes'
