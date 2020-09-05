# general
export TZ="America/New_York"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL='code'
export PAGER='less'

export CLICOLOR="1"
export LSCOLORS="ExfxcxdxbxGxDxabagacad"
