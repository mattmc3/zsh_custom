function using-prezto() {
  if [[ -n "$ZPREZTODIR" ]] && [[ -d "$ZPREZTODIR" ]]; then
    return 0
  else
    return 1
  fi
}

function using-omz() {
  if [[ -n "$ZSH" ]] && [[ -d "$ZSH" ]]; then
    return 0
  else
    return 1
  fi
}

function using-antibody() {
  if [[ -n "$ANTIBODY_HOME" ]] && [[ -d "$ANTIBODY_HOME" ]]; then
    return 0
  else
    return 1
  fi
}

function extend-framework-plugin() {
  plugin="$1"

  if [[ -n "$ZPREZTODIR" ]] && [[ -d "$ZPREZTODIR" ]]; then
    # extend a prezto module
    [[ -d "$ZPREZTODIR/modules/${plugin}" ]] || return
    fpath=("$ZPREZTODIR"/modules/${plugin}/functions $fpath)
    local _zfunc
    for _zfunc in "$ZPREZTODIR"/modules/${plugin}/functions/*(.N); do
      autoload -Uz "$_zfunc"
    done
    source $ZPREZTODIR/modules/${plugin}/init.zsh
  elif [[ -n "$ZSH" ]] && [[ -d "$ZSH" ]]; then
    # extend oh-my-zsh module
    [[ -d "$ZSH/plugins/${plugin}" ]] || return
    source $ZSH/plugins/${plugin}/${plugin}.plugin.zsh
  fi
}
