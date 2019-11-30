if [[ -n "$XDG_DATA_HOME" ]]; then
  [[ -d "$XDG_DATA_HOME"/z ]] || mkdir -p "$XDG_DATA_HOME"/z
  export _Z_DATA="$XDG_DATA_HOME"/z/data
else
  export _Z_DATA="$HOME"/.z
fi

source $ZSH/plugins/z/z.plugin.zsh
