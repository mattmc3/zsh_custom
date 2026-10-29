# rg warns on stderr every run if this names a file that is not there, and it
# never creates one. No legacy location in the home directory.
[[ -f $XDG_CONFIG_HOME/ripgrep/config ]] &&
  export RIPGREP_CONFIG_PATH=${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgrep/config}
