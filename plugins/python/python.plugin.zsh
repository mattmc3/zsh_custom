#
# python - Aliases and functions for python
#

export WORKON_HOME="$XDG_DATA_HOME/venvs"
[[ -d "$WORKON_HOME" ]] || mkdir -p "$WORKON_HOME"

# Load plugin functions.
fpath=(${0:A:h}/functions $fpath)
autoload -U $fpath[1]/*(.:t)

# Ensure python command exists.
if (( $+commands[python3] )) && ! (( $+commands[python] )); then
  alias python=python3
fi
if (( $+commands[pip3] )) && ! (( $+commands[pip] )); then
  alias pip=pip3
fi

alias pipup="pip list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# jupyter
: ${JUPYTER_CONFIG_DIR:=${XDG_CONFIG_HOME:-$HOME/.config}/jupyter}
export JUPYTER_CONFIG_DIR
