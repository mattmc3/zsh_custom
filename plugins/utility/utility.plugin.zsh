#
# utility - Built-in Zsh shell utilities, and cross-platform utils.
#

# References:
# - https://github.com/belak/zsh-utils/blob/main/utility/utility.plugin.zsh
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh
# - https://github.com/mattmc3/zephyr/blob/main/plugins/utility/utility.plugin.zsh

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

# Ensure python command exists.
if ! is-callable python && is-callable python3; then
  alias python=python3
fi

# Ensure envsubst command exists.
if ! is-callable envsubst && is-callable python; then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi

# Ensure hd (hex dump) command exists.
if ! is-callable hd && is-callable hexdump; then
  alias hd="hexdump -C"
fi

# Ensure open command exists.
if ! is-callable open; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif (( $+commands[xdg-open] )); then
    alias open='xdg-open'
  fi
fi

# Ensure pbcopy/pbpaste commands exist.
if ! is-callable pbcopy; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias pbcopy='tee > /dev/clipboard'
    alias pbpaste='cat /dev/clipboard'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias pbcopy='termux-clipboard-set'
    alias pbpaste='termux-clipboard-get'
  elif (( $+commands[wl-copy] && $+commands[wl-paste] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  fi
fi

# Cross-platform sed -i syntax
function sedi {
  # GNU/BSD
  sed --version &>/dev/null && sed -i -- "$@" || sed -i "" "$@"
}
