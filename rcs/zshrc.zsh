#
# .zshrc - Run on interactive sessions.
#

# init profiling
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# autoload functions
export ZSH_CUSTOM=$ZDOTDIR/custom
fpath+=($ZSH_CUSTOM/functions)
autoload -Uz $ZSH_CUSTOM/functions/*(.:t)

# clone repos
export REPO_HOME=$ZSH_CUSTOM/.external
[[ -d $REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt

# plugins
plugins=(
  # pre-reqs
  p10k-instant-prompt
  environment
  xdg
  zfunctions
  brew

  # editor
  editor
  magic-enter
  fancy-ctrl-z

  # utils
  colorize
  clipboard
  macos
  extract
  zoxide

  # plugins
  directory
  history
  prompt
  utility
  terminal

  # completions
  completion

  # fish-like
  autosuggestions
  confd
  syntax-highlighting
  history-substring-search
)

plugin-load $plugins

# prompt
prompt p10k mmc

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# done profiling
[[ -z "$ZPROFRC" ]] || zprof

# cleanup
unset ZPROFRC
true
