#
# XDG base dirs - don't pollute home
#

0=${(%):-%N}

# Builtin mkdir, so a new shell doesn't fork /bin/mkdir. Apps sourced below
# use it too, and fall back to the real mkdir if zsh/files is unavailable.
zmodload -F zsh/files b:zf_mkdir 2>/dev/null ||
  zf_mkdir() { command mkdir "$@" }

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
for _xdg_dir in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME; do
  [[ -d $_xdg_dir ]] || zf_mkdir -p $_xdg_dir
done
unset _xdg_dir

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR="/tmp/xdg-runtime-$UID"
fi
if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
  zf_mkdir -m 700 -p "$XDG_RUNTIME_DIR"
elif [[ ! -O "$XDG_RUNTIME_DIR" || -L "$XDG_RUNTIME_DIR" ]]; then
  print -u2 "use-xdg-basedirs: $XDG_RUNTIME_DIR is a symlink or not owned by uid $UID"
fi

typeset -g _XDG_BASEDIRS_DIR="${0:a:h}"
fpath=("$_XDG_BASEDIRS_DIR/functions" $fpath)
autoload -Uz xdgbasedir

# Apps are opt-in, and nothing here moves an app's files. Run xdgbasedir to see
# what is on, what is safe to turn on, and what would shadow files you still
# have in your home directory.
#   zstyle ':use-xdg-basedirs:cargo' enabled yes
for _xdg_app in "$_XDG_BASEDIRS_DIR/apps"/*.zsh(N); do
  zstyle -t ":use-xdg-basedirs:${_xdg_app:t:r}" enabled && source "$_xdg_app"
done
unset _xdg_app
