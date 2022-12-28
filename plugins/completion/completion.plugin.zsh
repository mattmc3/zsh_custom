####
# completion - Set up zsh completions.
###

0=${(%):-%x}
: ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:=$HOME/.cache}/zsh/compdump}
[[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

fpath=(
  # add git completions if they exist
  $ZSH_CUSTOM/.external/git(/N)

  # add curl completions from homebrew if they exist
  /{usr,opt}/{local,homebrew}/opt/curl/share/zsh/site-functions(-/FN)

  # add zsh completions
  /{usr,opt}/{local,homebrew}/share/zsh/site-functions(-/FN)

  # add zsh-users completions if they exist
  $ZSH_CUSTOM/.external/zsh-completion/src(-/FN)

  # Allow user completions.
  ${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/completions(-/FN)
  $ZSH_CUSTOM/completions(-/FN)

  # this plugin and rest of fpath
  ${0:A:h}/functions
  $fpath
)

# Use zsh-utils completion.
source $ZSH_CUSTOM/.external/zsh-utils/completion/completion.plugin.zsh

# override compstyle functionality
autoload-dir ${0:A:h}/functions
function compstyleinit() {}
function compstyle {
  compstyle_${1}_setup
}

# Set additional compstyles
zstyle ':completion:*:*:git:*' script $ZSH_CUSTOM/.external/git/git-completion.bash

# Compile compdump, if modified, in background to increase startup speed.
{
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!
