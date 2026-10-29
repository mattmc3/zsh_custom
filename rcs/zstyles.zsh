#!/bin/zsh

zstyle ':zsh_custom:plugin:git' default-user mattmc3

#
# Prompt
#

zstyle ':zsh_custom:theme:starship' config 'zephyr'
zstyle ':zsh_custom:theme:starship' transient 'yes'
zstyle ':ftl-prompt:' cursor bar

#
# Editor
#

# Fish-like abbreviations: words that never expand.
zstyle ':zsh_custom:plugin:globalias' noexpand \
  ls \
  grep \
  gpg \
  vi \
  z \
  0 1 2 3 4 5 6 7 8 9

zstyle ':zle:edit-command-line' editor nvim

#
# XDG base dirs
#

# Apps are opt-in. Run xdgbasedir to see what is on, what is available, and
# what is still waiting on a move.
zstyle ':use-xdg-basedirs:(az|bundle|cargo|dotnet|duckdb|go|gpg|jupyter)' enabled yes
zstyle ':use-xdg-basedirs:(less|node|npm|python3|readline|rg|screen|sqlite3)' enabled yes
zstyle ':use-xdg-basedirs:(irb|psql|ruff|rustup|starship)' enabled yes
