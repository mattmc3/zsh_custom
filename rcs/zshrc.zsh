#
# .zshrc - Run on interactive sessions.
#

ZSH_CUSTOM=$ZDOTDIR/custom

# plugins
plugins=(
  # pre-reqs
  p10k-instant-prompt
  environment
  homebrew
  xdg
  zfunctions

  # editor
  editor
  magic-enter
  fancy-ctrl-z

  # utils
  colorize
  utility
  macos
  extract
  zoxide

  # plugins
  directory
  history
  prompt

  # completions
  completion

  # fish-like
  autosuggestions
  confd
  syntax-highlighting
  history-substring-search
)

# Source custom
source $ZSH_CUSTOM/zsh_custom.zsh

# Load plugins
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
