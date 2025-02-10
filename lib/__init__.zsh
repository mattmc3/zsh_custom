# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# clone external plugins/themes
function zsh_custom_clone {
  emulate -L zsh
  setopt local_options no_monitor pipefail
  local repo dest
  dest="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/$1"; shift
  mkdir -p "$dest"
  for repo in $@; do
    if [[ ! -d $dest/${repo:t} ]]; then
      git -C $dest clone --quiet --recursive --depth 1 https://github.com/$repo &
    fi
  done
  wait
}

zsh_custom_clone plugins \
  aloxaf/fzf-tab \
  jeffreytse/zsh-vi-mode \
  kaelzhang/shell-safe-rm \
  mattmc3/zman \
  romkatv/zsh-no-ps2 \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-history-substring-search

zsh_custom_clone themes \
  romkatv/powerlevel10k

zsh_custom_clone .external \
  kaelzhang/shell-safe-rm \
  romkatv/zsh-bench
