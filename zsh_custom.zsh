# OMZ init to make OMZ better.
[[ -n "$ZSH_COMPDUMP" ]] || ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-omz"

# Instant prompt
if [[ $ZSH_THEME == powerlevel10k ]]; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# Grab plugins in the user/repo form.
function clone-missing {
  emulate -L zsh; setopt local_options no_monitor
  local repodir repo
  for repo in ${(M)@:#*/*}; do
    repodir="$ZSH_CUSTOM/.external/${repo}"
    if [ ! -d "$repodir" ]; then
      echo "Cloning plugin $repo..."
      git clone --quiet --depth 1 "https://github.com/${repo}" "$repodir" &
    fi
  done
  wait
}

# Load a repo plugin.
function plugin-load {
  source "$ZSH_CUSTOM/.external/${1}/${1:t}.plugin.zsh"
}

# Read the file into the array, skipping blank lines and lines starting with '#'
() {
  local line
  local -a repos=()
  while IFS= read -r line || [ -n "$line" ]; do
    line=${line%\#*}
    repos+=($line)
  done < "$ZSH_CUSTOM/repos.txt"
  clone-missing $repos
}

# Completions
fpath=(
  # add curl completions from homebrew if they exist
  /{usr,opt}/{local,homebrew}/opt/curl/share/zsh/site-functions(-/FN)

  # add zsh completions
  /{usr,opt}/{local,homebrew}/share/zsh/site-functions(-/FN)

  # Allow custom user completions.
  ${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/completions(-/FN)
  ${ZSH_CUSTOM:-$ZDOTDIR/custom}/completions(-/FN)

  # the rest of fpath
  $fpath
)
