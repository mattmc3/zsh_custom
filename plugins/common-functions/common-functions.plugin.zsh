up() {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    local CDSTR=""
    for i in {1..$1} ; do
      CDSTR="../$CDSTR"
    done
    cd $CDSTR
  fi
}

# 'ls' after 'cd'
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
  if [[ "$LS_AFTER_CD" == "true" ]]; then
    emulate -L zsh
    ls
  fi
}
