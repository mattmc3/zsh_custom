#
# Emacs
#

# Add emacs to path
path+=(
  # emacs
  $HOME/.emacs.d/bin(N)
  $XDG_CONFIG_HOME/emacs/bin(N)
)

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:emacs' loaded 'yes'
