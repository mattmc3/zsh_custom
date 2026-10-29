# jupyter_core >= 5.0 needs this to place config, data, and runtime under XDG.
# Ignored by >= 6.0, which does it by default.
export JUPYTER_PLATFORM_DIRS=${JUPYTER_PLATFORM_DIRS:-1}
# old: ~/.jupyter
export JUPYTER_CONFIG_DIR=${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}
