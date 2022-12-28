# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ "$ZPROFRC" -eq 1 ]] && typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# setup zsh_custom
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZDOTDIR/custom}
[[ -d $ZSH_CUSTOM ]] || git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM
source $ZSH_CUSTOM/lib/zcustominit.zsh

plugins=(
  # first
  zfunctions
  xdg-basedir
  environment
  directory
  editor
  history
  utility

  # plugins
  aliases
  autosuggestions
  colors
  #confd
  emacs
  fancy-ctrl-z
  git
  golang
  groovy
  lpass
  macos
  node
  perl
  python
  ruby
  string
  terminal
  z
  zman

  # deferred
  abbreviations
  syntax-highlighting

  # last
  completion
  #prompt
  history-substring-search
)

for plugin in $plugins; do
  source "${ZSH_CUSTOM}/plugins/${plugin}/${plugin}.plugin.zsh"
done
unset plugin

# set prompt
source $ZSH_CUSTOM/.external/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_CUSTOM/lib/p10k.zsh

# Setup completion style
compstyle mattmc3

# Use Emacs keys.
bindkey -e

# Set plugin variables.
MAGIC_ENTER_GIT_COMMAND='git status -sb'
if [[ "$OSTYPE" == darwin* ]]; then
  MAGIC_ENTER_OTHER_COMMAND='command ls -G'
else
  MAGIC_ENTER_OTHER_COMMAND='command ls --color=auto'
fi

# Set path.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
