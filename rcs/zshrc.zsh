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

  # core plugins
  color
  directory
  history
  prompt
  utility
  jobs

  # editor
  editor
  magic-enter
  fancy-ctrl-z

  # utils
  git
  common-aliases
  dotfiles
  extract
  gpg
  iwd
  macos
  otp
  prj
  up
  zoxide

  # languages
  python
  golang

  # external
  mattmc3/zman

  # completions
  #completion

  # fish-like
  autosuggestions
  confd
  syntax-highlighting
  history-substring-search
)

# Zstyles
zstyle ':zsh_custom:plugin:prompt' theme p10k mmc

# Source custom
source $ZSH_CUSTOM/zsh_custom.zsh

# Load plugins
plugin-load $plugins

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# done profiling
[[ -z "$ZPROFRC" ]] || zprof

# cleanup
unset ZPROFRC
true
