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
