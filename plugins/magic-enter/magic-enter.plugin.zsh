#
# magic-enter: add a default command when none is given
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/magic-enter
(( $+functions[magic-enter-cmd] )) ||
function magic-enter-cmd {
  local cmd
  zstyle -s ':zsh_custom:plugin:magic-enter' command cmd ||
    cmd="${MAGIC_ENTER_OTHER_COMMAND:-ls}"

  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    zstyle -s ':zsh_custom:plugin:magic-enter' git-command cmd ||
      cmd="${MAGIC_ENTER_GIT_COMMAND:-git status -sb}"
  fi
  echo $cmd
}

function magic-enter {
  # Only run MAGIC_ENTER commands when in PS1 and command line is empty
  # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#User_002dDefined-Widgets
  if [[ -n "$BUFFER" || "$CONTEXT" != start ]]; then
    return
  fi
  BUFFER=$(magic-enter-cmd)
}

# Add magic-enter as an accept line hook
hooks-add-hook accept_line_hook magic-enter
