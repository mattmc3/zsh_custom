#
# macos: Functionality for macOS users.
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/osx

# Return if requirements are not met.
[[ "$OSTYPE" == darwin* ]] || return 1

function cdf() {
  # Change to the current Finder directory.
  cd "$(pfd)"
}

function pushdf() {
  # Push the current Finder directory to the dirstack.
  pushd "$(pfd)"
}

function rmdsstore() {
  # Remove .DS_Store files recursively in a directory.
  find "${@:-.}" -type f -name .DS_Store -delete
}
