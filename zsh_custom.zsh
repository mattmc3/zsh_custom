#!/usr/bin/env zsh

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

zmodload zsh/datetime

() {
  # Load libs
  local zlib loaded
  for zlib in "$MY_ZSH_CUSTOM"/lib/*.zsh; do
    source $zlib && loaded=yes || loaded=no
    zstyle ":zsh_custom:lib:${zlib:t}" loaded $loaded
  done
  unset zlib
}

# Load plugins
() {
  local zplugin zplugin_init loaded start_ts end_ts
  for zplugin in $plugins; do
    start_ts=$EPOCHREALTIME
    fpath+=("$MY_ZSH_CUSTOM/plugins/${zplugin:t}"(N))
    zplugin_init=$MY_ZSH_CUSTOM/plugins/${zplugin:t}/${zplugin:t}.plugin.zsh
    if [[ ! -e "$zplugin_init" ]]; then
      echo >&2 "Plugin not found: $zplugin_init"
      continue
    else
      source $zplugin_init && loaded=yes || loaded=no
      end_ts=$EPOCHREALTIME
      zstyle ":zsh_custom:plugin:${zplugin:t}" loaded $loaded
      zstyle ":zsh_custom:plugin:${zplugin:t}" load_time $(( end_ts - start_ts ))
    fi
  done
}
