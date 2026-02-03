#!/usr/bin/env zsh

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h}

for _init in $MY_ZSH_CUSTOM/init/*.zsh; do
  source $_init && _loaded=yes || _loaded=no
  zstyle ":zsh_custom:init:${_init:t:r}" loaded $_loaded
done

for _plugin in $plugins; do
  fpath+=("$MY_ZSH_CUSTOM/plugins/${_plugin:t}"(N))
  _plugin_init=$MY_ZSH_CUSTOM/plugins/${_plugin:t}/${_plugin:t}.plugin.zsh
  if [[ ! -e "$_plugin_init" ]]; then
    echo "Plugin not found: $_plugin_init" >&2
    continue
  else
    source $_plugin_init && _loaded=yes || _loaded=no
    zstyle ":zsh_custom:plugin:${_plugin:t}" loaded $_loaded
  fi
done
