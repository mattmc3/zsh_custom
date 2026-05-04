#
# editor: Setup Zsh line editor behavior.
#

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

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
[[ -n "$WORDCHARS" ]] || WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

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

# Expands .... to ../..
function dot-expansion {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N dot-expansion

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Toggle the comment character at the start of the line. This is meant to work
# around a buggy implementation of pound-insert in zsh.
#
# This is currently only used for the emacs keys because vi-pound-insert has
# been reported to work properly.
function pound-toggle {
  if [[ "$BUFFER" = '#'* ]]; then
    # Because of an oddity in how zsh handles the cursor when the buffer size
    # changes, we need to make this check before we modify the buffer and let
    # zsh handle moving the cursor back if it's past the end of the line.
    if [[ $CURSOR != $#BUFFER ]]; then
      (( CURSOR -= 1 ))
    fi
    BUFFER="${BUFFER:1}"
  else
    BUFFER="#$BUFFER"
    (( CURSOR += 1 ))
  fi
}
zle -N pound-toggle

#
# Keybinds
#

# Global keybinds
typeset -A _zglobal_keybinds=(
  "$key_info[Home]"   beginning-of-line
  "$key_info[End]"    end-of-line
  "$key_info[Delete]" delete-char
)

# emacs and vi insert mode keybinds
typeset -A _zviins_keybinds=(
  "$key_info[Backspace]" backward-delete-char
  "$key_info[Control]W"  backward-kill-word
)

# vi command mode keybinds
typeset -A _zvicmd_keybinds=(
  "$key_info[Delete]" delete-char
)

# Word navigation — Ctrl/Alt + Left/Right each have multiple escape sequences.
for _zkey_name _zdir in \
  ControlLeft  backward-word \
  AltLeft      backward-word \
  ControlRight forward-word  \
  AltRight     forward-word
do
  for _zkey in "${(s: :)key_info[$_zkey_name]}"; do
    bindkey -M emacs "$_zkey" emacs-$_zdir
    bindkey -M viins "$_zkey" vi-$_zdir
    bindkey -M vicmd "$_zkey" vi-$_zdir
  done
done

# Bind global + insert keys to emacs and viins; global + vicmd keys to vicmd.
for _zkeymap in emacs viins; do
  for _zkey _zbind in ${(kv)_zglobal_keybinds} ${(kv)_zviins_keybinds}; do
    bindkey -M "$_zkeymap" "$_zkey" "$_zbind"
  done
done
for _zkey _zbind in ${(kv)_zglobal_keybinds} ${(kv)_zvicmd_keybinds}; do
  bindkey -M vicmd "$_zkey" "$_zbind"
done

# Toggle comment at the start of the line. Note that we use pound-toggle for emacs
# mode, which is similar to pound insert, but meant to work around some bugs.
bindkey -M emacs "$key_info[Escape];" pound-toggle
bindkey -M vicmd "#" vi-pound-insert

# Optional keybindings for emacs and viins keymaps
typeset -A _zopt_in_keybinds _zopt_out_keybinds
_zopt_in_keybinds=(
  dot-expansion "."
)
_zopt_out_keybinds=(
  #symmetric-ctrl-z '^Z'
  prepend-sudo     '^X^S'
)

# Opt-in features (disabled by default)
for _zfeature _zkey in ${(kv)_zopt_in_keybinds}; do
  if zstyle -t ':zsh_custom:plugin:editor' "$_zfeature"; then
    for _zkeymap in 'emacs' 'viins'; do
      bindkey -M "$_zkeymap" "$_zkey" "$_zfeature"
    done
  fi
done

# Opt-out features (enabled by default)
for _zfeature _zkey in ${(kv)_zopt_out_keybinds}; do
  if zstyle -T ':zsh_custom:plugin:editor' "$_zfeature"; then
    for _zkeymap in 'emacs' 'viins'; do
      bindkey -M "$_zkeymap" "$_zkey" "$_zfeature"
    done
  fi
done

# Do not expand .... to ../.. during incremental search.
if zstyle -t ':zsh_custom:plugin:editor' dot-expansion; then
  bindkey -M isearch . self-insert 2> /dev/null
fi

#
# Plugins
#

# vi layout
[[ "${ZSH_BINDKEY:-}" == vi ]] && antibody bundle jeffreytse/zsh-vi-mode

# disable PS2
antibody bundle romkatv/zsh-no-ps2

#
# Built-ins
#

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Clean up
#

unset _z{bind,key,keymap,feature}
unset _z{opt_in,opt_out}_keybinds _z{vicmd,viins,global}_keybinds
