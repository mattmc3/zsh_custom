# the original file has a ton of garbage just to set a simple grep alias
if [[ "$OSTYPE" == darwin* ]]; then
  alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
else
  . $ZSH/lib/grep.zsh
fi
