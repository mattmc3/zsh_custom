function source_base_plugin() {
  if [[ -f "${ZPREZTODIR}/modules/${1}/init.zsh" ]]; then
    source "${ZPREZTODIR}/modules/${1}/init.zsh"
  elif [[ -f "${ZSH}/plugins/${1}/${1}.plugin.zsh" ]]; then
    source "${ZSH}/plugins/${1}/${1}.plugin.zsh"
  fi
}
