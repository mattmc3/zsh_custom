#!/usr/bin/env zsh

# Initialize
0=${(%):-%N}
MY_ZSH_CUSTOM=${0:A:h}

# Lazy-load (autoload) Zsh function files from a directory.
fpath=($MY_ZSH_CUSTOM/functions $fpath)
autoload -Uz $MY_ZSH_CUSTOM/functions/*(.:t)

# Don't the standalone parts in Oh-My-Zsh
(( ! $+functions[omz] )) || return 0

zmodload zsh/datetime
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS
MY_ZSH_CUSTOM_STANDALONE=1

# Load inits (same as OMZ's libs, but for standalone mode)
for _zlib in "$MY_ZSH_CUSTOM"/init/*.zsh(N); do
  source $_zlib && _zloaded=yes || _zloaded=no
  zstyle ":zsh_custom:lib:${_zlib:t}" loaded $_zloaded
done

# Make sure oh-my-zsh plugins are available
: ${OMZ_SHA:=e7aa0c56e68348afefdd6af4c5bdb314a2bd6640}
antibody bundle ohmyzsh/ohmyzsh kind:clone pin:$OMZ_SHA
[[ -n "$ZSH" ]] || ZSH=$(antibody path ohmyzsh/ohmyzsh)

# Load plugins
#local _zplugin _zplugin_name _zplugin_init loaded _zstart_ts
for _zplugin in $plugins; do
  _zstart_ts=$EPOCHREALTIME
  _zplugin_name=${_zplugin:t}
  _zloaded=no

  if [[ "$_zplugin" == */* ]]; then
    antibody bundle $_zplugin && _zloaded=yes
  else
    if [[ -d "$MY_ZSH_CUSTOM/plugins/${_zplugin_name}" ]]; then
      _zplugin_init=$MY_ZSH_CUSTOM/plugins/${_zplugin_name}/${_zplugin_name}.plugin.zsh
    elif [[ -d "$ZSH/plugins/${_zplugin_name}" ]]; then
      _zplugin_init=$ZSH/plugins/${_zplugin_name}/${_zplugin_name}.plugin.zsh
    else
      echo >&2 "Unknown plugin: $_zplugin"
    fi

    if [[ -e "$_zplugin_init" ]]; then
      fpath+=("{$_zplugin_init:h}")
      source $_zplugin_init && _zloaded=yes
    else
      echo >&2 "Plugin init not found: $_zplugin_init"
    fi
  fi

  zstyle ":zsh_custom:plugin:$_zplugin_name" loaded $_zloaded
  zstyle ":zsh_custom:plugin:$_zplugin_name" load_time $(( EPOCHREALTIME - _zstart_ts ))
done
unset _zplugin{,_name,_init} _z{lib,loaded,start_ts}
