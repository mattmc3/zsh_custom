#
# clipboard: Add clipboard utils.
#

source $ZSH/plugins/copybuffer/copybuffer.plugin.zsh
source $ZSH/plugins/copyfile/copyfile.plugin.zsh
source $ZSH/plugins/copypath/copypath.plugin.zsh

# OMZ's clipcopy/clippaste already handle every platform.
if (( ! $+commands[pbcopy] )); then
  alias pbcopy=clipcopy
  alias pbpaste=clippaste
fi
