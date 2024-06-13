#
# homebrew: Environment variables and functions for homebrew users.
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/homebrew

# Where is brew?
# Setup homebrew if it exists on the system.
typeset -aU _brewcmd=(
  $commands[brew]
  $HOME/.homebrew/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
  /home/linuxbrew/.linuxbrew/bin/brew(N)
)
(( ${#_brewcmd} )) || return 1

if (( $+functions[cached-eval] )) && zstyle -T ':zsh_custom:plugin:homebrew' 'use-cache'; then
  cached-eval 'brew_shellenv' $_brewcmd[1] shellenv
else
  source <($_brewcmd[1] shellenv)
fi
unset _brewcmd

# Build remaining path.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/bin(N)
  $HOMEBREW_PREFIX/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Default to no tracking.
HOMEBREW_NO_ANALYTICS=${HOMEBREW_NO_ANALYTICS:-1}

# Add brewed Zsh to fpath
if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

# Set functions and aliases.
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewinfo="brew leaves | xargs brew desc --eval-all"

# Multi-user brews.
brew_owner=$(stat -f "%Su" $HOMEBREW_PREFIX)
if [[ $(whoami) != $brew_owner ]]; then
  alias brew="sudo -Hu '$brew_owner' brew"
fi
unset brew_owner

##? Show brewed apps.
function brews {
  local formulae="$(brew leaves | xargs brew deps --installed --for-each)"
  local casks="$(brew list --cask 2>/dev/null)"

  local blue="$(tput setaf 4)"
  local bold="$(tput bold)"
  local off="$(tput sgr0)"

  echo "${blue}==>${off} ${bold}Formulae${off}"
  echo "${formulae}" | sed "s/^\(.*\):\(.*\)$/\1${blue}\2${off}/"
  echo "\n${blue}==>${off} ${bold}Casks${off}\n${casks}"
}

# Mark this plugin as loaded.
zstyle ':zsh_custom:plugin:homebrew' loaded 'yes'
