# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# Make sure XDG dirs are set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"
export USE_XDG_DIRS="${USE_XDG_DIRS:-true}"


if [[ $USE_XDG_DIRS == true ]]; then
  # less
  export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
  export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
  [[ -f "$LESSHISTFILE" ]] || { mkdir -p $(dirname "$LESSHISTFILE") && touch $LESSHISTFILE }

  # readline
  export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
  [[ -f "$INPUTRC" ]] || { mkdir -p $(dirname "$INPUTRC") && touch $INPUTRC }
fi
