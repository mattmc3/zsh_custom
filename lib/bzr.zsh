[ -e $ZSH/lib/bzr.zsh ] && . $ZSH/lib/bzr.zsh

# cheat and hijack bzr for our own purposes
for confd in $ZSH_CUSTOM/conf.d/*.zsh(.N); do
  source $confd
done
unset confd
