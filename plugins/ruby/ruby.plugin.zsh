#
# ruby
#

# Ruby is keg-only
[[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}" ]] || return

path+=(
  ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/ruby/bin(N)
  ${HOMEBREW_PREFIX:-/opt/homebrew}/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)
