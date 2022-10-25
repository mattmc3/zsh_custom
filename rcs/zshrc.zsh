# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# setup zsh_custom
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZDOTDIR/zsh_custom}
[[ -d $ZSH_CUSTOM ]] || git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM
fpath+=$ZSH_CUSTOM/functions
autoload -Uz zcustominit && zcustominit

plugins=(
  # first
  xdg-basedir
  p10k-instant-prompt
  prompt

  abbreviations
  antidote
  aliases
  antidote
  autosuggestions
  colors
  completion
  confd
  directory
  editor
  emacs
  environment
  fancy-ctrl-z
  git
  golang
  groovy
  history
  lpass
  macos
  node
  perl
  python
  ruby
  safe-rm
  string
  syntax-highlighting
  terminal
  utility
  z
  zman

  # last
  history-substring-search
)

for plugin in $plugins; do
  source "${ZSH_CUSTOM}/plugins/${plugin}/${plugin}.plugin.zsh"
done
unset plugin

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
