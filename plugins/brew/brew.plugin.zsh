#
# brew: Environment variables and functions for homebrew users.
#

# Default to no tracking.
HOMEBREW_NO_ANALYTICS="${HOMEBREW_NO_ANALYTICS:-1}"

# Add keg-only completions to path/fpath
zstyle -a ':zdotdir:plugin:brew' 'keg-only-brews' '_kegonly' \
  || _kegonly=(curl ruby sqlite string-cli)
for _keg in $_kegonly; do
  path=($HOMEBREW_PREFIX/opt/${_keg}/bin(/N) $path)
  fpath=($HOMEBREW_PREFIX/opt/${_keg}/share/zsh/site-functions(/N) $fpath)
done
unset _keg{,only}

# Set brew aliases and functions.
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewinfo="brew leaves | xargs brew desc --eval-all"

function brewdeps() {
  emulate -L zsh; setopt local_options
  local bluify_deps='
    BEGIN { blue = "\033[34m"; reset = "\033[0m" }
          { leaf = $1; $1 = ""; printf "%s%s%s%s\n", leaf, blue, $0, reset}
  '
  brew leaves | xargs brew deps --installed --for-each | awk "$bluify_deps"
}

# Handle brew on multi-user Apple silicon.
if [[ "$HOMEBREW_PREFIX" == /opt/homebrew ]]; then
  # The (u$UID) qualifier matches only when the current user owns the prefix,
  # so the usual single-user case never forks. Looking up the owner's name is
  # left to zstat in the branch that actually needs it.
  _brew_mine=("$HOMEBREW_PREFIX"(N/u$UID))
  if (( ! $#_brew_mine )); then
    zmodload -F zsh/stat b:zstat
    typeset -A _brew_stat
    zstat -s -H _brew_stat -- "$HOMEBREW_PREFIX" 2>/dev/null
    [[ -z "$_brew_stat[uid]" ]] || alias brew="sudo -Hu '$_brew_stat[uid]' brew"
    unset _brew_stat
  fi
  unset _brew_mine
fi
