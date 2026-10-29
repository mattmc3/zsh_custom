#
# wezterm: WezTerm shell integration.
#

0=${(%):-%N}
typeset -g _wezterm_plugin_dir=${0:A:h}

function update_wezterm_shell_integration {
  curl -fsSL "https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh" \
    -o "$_wezterm_plugin_dir/wezterm-shell-integration.sh"
}

[[ "$TERM_PROGRAM" == WezTerm ]] || return 0

source $_wezterm_plugin_dir/wezterm-shell-integration.sh

# Lets WezTerm config show which shell a pane is running.
function set_current_shell {
  __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
}
set_current_shell
add-zsh-hook precmd set_current_shell
