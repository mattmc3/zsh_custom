function using-prezto() {
  if [[ -n "$ZPREZTODIR" ]] && [[ -d "$ZPREZTODIR" ]]; then
    return 0
  else
    return 1
  fi
}

function using-omz() {
  if ! using-antibody && ! using-prezto && [ -n "$ZSH" ]] && [[ -d "$ZSH" ]]; then
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

function autoload-functions-dir() {
  if [[ using-prezto ]]; then
    # prezto already does this, so we don't have to
    return
  fi
  local plugin="$1"
  if [[ -z "$ZSH_CUSTOM" ]] || [[ ! -d "$ZSH_CUSTOM" ]]; then
    return 1
  fi
  if [[ -d "$ZSH_CUSTOM"/plugins/${plugin}/functions ]]; then
    __autoload-funcs-in-dir "$plugin"
  fi
}

function __autoload-funcs-in-dir() {
  if [[ -d "$1" ]]; then
    fpath=("$1" $fpath)
    local f
    for f in "$1"/*(.N); do
      autoload -Uz "$f"
    done
  fi
}

function extend-framework-plugin() {
  local plugin="$1"

  if [[ -n "$ZPREZTODIR" ]] && [[ -d "$ZPREZTODIR" ]]; then
    # extend a prezto module. prezto loads functions in the child plugin, but
    # not the parent one
    [[ -d "$ZPREZTODIR/modules/${plugin}" ]] || return
    __autoload-funcs-in-dir "$ZPREZTODIR/modules/${plugin}/functions"
    source $ZPREZTODIR/modules/${plugin}/init.zsh
  elif [[ -n "$ZSH" ]] && [[ -d "$ZSH" ]]; then
    # extend oh-my-zsh module. omz does't have functions in the parent plugin
    # in the same way, but let's support it in the child plugin
    [[ -d "$ZSH/plugins/${plugin}" ]] || return
    source $ZSH/plugins/${plugin}/${plugin}.plugin.zsh
    __autoload-funcs-in-dir "$ZSH_CUSTOM"/plugins/${plugin}/functions
  fi
}
