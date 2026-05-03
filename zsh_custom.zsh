#!/usr/bin/env zsh

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

# Load libs
for _zlib in "$MY_ZSH_CUSTOM"/lib/*.zsh; do
  source $_zlib && _loaded=yes || _loaded=no
  zstyle ":zsh_custom:lib:${_zlib:t}" loaded $_loaded
done

# Load plugins
for _zplugin in $plugins; do
  fpath+=("$MY_ZSH_CUSTOM/plugins/${_zplugin:t}"(N))
  _zplugin_init=$MY_ZSH_CUSTOM/plugins/${_zplugin:t}/${_zplugin:t}.plugin.zsh
  if [[ ! -e "$_zplugin_init" ]]; then
    echo "Plugin not found: $_zplugin_init" >&2
    continue
  else
    source $_zplugin_init && _loaded=yes || _loaded=no
    zstyle ":zsh_custom:plugin:${_zplugin:t}" loaded $_loaded
  fi
done

unset _z{lib,plugin} _loaded
