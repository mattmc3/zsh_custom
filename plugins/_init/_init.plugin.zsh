##
# Options

# no autocorrect
unsetopt CORRECT
unsetopt CORRECTALL

# changing directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# I/O
# Allow comments even in interactive shells.
setopt NO_FLOW_CONTROL

# prompting
setopt PROMPT_SUBST

# zle
setopt EMACS
setopt NO_BEEP  # quiet!

# completions
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

##
# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=~/.xdg

# less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
[[ -f "$LESSHISTFILE" ]] || { mkdir -p $(dirname "$LESSHISTFILE") && touch $LESSHISTFILE }

# readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
[[ -f "$INPUTRC" ]] || { mkdir -p $(dirname "$INPUTRC") && touch $INPUTRC }
