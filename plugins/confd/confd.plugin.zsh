#!/bin/zsh

zstyle -s ':zsh_custom:plugin:confd' directory _zconfd \
  || _zconfd="${ZDOTDIR:-$HOME/.config/zsh}/conf.d"

# Load rcs.
for _rc in "$_zconfd"/*.zsh(N); do
  [[ $_rc:t != '~'* ]] || continue
  source $_rc
done
unset _zconfd _rc
