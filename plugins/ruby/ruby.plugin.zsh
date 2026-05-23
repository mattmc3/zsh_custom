#
# ruby
#

# Ruby is keg-only
[[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}" ]] || return

: ${HOMEBREW_PREFIX:=/opt/homebrew}
path+=(
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
  $path
)

# eval "$(rbenv init - --no-rehash zsh)"
if (( ${+commands[rbenv]} )); then
  [[ -d "$HOME/.rbenv" ]] || rbenv init
  export PATH="$HOME/.rbenv/shims:${PATH}"
  export RBENV_SHELL=zsh
  rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval "$(rbenv "sh-$command" "$@")";;
    *)
      command rbenv "$command" "$@";;
    esac
  }
fi
