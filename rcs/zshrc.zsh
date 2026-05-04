#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Setup profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set variables
ZSH_THEME="p10k mmc"

# Add plugins
plugins=(
  # pre
  p10k-instaprompt

  # regular
  azure
  clipboard
  #colors
  common-aliases
  common-functions
  #confd
  direnv
  dotfiles
  dotnet
  editor
  emacs
  #extract
  #fancy-ctrl-z
  fzf
  git
  git-cmds
  golang
  #homebrew
  iwd
  java
  jupyter
  macos
  #magic-enter
  nim
  node
  #otp
  perl
  postgres
  #prj
  python
  #rapid-prompt
  ruby
  rust
  #secrets
  #symmetric-ctrl-z
  #terminal
  utility
  #xdg
  #zfunctions
  zoxide
  zsh-bench

  # final
  prompt
  autosuggestions
  history-substring-search
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
