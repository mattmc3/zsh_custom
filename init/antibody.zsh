#
# antibody: The new version
#

typeset -gU fpath path
if ! (( $+commands[antibody] )); then
  path=(/opt/homebrew/bin(N) $path)
fi

if ! (( $+commands[antibody] )); then
  echo >&2 "__init__: antibody command not found. many plugins will not work."
  return 1
fi
source <(antibody init)

OMZ_SHA=e7aa0c56e68348afefdd6af4c5bdb314a2bd6640
