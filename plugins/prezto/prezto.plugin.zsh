function source_base_plugin() {
  local zfunc
  if [[ -f "${ZPREZTODIR}/modules/${1}/init.zsh" ]]; then
    if [[ -d "$ZPREZTODIR/modules/${1}/functions" ]]; then
      fpath=("$ZPREZTODIR/modules/${1}/functions" $fpath)
      for zfunc in "$ZPREZTODIR/modules/${1}/functions"/*(.N); do
        autoload -Uz "$zfunc"
      done
    fi
    source "${ZPREZTODIR}/modules/${1}/init.zsh"

  elif [[ -f "${ZSH}/plugins/${1}/${1}.plugin.zsh" ]]; then
    source "${ZSH}/plugins/${1}/${1}.plugin.zsh"
  fi
}
