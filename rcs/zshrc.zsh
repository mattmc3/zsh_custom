#!/usr/bin/env zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME="starship"

# Keep caches out of $ZDOTDIR.
ZSH_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump-omz-$ZSH_VERSION

# Plugins read their zstyles when they load.
source $ZDOTDIR/custom/rcs/zstyles.zsh

# Completions must be on fpath before OMZ runs compinit.
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions(N/) $fpath)

# Symlink my custom plugins, themes, and lib files into $ZSH_CUSTOM.
zsh_custom=($ZDOTDIR/custom)

plugins=(
  # First, so the prompt draws before everything else loads.
  starship-ftl

  # Stock
  colored-man-pages
  dirhistory
  direnv
  gitignore
  sudo
  zoxide

  # Custom. use-xdg-basedirs first: later plugins read CARGO_HOME, GOPATH, etc.
  # myfunctions next: later plugins call cached-eval.
  use-xdg-basedirs
  myfunctions
  myaliases
  brew
  carapace
  clipboard
  git
  git-cmds
  histdb
  prj
  #wezterm
  zsh-bench
  zshrinkwrap

  # Languages and dev tools
  dotnet
  emacs
  golang
  java
  nim
  node
  perl
  postgres
  python
  ruby
  rust

  # Git repos via OMZ PLUS!
  mattmc3/zman
  zsh-users/zsh-completions

  # fzf after fzf-tab, so fzf's ** completion falls back to fzf-tab.
  aloxaf/fzf-tab
  fzf

  # globalias and magic-enter wrap accept-line; editor binds Enter.
  globalias
  magic-enter
  editor
  history-substring-search

  # Last, since these wrap widgets.
  zsh-patina
  zsh-autosuggestions
)

# Local settings, before OMZ loads so they can add plugins (eg: work ones).
[[ -r $ZDOTDIR/.zshrc.local ]] \
 && . $ZDOTDIR/.zshrc.local

# OMZ PLUS! gives us git-hosted plugins and multiple custom dirs.
export OMZ_PLUS=${ZDOTDIR:-$HOME}/omz-plus
[ -d "$OMZ_PLUS" ] || git clone git@github.com:mattmc3/omz-plus $OMZ_PLUS
source $OMZ_PLUS/omz-plus.sh

# OMZ only adds a plugin's own dir to fpath, and zsh-completions keeps its in src.
fpath+=($ZSH/custom/plugins/zsh-completions/src(N/))

source $ZSH/oh-my-zsh.sh

# Never start in the root file system.
[[ "$PWD" != "/" ]] || cd

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true
