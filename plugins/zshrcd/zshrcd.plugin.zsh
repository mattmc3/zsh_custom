#
# zshrcd: Source anything in zshrc.d.
#

# Allow user to set .zshrc.d to whatever.
zstyle -s ':zsh_custom:plugin:zshrcd' directory _zshrcd \
  || _zshrcd=${ZDOTDIR:-$HOME}/.zshrc.d

# Replace a literal leading '~' with $HOME.
_zshrcd=${~_zshrcd}

# The user should be notified when the dir is missing if they included this.
if [[ ! -d $_zshrcd ]]; then
  echo "zshrcd: Directory not found '$_zshrcd'." >&2
  return 1
fi

# Loop through files in zshrc.d, ignoring ones that start with '~'.
for _rc in "$_zshrcd"/*.zsh(N); do
  [[ ${_rc:t} != '~'* ]] || continue
  source $_rc
done
unset _{rc,zshrcd}

# Mark the plugin as loaded.
zstyle ':zsh_custom:plugin:zshrcd' loaded 'yes'
