##? up - go up any number of directories
##?
##? usage:
##?   up [<num>]

# works in both bash and zsh
up() {
  local parents=${1:-1}
  if ! (( "$parents" > 0 )); then
    echo >&2 "up: expecting a numeric parameter"
    return 1
  fi
  local i dotdot=".."
  for ((i = 1 ; i < parents ; i++)); do
    dotdot+="/.."
  done
  cd $dotdot
}

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:up' loaded 'yes'
