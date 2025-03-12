prj() {
  local selection="$(command prj "$@")"
  if [[ -n "$selection" ]] && [[ -d "$selection" ]]; then
    cd "$selection"
  fi
}
eval "$(command prj --init sh)"
