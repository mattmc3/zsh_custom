# Run this early so we can P10k instant prompt if we need it.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:p10k-instaprompt' loaded 'yes'
