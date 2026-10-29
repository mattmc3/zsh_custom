# old: ~/.virtualenvs
export WORKON_HOME=${WORKON_HOME:-$XDG_DATA_HOME/venvs}
# old: ~/.ipython
export IPYTHONDIR=${IPYTHONDIR:-$XDG_CONFIG_HOME/ipython}
# pylint 2.10+ already caches under XDG. Only the config lookup is hardcoded.
# old: ~/.pylintrc
export PYLINTRC=${PYLINTRC:-$XDG_CONFIG_HOME/pylint/pylintrc}
# Python 3.13+ skips history entirely if the parent dir is missing
# old: ~/.python_history
export PYTHON_HISTORY=${PYTHON_HISTORY:-$XDG_STATE_HOME/python_history}
