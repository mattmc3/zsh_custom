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

# ruby bundler
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/bundle}"
export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/bundle}"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-${XDG_DATA_HOME:-$HOME/.local/share}/bundle}"

# ruby gems
export GEM_HOME="${GEM_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/gem}"
