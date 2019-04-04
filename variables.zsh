# exports
export TZ="${TZ:-America/New_York}"
export TERM="${TERM:-xterm-256color}"

# Preferred editor for local and remote sessions
export EDITOR='${EDITOR:-vim}'
export PAGER='${PAGER:-less}'

# Set path
path=(
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  $path
)

typeset -gxU path
