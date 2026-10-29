# old: ~/.screenrc
export SCREENRC=${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}
# Sockets only, and the old location was a temp dir.
export SCREENDIR=${SCREENDIR:-$XDG_RUNTIME_DIR/screen}
