#
# git
#

# References
# - https://www.oliverspryn.com/blog/adding-git-completion-to-zsh

0=${(%):-%N}

function update_git_completions {
  emulate -L zsh
  # Download the git scripts
  local giturl=https://raw.githubusercontent.com/git/git/master/contrib/completion
  local dest=${1:-${MY_ZSH_CUSTOM:-?}/plugins/git/completions}
  [[ -d $dest ]] || mkdir -p $dest
  curl -fsSL $giturl/git-completion.bash -o $dest/git-completion.bash
  curl -fsSL $giturl/git-completion.zsh -o $dest/_git
}

# Add completions
fpath=(${0:a:h}/completions $fpath)
[[ -f ${fpath[1]}/_git ]] || update_git_completions
zstyle ':completion:*:*:git:*' script ${fpath[1]}/git-completion.bash

# Normalize single-dash to double-dash so 'git clone -<TAB>' works
_git_with_dash_fix() {
  if [[ ${words[CURRENT]} == - ]]; then
    words[CURRENT]='--'
    if (( CURRENT == 2 )); then
      _git "$@"
      compadd -o nosort -- '-C' '-c'
      return
    fi
  fi
  _git "$@"
}
compdef _git_with_dash_fix git gitk

# Functions
autoload-dir ${0:a:h}/functions
