#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Setup profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set variables
ZSH_THEME="p10k mmc"
#ZSH_THEME="pure"

# Add plugins
plugins=(
  # regular
  azure
  clipboard
  common-aliases
  common-functions
  completions
  compstyle
  #confd
  direnv
  dotfiles
  dotnet
  editor
  emacs
  extract
  fancy-ctrl-z
  fzf
  git
  git-cmds
  globalias
  golang
  history-aux
  homebrew
  iwd
  java
  jupyter
  macos
  magic-enter
  nim
  node
  #otp
  perl
  postgres
  prj
  python
  #rapid-prompt
  ruby
  rust
  #secrets
  #terminal
  utility
  xdg-apps
  #zfunctions
  zoxide
  zsh-bench

  # final
  prompt
  mattmc3/zman
  autosuggestions
  history-substring-search
  zdharma-continuum/fast-syntax-highlighting
)

# use zsh_custom
source $ZDOTDIR/.custom/zsh_custom.zsh

# Never start an interactive session in the root file system.
[[ "$PWD" != "/" ]] || cd

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
unset ZPROFRC

# Always return success.
true
