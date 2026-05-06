#
# Terminal
#

0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h:h:h}

[[ "$TERM" == dumb ]] && return

autoload -Uz add-zsh-hook

# Set terminal title: directory in precmd, running command in preexec.
# function _terminal_precmd_title  { print -Pn '\e]0;%~\a' }
# function _terminal_preexec_title { print -n "\e]0;${(V)1}\a" }
# add-zsh-hook precmd  _terminal_precmd_title
# add-zsh-hook preexec _terminal_preexec_title

# Emit an OSC 1337 sequence to set vars your terminal app (WezTerm) can use.
# function set_terminal_var() {
#   (( $+commands[base64] )) || return 1
#   local name=$1 val
#   val="$(printf '%s' "$2" | base64)"

#   # https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it
#   # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
#   if [[ -n "$TMUX" ]]; then
#     printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$name" "$val"
#   else
#     printf "\033]1337;SetUserVar=%s=%s\007" "$name" "$val"
#   fi
# }
# set_terminal_var "TERM_CURRENT_SHELL" "zsh ${ZSH_PATCHLEVEL:-$ZSH_VERSION}"

function update_wezterm_shell_integration() {
  curl -fsSL "https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh" \
    -o "$MY_ZSH_CUSTOM/pkg/wezterm-shell-integration.sh"
}

case "${TERM_PROGRAM:l}" in
  apple_terminal)
    export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
    #function _terminal_precmd_title { printf '\e]7;%s\a' "file://$HOST$PWD" }
    ;;
  # ghostty)
  #   if [[ -n $GHOSTTY_RESOURCES_DIR ]] && (( ! $+functions[_ghostty_deferred_init] )); then
  #     source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
  #   fi
  #   ;;
  vscode)
    # https://code.visualstudio.com/docs/terminal/shell-integration
    if (( $+commands[code] )); then
      MY_HISTFILE=${HISTFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history}
      source "$(code --locate-shell-integration-path zsh)"
      HISTFILE=$MY_HISTFILE
      #unset MY_HISTFILE
    fi
    ;;
  wezterm)
    source "$MY_ZSH_CUSTOM/pkg/wezterm-shell-integration.sh"
    function set_current_shell() {
      __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
    }
    set_current_shell
    add-zsh-hook precmd set_current_shell
    ;;
esac
