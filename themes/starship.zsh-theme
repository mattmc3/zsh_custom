# starship: Use with ZSH_THEME=starship. Pick a config from this directory with:
#   zstyle ':zsh_custom:theme:starship' config zephyr
# Add the starship-ftl plugin for an early-drawn prompt and transient prompts.

# The starship-ftl plugin already set up the prompt.
[[ "$prompt_theme[1]" == starship ]] && return

if (( ! $+commands[starship] )); then
  print -ru2 "starship.zsh-theme: starship not found"
  return 1
fi

() {
  local cfg themes=${${(%):-%x}:A:h}
  if zstyle -s ':zsh_custom:theme:starship' config cfg; then
    [[ -r $themes/$cfg.toml ]] && cfg=$themes/$cfg.toml
    [[ -r $cfg ]] && export STARSHIP_CONFIG=$cfg
  fi
}
source <(starship init zsh)
