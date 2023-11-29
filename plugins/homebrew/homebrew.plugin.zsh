#
# homebrew - Environment variables and functions for homebrew users.
#

#
# References
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# https://github.com/sorin-ionescu/prezto/tree/master/modules/homebrew

#
# Requirements
#

# homebrew
if [[ -e ~/brew/bin/brew ]]; then
  HOMEBREW_PREFIX=$HOME/brew
  path=(/opt/homebrew/bin $path)
elif [[ -e /opt/homebrew/bin/brew ]]; then
  HOMEBREW_PREFIX=/opt/homebrew
else
  return 1
end

# Setup cache dir.
_cache_dir=${XDG_CACHE_HOME:=$HOME/.cache}/zsh
[[ -d $_cache_dir ]] || mkdir -p $_cache_dir

#
# Variables
#

HOMEBREW_NO_ANALYTICS=${HOMEBREW_NO_ANALYTICS:-1}

#
# Functions
#

# Load plugin functions.
0=${(%):-%N}
fpath=(${0:A:h}/functions $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)

#
# Aliases
#

alias brewup="brew update && brew upgrade && brew cleanup"

#
# Init
#

# Generate a new cache file daily of just the 'HOMEBREW_' vars.
typeset -a _cache_files=($_cache_dir/brew_shellenv.zsh(Nmh-20))
if ! (( $#_cache_files )); then
  $HOMEBREW_PREFIX/bin/brew shellenv 2> /dev/null >| $_cache_dir/brew_shellenv.zsh
  grep "export HOMEBREW_" $_cache_dir/brew_shellenv.zsh >| $_cache_dir/brew_exclpaths.zsh
fi

# Allow a user to do their own shellenv setup.
if ! zstyle -t ':zsh_custom:plugin:homebrew:shellenv' skip; then
  if zstyle -t ':zsh_custom:plugin:homebrew:shellenv' 'include-paths'; then
    source $_cache_dir/brew_shellenv.zsh
  else
    source $_cache_dir/brew_exclpaths.zsh
  fi
fi

#
# Clean up
#

unset _cache_{dir,files}
