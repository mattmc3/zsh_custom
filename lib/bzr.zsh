# We hijack bzr.zsh to run our custom __init__
0=${(%):-%N}
source ${0:a:h}/__init__.zsh
source $ZSH/lib/bzr.zsh
