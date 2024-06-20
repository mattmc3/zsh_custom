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
zstyle -T ':zsh_custom:plugin:editor' dot-expansion ||
  zstyle ':zsh_custom:plugin:editor' dot-expansion 'yes'

# Use Prezto's editor module.
source ${0:A:h}/external/prezto_editor.zsh

# 16.2.6 Input/Output
setopt interactive_comments  # Enable comments in interactive shell.
setopt rc_quotes             # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_flow_control       # Disable start/stop characters (usually ^Q/^S) in shell editor.
setopt NO_mail_warning       # Don't print a warning message if a mail file has been accessed.

# 16.2.12 Zle
setopt combining_chars       # Combine 0-len chars with the base character (eg: accents).
setopt NO_beep               # Do not beep on error in line editor.
