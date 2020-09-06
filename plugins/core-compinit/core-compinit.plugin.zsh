_zz_compinit() {
  # https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L41
  # http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
  # https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed if dump is newer or
  # missing. Do in background for next time to not affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
    compinit -i -d "$zcd"
    { command rm -f "$zcdc" && zcompile "$zcd" } &!
  else
    compinit -i -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && command rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
_zz_compinit
unfunction _zz_compinit
