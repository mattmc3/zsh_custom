#
# p10k-instaprompt: p10k can make Zsh seem faster
#
[[ "$ZSH_THEME" == p10k* ]] || [[ "$ZSH_THEME" == powerlevel10k* ]] || return 1

# Run this early so we can P10k instant prompt if we need it.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
