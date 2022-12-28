# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# setup zsh_custom
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZDOTDIR/custom}
[[ -d $ZSH_CUSTOM ]] || git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM
source $ZSH_CUSTOM/lib/zcustominit.zsh

plugins=(
  # first
  #p10k-instant-prompt
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
  prompt
  history-substring-search
)

for plugin in $plugins; do
  source "${ZSH_CUSTOM}/plugins/${plugin}/${plugin}.plugin.zsh"
done
unset plugin

# set prompt
# prompt powerlevel10k
# source $ZSH_CUSTOM/lib/p10k.zsh
prompt pure

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
