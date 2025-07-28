#
# git
#

# References
# - https://www.oliverspryn.com/blog/adding-git-completion-to-zsh

function update_git_completions {
  emulate -L zsh
  # Download the git scripts
  local giturl=https://raw.githubusercontent.com/git/git/master/contrib/completion
  local dest=${1:-$ZSH_CUSTOM/plugins/git/completions}
  [[ -d $dest ]] || mkdir -p $dest
  curl -fsSL $giturl/git-completion.bash -o $dest/git-completion.bash
  curl -fsSL $giturl/git-completion.zsh -o $dest/_git
}

# Add completions
fpath=(${0:a:h}/completions $fpath)
[[ -f ${fpath[1]}/_git ]] || update_git_completions
zstyle ':completion:*:*:git:*' script ${fpath[1]}/git-completion.bash

# Aliases
if ! zstyle -t ':zsh_custom:plugin:git:alias' skip; then
  alias gad="git add"
  alias gbn="git rev-parse --abbrev-ref HEAD"
  alias gcd1="git clone --depth 1 https://github.com/"
  alias gcl="git clean"
  alias gclone="git clone git@github.com:mattmc3/"
  alias gcmt="git commit -am "
  alias gco="git checkout"
  alias gcob="git checkout -b "
  alias gcod="git checkout develop"
  alias gcom="git checkout main"
  alias get="git"
  alias glg="git log"
  alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
  alias gpll="git pull"
  alias gpristine="git reset --hard && git clean -fdx"
  alias gpsh="git push"
  alias gpsuo="git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)"
  alias grv="git remote -v"
  alias gsh="git stash"
  alias gst="git status -sb"
fi

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:git' loaded 'yes'
