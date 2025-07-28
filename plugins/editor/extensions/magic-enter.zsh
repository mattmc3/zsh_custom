# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/magic-enter
(( $+functions[magic-enter-cmd] )) ||
function magic-enter-cmd {
  local cmd
  zstyle -s ':zsh_custom:plugin:editor:magic-enter' command 'cmd' ||
    cmd="ls ."

  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    zstyle -s ':zsh_custom:plugin:editor:magic-enter' git-command 'cmd' ||
      cmd="git status -sb ."
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

# Wrapper for the accept-line zle widget (run when pressing Enter)
# If the wrapper already exists don't redefine it
if (( ! ${+functions[_magic-enter_accept-line]} )); then
  case "$widgets[accept-line]" in
    # Override the current accept-line widget, calling the old one
    user:*) zle -N _magic-enter_orig_accept-line "${widgets[accept-line]#user:}"
      function _magic-enter_accept-line {
        magic-enter
        zle _magic-enter_orig_accept-line -- "$@"
      } ;;
    # If no user widget defined, call the original accept-line widget
    builtin) function _magic-enter_accept-line {
        magic-enter
        zle .accept-line
      } ;;
  esac
  zle -N accept-line _magic-enter_accept-line
fi
