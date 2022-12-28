###
# zsh_custom initialization.
###

0=${(%):-%x}
ZSH_CUSTOM="${ZSH_CUSTOM:-$0:A:h:h}"
ZPLUGINDIR=$ZSH_CUSTOM/.external

# Load functions directory
fpath+="$ZSH_CUSTOM/functions"
autoload -Uz autoload-dir
autoload-dir "$ZSH_CUSTOM/functions"

# clone all external plugins
repos=(
  # prompts
  sindresorhus/pure
  romkatv/powerlevel10k

  # utils
  romkatv/zsh-defer
  romkatv/zsh-bench

  # plugins
  olets/zsh-abbr
  olets/zsh-window-title
  rupa/z
  mattmc3/zman
  zshzoo/macos
  kaelzhang/shell-safe-rm

  # frameworks
  belak/zsh-utils
  ohmyzsh/ohmyzsh

  # core
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
  zdharma-continuum/fast-syntax-highlighting
)
plugin-clone $repos

() {
  # https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
  local gitdir=$ZSH_CUSTOM/.external/git
  if (( ${+commands[curl]} )) && [[ ! -d $gitdir ]]; then
    mkdir -p $gitdir

    # Download the latest git completion scripts
    curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $gitdir/git-completion.bash
    curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o $gitdir/_git
  fi
}

if (( ! $+functions[zsh-defer] )); then
  function zsh-defer {
    source $ZSH_CUSTOM/.external/zsh-defer/zsh-defer.plugin.zsh
    zsh-defer "$@"
  }
fi

# Update weekly.
plugin-updatecheck
