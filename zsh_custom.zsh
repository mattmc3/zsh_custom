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
  local zplugin zplugin_name zplugin_init loaded start_ts
  for zplugin in $plugins; do
    start_ts=$EPOCHREALTIME
    zplugin_name=${zplugin:t}
    loaded=no

    if [[ -d "$MY_ZSH_CUSTOM/plugins/${zplugin_name}" ]]; then
      zplugin_init=$MY_ZSH_CUSTOM/plugins/${zplugin_name}/${zplugin_name}.plugin.zsh
      if [[ -e "$zplugin_init" ]]; then
        fpath+=("$MY_ZSH_CUSTOM/plugins/$zplugin_name")
        source $zplugin_init && loaded=yes
      else
        echo >&2 "Plugin not found: $zplugin_init"
      fi
    elif [[ "$zplugin" == */* ]]; then
      antibody bundle $zplugin && loaded=yes
    else
      echo >&2 "Unknown plugin: $zplugin"
    fi

    zstyle ":zsh_custom:plugin:$zplugin_name" loaded $loaded
    zstyle ":zsh_custom:plugin:$zplugin_name" load_time $(( EPOCHREALTIME - start_ts ))
  done
}
