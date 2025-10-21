#
# clipboard: Add clipboard utils.
#

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Ensure pbcopy/pbpaste commands exist.
if ! (( $+commands[pbcopy] )); then
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

# copy a file
copyfile() {
  emulate -L zsh

  if [[ -z "$1" ]]; then
    echo "Usage: copyfile <file>"
    return 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "Error: '$1' is not a valid file."
    return 1
  fi

  cat "$1" | pbcopy
  echo ${(%):-"%B$1%b copied to clipboard."}
}

# Copies the path of given directory or file to the system or X Windows clipboard.
# Copy current directory if no parameter.
copypath() {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If pbcopy fails, exit the function with an error
  print -n "${file:a}" | pbcopy || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

# copy a buffer
copybuffer() {
  if builtin which pbcopy &>/dev/null; then
    printf "%s" "$BUFFER" | pbcopy && zle -M "Copied ${#BUFFER} chars to clipboard."
  else
    zle -M "pbcopy not found."
  fi
}
zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:clipboard' loaded 'yes'
