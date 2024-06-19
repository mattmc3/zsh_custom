#
# editor - Set keybindings.
#

# References:
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh

# Return if requirements are not found.
[[ "$TERM" != 'dumb' ]] || return 1

# Set zero.
0=${(%):-%N}

# Enable ../.. dot-expansion unless explicitly disabled
zstyle -T ':zsh_custom:module:editor' dot-expansion ||
  zstyle ':zsh_custom:module:editor' dot-expansion 'yes'

# Use Prezto's editor module.
source ${0:A:h}/external/prezto_editor.zsh
