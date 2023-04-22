# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# customizations
zstyle ':zsh_custom:plugin:prompt' theme 'starship'
zstyle ':zsh_custom:plugin:prompt' config 'hydro'
ZSH_CUSTOM=$ZDOTDIR/custom
ZUNPLUG_SHORTEN=0

# Libs
for zfile in $ZSH_CUSTOM/lib/*.zsh(N); source $zfile
unset zfile

# plugins
myplugins=(
  # load plugins
  zfunctions
  prompt
  clipboard
  directory
  editor
  history
  utility
  terminal
  z
  homebrew
  macos
  python
  completion

  _defer_
  abbreviations
  syntax-highlighting
  autosuggestions
  history-substring-search
)
plugin-load $myplugins

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
