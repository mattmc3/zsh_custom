_grep_alias_cache=("$ZSH_CACHE_DIR"/grep_alias.zsh(Nm-24))
if (( $#_grep_alias_cache )); then
  source "$ZSH_CACHE_DIR"/grep_alias.zsh
else
  source "$ZSH"/lib/grep.zsh
  echo "alias $(alias grep)" >| "$ZSH_CACHE_DIR"/grep_alias.zsh
fi
unset _grep_alias_cache
