# hijack OMZ's bzr for our __init__
0=${(%):-%N}
source ${0:A:h}/__init__.zsh
source $ZSH/lib/bzr.zsh
