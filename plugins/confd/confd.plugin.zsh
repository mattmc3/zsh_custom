#!/bin/zsh

# Allow user to set conf.d to whatever.
zstyle -s ':zsh_custom:plugin:confd' directory _zconfd \
  || _zconfd="${ZDOTDIR:-$HOME/.config/zsh}/conf.d"

# Replace a literal leading '~' with $HOME.
_zconfd=${~_zconfd}

# The user should be notified when the dir is missing if they included this.
if [[ ! -d $_zshrcd ]]; then
  echo "zshrcd: Directory not found '$_zshrcd'." >&2
  return 1
fi

# Load rcs.
for _rc in "$_zconfd"/*.zsh(N); do
  [[ $_rc:t != '~'* ]] || continue
  source $_rc
done
unset _zconfd _rc
