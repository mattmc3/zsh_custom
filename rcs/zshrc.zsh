# init profiling
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# repo location
export REPO_HOME=${XDG_CACHE_HOME:-$HOME/.cache}/repos

# Oh My Zsh locations
export ZSH=$REPO_HOME/ohmyzsh/ohmyzsh
export ZSH_CUSTOM=$ZDOTDIR/custom

# autoload functions
fpath+=($ZSH_CUSTOM/functions)
autoload -Uz $ZSH_CUSTOM/functions/*(.:t)

# clone repos
[[ -d $REPO_HOME ]] || repo in <$ZSH_CUSTOM/repos.txt

# plugins
plugins=(
  # pre-reqs
  p10k-instant-prompt
  confd
  zfunctions
  xdg

  # utils
  clipboard
  macos
  magic-enter
  fancy-ctrl-z
  extract

  # plugins
  directory
  editor
  history
  prompt
  utility
  brew
  autosuggestions
  syntax-highlighting
  history-substring-search
)

plugin-load $plugins

# prompt
prompt p10k lean

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# done profiling
[[ -z "$ZPROFRC" ]] || zprof

# cleanup
unset ZPROFRC
true
