#!/usr/bin/env zsh

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

zmodload zsh/datetime

# Load libs
for _zlib in "$MY_ZSH_CUSTOM"/init/*.zsh; do
  source $_zlib && _zloaded=yes || _zloaded=no
  zstyle ":zsh_custom:lib:${_zlib:t}" loaded $_zloaded
done

# Load plugins
#local _zplugin _zplugin_name _zplugin_init loaded _zstart_ts
for _zplugin in $plugins; do
  _zstart_ts=$EPOCHREALTIME
  _zplugin_name=${_zplugin:t}
  _zloaded=no

  if [[ -d "$MY_ZSH_CUSTOM/plugins/${_zplugin_name}" ]]; then
    _zplugin_init=$MY_ZSH_CUSTOM/plugins/${_zplugin_name}/${_zplugin_name}.plugin.zsh
    if [[ -e "$_zplugin_init" ]]; then
      fpath+=("$MY_ZSH_CUSTOM/plugins/$_zplugin_name")
      source $_zplugin_init && _zloaded=yes
    else
      echo >&2 "Plugin not found: $_zplugin_init"
    fi
  elif [[ "$_zplugin" == */* ]]; then
    antibody bundle $_zplugin && _zloaded=yes
  else
    echo >&2 "Unknown plugin: $_zplugin"
  fi

  zstyle ":zsh_custom:plugin:$_zplugin_name" loaded $_zloaded
  zstyle ":zsh_custom:plugin:$_zplugin_name" load_time $(( EPOCHREALTIME - _zstart_ts ))
done
unset _zplugin{,_name,_init} _z{lib,loaded,start_ts}
