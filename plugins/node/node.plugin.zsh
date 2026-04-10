#
# node
#

path+=(
  /{opt/homebrew,usr/local}/share/npm/bin(N)
)
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-${XDG_STATE_HOME:-$HOME/.local/state}/nodejs/repl_history}"
[[ -d ${NODE_REPL_HISTORY:h} ]] || mkdir -p ${NODE_REPL_HISTORY:h}
