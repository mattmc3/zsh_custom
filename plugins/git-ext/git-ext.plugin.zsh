# I don't care for all the aliases in the existing omz git plugin

alias get="git"
alias gadd="git add ."
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias sourcetree='open -a SourceTree'

function g {
  if [[ "$#" -eq 0 ]]; then
    git status
  else
    git "$@"
  fi
}

function gacp {
  local yn reply curbranch

  if [[ "$#" -ne 1 ]]; then
    echo "gacp: Expecting commit message" >&2
    return 1
  fi

  curbranch=$(git -C "$PWD" rev-parse --abbrev-ref HEAD)
  if [[ $? -ne 0 ]]; then
    echo "gacp: Not in a git repo" >&2
    return 1
  fi

  if [[ "$curbranch" = "master" ]]; then
    while true; do
      read "?You are about to add/commit/push to master. Are you sure? [y/n] " yn
      case $yn in
        [Yy]* ) break;;
        [Nn]* ) return 1;;
        * ) echo "Please answer yes or no.";;
      esac
    done
  fi

  git add .
  git commit -am "$1"
  git push
}
