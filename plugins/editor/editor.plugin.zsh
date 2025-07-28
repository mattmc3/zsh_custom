#
# editor: Setup Zsh line editor behavior.
#

# References:
# - https://github.com/belak/zsh-utils/blob/main/editor/editor.plugin.zsh
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1
0=${(%):-%N}

#
# Options
#

# Set Zsh editor options.
setopt NO_beep                 # Do not beep on error in line editor.
setopt NO_flow_control         # Allow the usage of ^Q/^S in the context of zsh.

#
# Variables
#

# Treat these characters as part of a word.
zstyle -s ':zsh_custom:plugin:editor' wordchars 'WORDCHARS' || \
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info

# Modifiers
key_info=(
  'Control' '\C-'
  'Escape'  '\e'
  'Meta'    '\M-'
)

# Basic keys
key_info+=(
  'Backspace' "^?"
  'Delete'    "^[[3~"
  'F1'        "$terminfo[kf1]"
  'F2'        "$terminfo[kf2]"
  'F3'        "$terminfo[kf3]"
  'F4'        "$terminfo[kf4]"
  'F5'        "$terminfo[kf5]"
  'F6'        "$terminfo[kf6]"
  'F7'        "$terminfo[kf7]"
  'F8'        "$terminfo[kf8]"
  'F9'        "$terminfo[kf9]"
  'F10'       "$terminfo[kf10]"
  'F11'       "$terminfo[kf11]"
  'F12'       "$terminfo[kf12]"
  'Insert'    "$terminfo[kich1]"
  'Home'      "$terminfo[khome]"
  'PageUp'    "$terminfo[kpp]"
  'End'       "$terminfo[kend]"
  'PageDown'  "$terminfo[knp]"
  'Up'        "$terminfo[kcuu1]"
  'Left'      "$terminfo[kcub1]"
  'Down'      "$terminfo[kcud1]"
  'Right'     "$terminfo[kcuf1]"
  'BackTab'   "$terminfo[kcbt]"
)

# Mod plus another key
key_info+=(
  'AltLeft'         "${key_info[Escape]}${key_info[Left]} \e[1;3D"
  'AltRight'        "${key_info[Escape]}${key_info[Right]} \e[1;3C"
  'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
  'ControlPageUp'   '\e[5;5~'
  'ControlPageDown' '\e[6;5~'
)

#
# Functions
#

# Runs bindkey but for all of the keymaps. Running it with no arguments will
# print out the mappings for all of the keymaps.
function bindkey-all {
  local keymap=''
  for keymap in $(bindkey -l); do
    [[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
    bindkey -M "${keymap}" "$@"
  done
}

function update-cursor-style {
  # We currently only support the xterm family of terminals
  if ! is-term-family xterm && ! is-term-family rxvt && ! is-tmux; then
    return
  fi

  local style

  # Try to get style for the current keymap, fallback to sensible defaults
  zstyle -s ":zsh_custom:plugin:editor:$KEYMAP" cursor style
  if [[ -z "$style" ]]; then
    case "$KEYMAP" in
      main|emacs|viins) style=line ;;
      *)                style=block ;;
    esac
  fi

  # Print the cursor style, or do nothing and use the default.
  case $style in
    block)      printf '\e[2 q' ;;
    underscore) printf '\e[4 q' ;;
    line)       printf '\e[6 q' ;;
  esac
}
zle -N update-cursor-style

# Enables terminal application mode
function zle-line-init {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[smkx] )); then
    # Enable terminal application mode.
    echoti smkx
  fi

  # Ensure we have the correct cursor. We could probably do this less
  # frequently, but this does what we need and shouldn't incur that much
  # overhead.
  zle update-cursor-style
}
zle -N zle-line-init

# Disables terminal application mode
function zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[rmkx] )); then
    # Disable terminal application mode.
    echoti rmkx
  fi
}
zle -N zle-line-finish

# Resets the prompt when the keymap changes
function zle-keymap-select {
  zle update-cursor-style

  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

#
# Init
#

# Reset to default key bindings
bindkey -d

#
# Keybinds
#

# Global keybinds
typeset -gA global_keybinds
global_keybinds=(
  "$key_info[Home]"   beginning-of-line
  "$key_info[End]"    end-of-line
  "$key_info[Delete]" delete-char
)

# emacs and vi insert mode keybinds
typeset -gA viins_keybinds
viins_keybinds=(
  "$key_info[Backspace]" backward-delete-char
  "$key_info[Control]W"  backward-kill-word
)

# vi command mode keybinds
typeset -gA vicmd_keybinds
vicmd_keybinds=(
  "$key_info[Delete]" delete-char
)

# Special case for ControlLeft and ControlRight because they have multiple
# possible binds.
for key in "${(s: :)key_info[ControlLeft]}" "${(s: :)key_info[AltLeft]}"; do
  bindkey -M emacs "$key" emacs-backward-word
  bindkey -M viins "$key" vi-backward-word
  bindkey -M vicmd "$key" vi-backward-word
done
for key in "${(s: :)key_info[ControlRight]}" "${(s: :)key_info[AltRight]}"; do
  bindkey -M emacs "$key" emacs-forward-word
  bindkey -M viins "$key" vi-forward-word
  bindkey -M vicmd "$key" vi-forward-word
done

# Bind all global and viins keys to the emacs keymap
for key bind in ${(kv)global_keybinds} ${(kv)viins_keybinds}; do
  bindkey -M emacs "$key" "$bind"
done

# Bind all global, vi, and viins keys to the viins keymap
for key bind in ${(kv)global_keybinds} ${(kv)viins_keybinds}; do
  bindkey -M viins "$key" "$bind"
done

# Bind all global, vi, and vicmd keys to the vicmd keymap
for key bind in ${(kv)global_keybinds} ${(kv)vicmd_keybinds}; do
  bindkey -M vicmd "$key" "$bind"
done

#
# Extensions
#

for _ext in "${0:a:h}"/extensions/*.zsh(N); do
  if zstyle -t ":zsh_custom:plugin:editor:${_ext:t:r}" "enabled"; then
    source "${_ext}"
  fi
done
unset _ext

#
# Layout
#

# Set the key layout.
zstyle -s ':zsh_custom:plugin:editor' key-bindings 'key_bindings'
if [[ "$key_bindings" == (emacs|) ]]; then
  bindkey -e
elif [[ "$key_bindings" == vi ]]; then
  bindkey -v
else
  print "editor: invalid key bindings: $key_bindings" >&2
fi

#
# Plugins
#

if zstyle -t ":zsh_custom:plugin:editor:zsh-no-ps2" "enabled" && [[ -d "$ZSH_REPO_HOME"/romkatv/zsh-no-ps2 ]]; then
  source "$ZSH_REPO_HOME"/romkatv/zsh-no-ps2/zsh-no-ps2.plugin.zsh
fi

if zstyle -t ":zsh_custom:plugin:editor:zsh-vi-mode" "enabled" &&
   [[ -d "$ZSH_REPO_HOME"/romkatv/zsh-no-ps2 ]] &&
   [[ "$key_bindings" == vi ]]
then
  source "$ZSH_REPO_HOME"/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

#
# Post
#

unset bind key{,_bindings} {vicmd,viins,global}_keybinds

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:editor' loaded 'yes'
