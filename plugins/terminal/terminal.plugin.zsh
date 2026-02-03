# Emit an OSC 1337 sequence to set vars your terminal app (WezTerm) can use.
function set_terminal_var() {
  hash base64 2>/dev/null || return 1
  local val
  val="$(echo -n "$2" | base64)"

  # https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it
  # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
  if [[ -n "${TMUX}" ]] ; then
    printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$1" "$val"
  else
    printf "\033]1337;SetUserVar=%s=%s\007" "$1" "$val"
  fi
}
set_terminal_var "TERM_CURRENT_SHELL" "zsh ${ZSH_PATCHLEVEL:-$ZSH_VERSION}"


function wezterm_update_shell_integration() {
  curl -fsSL "https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh" \
    -o "$MY_ZSH_CUSTOM/pkg/wezterm-shell-integration.sh"
}

if [[ "${TERM_PROGRAM:l}" == wezterm ]]; then
  # Use WezTerm shell integration
  source "$MY_ZSH_CUSTOM/pkg/wezterm-shell-integration.sh"

  function set_current_shell_precmd() {
    __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd set_current_shell_precmd
elif [[ "${TERM_PROGRAM:l}" == apple_terminal ]]; then
  # Make Apple Terminal behave.
  export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
fi
