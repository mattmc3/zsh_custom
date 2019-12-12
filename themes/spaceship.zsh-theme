0=${(%):-%N}
if [[ ! -d "${0:A:h}/spaceship-prompt" ]]; then
  git clone --depth=1 --recursive https://github.com/denysdovhan/spaceship-prompt.git "${0:A:h}/spaceship-prompt"
fi
source ${0:A:h}/spaceship-prompt/spaceship.zsh-theme
fpath+=("${0:A:h}/spaceship-prompt")
SPACESHIP_CHAR_SYMBOL="%% "
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_PROMPT_ORDER=(
  char
)
SPACESHIP_RPROMPT_ORDER=(
  time
  user
  dir
  host
  git
  hg
  package
  node
  ruby
  elm
  elixir
  xcode
  swift
  golang
  php
  rust
  haskell
  julia
  docker
  aws
  venv
  conda
  pyenv
  dotnet
  ember
  kubecontext
  terraform
  exec_time
  line_sep
  battery
  vi_mode
  jobs
  exit_code
)
